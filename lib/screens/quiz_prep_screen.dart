import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../state/app_state.dart';
import 'active_quiz_screen.dart';

class QuizPrepScreen extends StatelessWidget {
  const QuizPrepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isEn = appState.isEnglish;
    
    final isVillageQuiz = appState.activeQuizId != null && appState.activeQuizId != 'global';
    final village = isVillageQuiz 
        ? appState.villages.firstWhere((v) => v.id == appState.activeQuizId) 
        : null;

    final title = isVillageQuiz 
        ? (isEn ? '${village!.name} Quiz' : 'Kuis ${village!.name}')
        : (isEn ? 'Global Knowledge Quiz' : 'Kuis Wawasan Global');
        
    final description = isVillageQuiz
        ? (isEn ? 'Test your knowledge about ${village!.name}. Questions will be randomized.' : 'Uji wawasanmu tentang ${village!.name}. Pertanyaan akan diacak.')
        : (isEn ? 'Test your knowledge about various hidden gem villages in Indonesia. The questions will be randomized.' : 'Uji wawasanmu tentang berbagai desa tersembunyi di Indonesia. Pertanyaan akan diacak setiap kali kamu memulai.');

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.highlightGreen.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isVillageQuiz ? Icons.library_books_rounded : Icons.quiz_rounded,
                    size: 60,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 16),
              
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    appState.startQuiz(appState.activeQuizId ?? 'global');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ActiveQuizScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_arrow_rounded, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        isEn ? 'Start Quiz' : 'Mulai Kuis',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}