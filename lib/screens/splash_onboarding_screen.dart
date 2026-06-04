import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import 'main_navigation_wrapper.dart';
import '../state/app_state.dart';
import '../state/app_language.dart';

class SplashOnboardingScreen extends StatelessWidget {
  const SplashOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        final isEn = appState.isEnglish;
        
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF095E3C),
                  Color(0xFF053E26),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image.asset(
                            'assets/images/app_logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Text(
                      'Hidden Gem Village',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        isEn 
                          ? 'Authentic travel experiences in the heart of rural Indonesia.'
                          : 'Pengalaman wisata otentik di jantung pedesaan Indonesia.',
                        style: const TextStyle(
                          color: Color(0xFFC2E0D4),
                          fontSize: 16,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const Spacer(flex: 3),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 800),
                            pageBuilder: (context, animation, secondaryAnimation) => const MainNavigationWrapper(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeIn,
                                ),
                              );
                              var slideAnimation = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutCubic,
                                ),
                              );
                              return FadeTransition(
                                opacity: fadeAnimation,
                                child: SlideTransition(
                                  position: slideAnimation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFAF6F0),
                        foregroundColor: AppTheme.primaryGreen,
                        minimumSize: const Size.fromHeight(58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isEn ? 'Begin Journey' : 'Mulai Perjalanan',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        const Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            isEn ? 'Mindful Exploration' : 'Eksplorasi Bermakna',
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 11,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                      ],
                    ),

                    const Spacer(flex: 2),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => appState.setLanguage(AppLanguage.id),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: !isEn ? Colors.white.withOpacity(0.2) : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: !isEn ? Colors.white : Colors.white30,
                              ),
                            ),
                            child: Text(
                              '🇮🇩 ID',
                              style: TextStyle(
                                color: !isEn ? Colors.white : Colors.white70,
                                fontWeight: !isEn ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => appState.setLanguage(AppLanguage.en),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isEn ? Colors.white.withOpacity(0.2) : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isEn ? Colors.white : Colors.white30,
                              ),
                            ),
                            child: Text(
                              '🇬🇧 EN',
                              style: TextStyle(
                                color: isEn ? Colors.white : Colors.white70,
                                fontWeight: isEn ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}