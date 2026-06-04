import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/village.dart';
import '../models/quiz.dart';
import 'app_language.dart';
import '../data/app_data_id.dart';
import '../data/app_data_en.dart';
import '../data/quiz_data.dart';

class AppState extends ChangeNotifier {


  AppLanguage _language = AppLanguage.id;

  AppLanguage get language => _language;
  bool get isEnglish => _language == AppLanguage.en;

  void setLanguage(AppLanguage lang) {
    if (_language != lang) {
      _language = lang;
      if (_selectedCategory == 'Semua Desa' && lang == AppLanguage.en) {
        _selectedCategory = 'All Villages';
      } else if (_selectedCategory == 'All Villages' && lang == AppLanguage.id) {
        _selectedCategory = 'Semua Desa';
      } else if (_selectedCategory == 'Desa Adat' && lang == AppLanguage.en) {
        _selectedCategory = 'Traditional Village';
      } else if (_selectedCategory == 'Traditional Village' && lang == AppLanguage.id) {
        _selectedCategory = 'Desa Adat';
      } else if (_selectedCategory == 'Wisata Alam' && lang == AppLanguage.en) {
        _selectedCategory = 'Nature Tourism';
      } else if (_selectedCategory == 'Nature Tourism' && lang == AppLanguage.id) {
        _selectedCategory = 'Wisata Alam';
      }
      notifyListeners();
    }
  }

  final Set<String> _bookmarkedVillageIds = {};
  String _searchQuery = '';
  String _selectedCategory = 'Semua Desa';

  String? _activeQuizId;
  int _currentQuestionIndex = 0;
  List<int?> _selectedAnswers = [];
  bool _isAnswered = false;
  bool _isQuizFinished = false;
  List<int> _shuffledIndices = [];

  AppState() {
    _initQuizState();
    setupAuthListener();
  }

  void _initQuizState() {
    _selectedAnswers = [];
    _shuffledIndices = [];
  }

  List<Village> get villages => isEnglish ? villagesEn : villagesId;
  Set<String> get bookmarkedVillageIds => _bookmarkedVillageIds;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  List<Village> get filteredVillages {
    return villages.where((village) {
      final matchesSearch = village.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          village.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          village.province.toLowerCase().contains(_searchQuery.toLowerCase());
          
      bool matchesCategory = false;
      if (_selectedCategory == 'Semua Desa' || _selectedCategory == 'All Villages') {
          matchesCategory = true;
      } else {
          matchesCategory = village.category == _selectedCategory;
      }
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  bool isBookmarked(String id) => _bookmarkedVillageIds.contains(id);

  Future<void> toggleBookmark(String id) async {
    if (_bookmarkedVillageIds.contains(id)) {
      _bookmarkedVillageIds.remove(id);
    } else {
      _bookmarkedVillageIds.add(id);
    }
    notifyListeners();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'bookmarks': _bookmarkedVillageIds.toList(),
        }, SetOptions(merge: true));
      } catch (e) {
        debugPrint('Error saving bookmark: $e');
      }
    }
  }

  Future<void> loadBookmarks() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data();
          if (data != null && data['bookmarks'] != null) {
            final List<dynamic> bookmarks = data['bookmarks'];
            _bookmarkedVillageIds.clear();
            _bookmarkedVillageIds.addAll(bookmarks.map((e) => e.toString()));
            notifyListeners();
          }
        }
      } catch (e) {
        debugPrint('Error loading bookmarks: $e');
      }
    } else {
      _bookmarkedVillageIds.clear();
      notifyListeners();
    }
  }

  void setupAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        loadBookmarks();
      } else {
        _bookmarkedVillageIds.clear();
        notifyListeners();
      }
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  String? get activeQuizId => _activeQuizId;
  
  List<QuizQuestion> get quizQuestions {
    List<QuizQuestion> sourceList;
    if (_activeQuizId == null || _activeQuizId == 'global') {
      sourceList = isEnglish ? globalQuizEn : globalQuizId;
    } else {
      sourceList = isEnglish ? (villageQuizzesEn[_activeQuizId] ?? []) : (villageQuizzesId[_activeQuizId] ?? []);
    }
    
    if (_shuffledIndices.isEmpty || _shuffledIndices.length != sourceList.length) {
      return sourceList;
    }
    
    return _shuffledIndices.map((index) => sourceList[index]).toList();
  }

  int get currentQuestionIndex => _currentQuestionIndex;
  List<int?> get selectedAnswers => _selectedAnswers;
  bool get isAnswered => _isAnswered;
  bool get isQuizFinished => _isQuizFinished;

  QuizQuestion get currentQuestion => quizQuestions[_currentQuestionIndex];

  int get correctCount {
    int count = 0;
    for (int i = 0; i < quizQuestions.length; i++) {
      if (_selectedAnswers.length > i && _selectedAnswers[i] == quizQuestions[i].correctOptionIndex) {
        count++;
      }
    }
    return count;
  }

  int get incorrectCount {
    int count = 0;
    for (int i = 0; i < quizQuestions.length; i++) {
      if (_selectedAnswers.length > i && _selectedAnswers[i] != null && _selectedAnswers[i] != quizQuestions[i].correctOptionIndex) {
        count++;
      }
    }
    return count;
  }

  int get score {
    if (quizQuestions.isEmpty) return 0;
    return ((correctCount / quizQuestions.length) * 100).round();
  }

  void startQuiz([String? villageId]) {
    _activeQuizId = villageId;
    
    List<QuizQuestion> sourceList;
    if (_activeQuizId == null || _activeQuizId == 'global') {
      sourceList = isEnglish ? globalQuizEn : globalQuizId;
    } else {
      sourceList = isEnglish ? (villageQuizzesEn[_activeQuizId] ?? []) : (villageQuizzesId[_activeQuizId] ?? []);
    }
    
    _shuffledIndices = List.generate(sourceList.length, (index) => index);
    _shuffledIndices.shuffle();
    
    _currentQuestionIndex = 0;
    _selectedAnswers = List.filled(sourceList.length, null);
    _isAnswered = false;
    _isQuizFinished = false;
    
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    if (_isAnswered) return;
    _selectedAnswers[_currentQuestionIndex] = optionIndex;
    _isAnswered = true;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < quizQuestions.length - 1) {
      _currentQuestionIndex++;
      _isAnswered = _selectedAnswers.length > _currentQuestionIndex ? _selectedAnswers[_currentQuestionIndex] != null : false;
    } else {
      _isQuizFinished = true;
    }
    notifyListeners();
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      _isAnswered = true;
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _initQuizState();
    _isAnswered = false;
    _isQuizFinished = false;
    notifyListeners();
  }
}