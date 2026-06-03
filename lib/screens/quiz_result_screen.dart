import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../state/app_state.dart';
import '../state/app_language.dart';
import 'main_navigation_wrapper.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final score = appState.score;
    final correct = appState.correctCount;
    final incorrect = appState.incorrectCount;

    // Custom text based on score
    String resultTitle = appState.isEnglish ? 'Great!' : 'Hebat!';
    String resultSubtitle = appState.isEnglish ? 'You are getting to know Nusantara better.' : 'Kamu semakin mengenal Nusantara.';
    if (score == 100) {
      resultTitle = appState.isEnglish ? 'Perfect!' : 'Sempurna!';
      resultSubtitle = appState.isEnglish ? 'You are a true culture expert!' : 'Kamu adalah pakar budaya sejati!';
    } else if (score < 60) {
      resultTitle = appState.isEnglish ? 'Keep Learning!' : 'Terus Belajar!';
      resultSubtitle = appState.isEnglish ? 'Read the village profiles and try again.' : 'Baca profil desa lagi dan coba lagi ya.';
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Custom App Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        appState.setLanguage(appState.isEnglish ? AppLanguage.id : AppLanguage.en);
                      },
                      icon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.primaryGreen, width: 1.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          appState.isEnglish ? 'EN' : 'ID',
                          style: const TextStyle(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Hidden Gem Village',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
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

                const SizedBox(height: 40),

                // Circular Progress Score Gauge (Image 3)
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Outer Circular Track
                    SizedBox(
                      width: 170,
                      height: 170,
                      child: CircularProgressIndicator(
                        value: score / 100,
                        strokeWidth: 14,
                        backgroundColor: AppTheme.secondaryBeige.withOpacity(0.5),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                        strokeCap: StrokeCap.round,
                      ),
                    ),

                    // Inside texts
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$score',
                          style: const TextStyle(
                            fontSize: 54,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primaryGreen,
                            letterSpacing: -1,
                          ),
                        ),
                        Text(
                          appState.isEnglish ? 'out of 100' : 'dari 100',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textMuted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    // Gold Star Badge on Top Right
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.stars_rounded,
                          color: AppTheme.accentAmber,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Congratulations text
                Text(
                  resultTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.textDark,
                        fontWeight: FontWeight.w800,
                        fontSize: 26,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  resultSubtitle,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 32),

                // Benar & Salah Side-by-Side Cards
                Row(
                  children: [
                    // Correct Answers Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: AppTheme.cardWhite,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.01),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppTheme.highlightGreen,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: AppTheme.successGreen,
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              appState.isEnglish ? 'CORRECT' : 'BENAR',
                              style: const TextStyle(
                                color: AppTheme.textMuted,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$correct',
                              style: const TextStyle(
                                color: AppTheme.successGreen,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Incorrect Answers Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: AppTheme.cardWhite,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.01),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFCE8E6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: AppTheme.errorRed,
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              appState.isEnglish ? 'INCORRECT' : 'SALAH',
                              style: const TextStyle(
                                color: AppTheme.textMuted,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$incorrect',
                              style: const TextStyle(
                                color: AppTheme.errorRed,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),



                const SizedBox(height: 32),

                // Action Buttons
                // Primary: Kembali ke Beranda
                ElevatedButton(
                  onPressed: () {
                    appState.resetQuiz();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainNavigationWrapper(initialTab: 0),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(appState.isEnglish ? 'Back to Home' : 'Kembali ke Beranda'),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Secondary: Coba Lagi
                OutlinedButton(
                  onPressed: () {
                    appState.startQuiz(appState.activeQuizId);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryGreen,
                    side: const BorderSide(color: AppTheme.primaryGreen, width: 1.5),
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    appState.isEnglish ? 'Try Again' : 'Coba Lagi',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
