import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../state/app_state.dart';
import '../state/app_language.dart';
import 'quiz_result_screen.dart';

class ActiveQuizScreen extends StatelessWidget {
  const ActiveQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.isQuizFinished) {
      return const QuizResultScreen();
    }

    final question = appState.currentQuestion;
    final totalQuestions = appState.quizQuestions.length;
    final currentSelectedAnswer = appState.selectedAnswers[appState.currentQuestionIndex];
    final isAnswered = appState.isAnswered;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row (Custom App Bar)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cancel Button
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close_rounded, color: AppTheme.errorRed),
                        label: Text(
                          appState.isEnglish ? 'Cancel' : 'Batal',
                          style: const TextStyle(
                            color: AppTheme.errorRed,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: AppTheme.errorRed.withOpacity(0.1),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Text(
                        'Hidden Gem Village',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.primaryGreen,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.secondaryBeige, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/images/app_logo.png'),
                        ),
                      ),
                    ],
                ),

                const SizedBox(height: 24),

                // Culture Quiz Subtitle
                Text(
                  appState.activeQuizId != null && appState.activeQuizId != 'global'
                      ? (appState.isEnglish 
                          ? '${appState.villages.firstWhere((v) => v.id == appState.activeQuizId).name.toUpperCase()} QUIZ'
                          : 'KUIS ${appState.villages.firstWhere((v) => v.id == appState.activeQuizId).name.toUpperCase()}')
                      : (appState.isEnglish ? 'KNOWLEDGE QUIZ' : 'KUIS WAWASAN'),
                  style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    letterSpacing: 1.0,
                  ),
                ),

                const SizedBox(height: 6),

                // Progress Indicator Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appState.isEnglish
                          ? 'Question ${appState.currentQuestionIndex + 1} of $totalQuestions'
                          : 'Soal ${appState.currentQuestionIndex + 1} dari $totalQuestions',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: AppTheme.textDark,
                          ),
                    ),
                    Text(
                      appState.isEnglish
                          ? '${((appState.currentQuestionIndex) / totalQuestions * 100).toInt()}% Complete'
                          : '${((appState.currentQuestionIndex) / totalQuestions * 100).toInt()}% Selesai',
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Horizontal Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (appState.currentQuestionIndex) / totalQuestions,
                    backgroundColor: AppTheme.secondaryBeige,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                    minHeight: 6,
                  ),
                ),

                const SizedBox(height: 24),

                // Question Box Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.cardWhite,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo illustrating the question
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        child: Image.asset(
                          question.imagePath,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Question Text
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          question.question,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppTheme.textDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1.4,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Multiple Choice Option list (A, B, C, D)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    return _buildOptionButton(context, appState, index, question.options[index], question.correctOptionIndex, currentSelectedAnswer, isAnswered);
                  },
                ),

                const SizedBox(height: 24),

                // Next / Submit Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Muted review explanation if answered
                    if (isAnswered)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            question.explanation,
                            style: const TextStyle(
                              color: AppTheme.textMuted,
                              fontSize: 12,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: isAnswered
                          ? () {
                              appState.nextQuestion();
                            }
                          : null, // Disabled until answered
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAnswered ? AppTheme.primaryGreen : AppTheme.primaryGreen.withOpacity(0.4),
                        minimumSize: const Size(120, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            appState.currentQuestionIndex == totalQuestions - 1 
                                ? (appState.isEnglish ? 'Finish' : 'Selesai') 
                                : (appState.isEnglish ? 'Next' : 'Selanjutnya'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildOptionButton(
    BuildContext context,
    AppState state,
    int optionIndex,
    String optionText,
    int correctIndex,
    int? selectedIndex,
    bool isAnswered,
  ) {
    final letters = ['A', 'B', 'C', 'D'];
    final letter = letters[optionIndex];

    // Colors mapping based on interaction and correct/incorrect status
    Color cardBgColor = AppTheme.cardWhite;
    Color borderColor = AppTheme.secondaryBeige;
    Color letterBgColor = Colors.transparent;
    Color letterTextColor = AppTheme.textDark;
    Widget? suffixIcon;

    final isThisSelected = selectedIndex == optionIndex;
    final isCorrect = correctIndex == optionIndex;

    if (isAnswered) {
      if (isThisSelected) {
        if (isCorrect) {
          cardBgColor = AppTheme.highlightGreen;
          borderColor = AppTheme.successGreen;
          letterBgColor = AppTheme.successGreen;
          letterTextColor = Colors.white;
          suffixIcon = const Icon(Icons.check_circle_rounded, color: AppTheme.successGreen, size: 22);
        } else {
          cardBgColor = const Color(0xFFFCE8E6); // Light red
          borderColor = AppTheme.errorRed;
          letterBgColor = AppTheme.errorRed;
          letterTextColor = Colors.white;
          suffixIcon = const Icon(Icons.cancel_rounded, color: AppTheme.errorRed, size: 22);
        }
      } else if (isCorrect) {
        // Highlight correct option if user selected incorrectly
        cardBgColor = AppTheme.highlightGreen;
        borderColor = AppTheme.successGreen.withOpacity(0.5);
        letterBgColor = AppTheme.successGreen.withOpacity(0.2);
        letterTextColor = AppTheme.successGreen;
      }
    }

    return GestureDetector(
      onTap: () {
        if (!isAnswered) {
          state.selectAnswer(optionIndex);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            // Styled Circular Letter Index
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: letterBgColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isAnswered ? Colors.transparent : AppTheme.textMuted.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: letterTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Option Content Text
            Expanded(
              child: Text(
                optionText,
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),

            // Suffix Correct/Incorrect Icon if answered
            if (suffixIcon != null) suffixIcon,
          ],
        ),
      ),
    );
  }
}
