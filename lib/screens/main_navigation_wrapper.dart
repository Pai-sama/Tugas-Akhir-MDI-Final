import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../state/app_state.dart';
import 'home_screen.dart';
import 'quiz_prep_screen.dart';
import 'saved_screen.dart';

class MainNavigationWrapper extends StatefulWidget {
  final int initialTab;
  const MainNavigationWrapper({super.key, this.initialTab = 0});

  @override
  State<MainNavigationWrapper> createState() => MainNavigationWrapperState();
}

class MainNavigationWrapperState extends State<MainNavigationWrapper> {
  late int _currentIndex;

  final List<Widget> _screens = [
    const HomeScreen(),
    const QuizPrepScreen(),
    const SavedScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  void setTab(int index) {
    if (index == 1) {
      Provider.of<AppState>(context, listen: false).startQuiz(null);
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isEn = appState.isEnglish;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
          color: AppTheme.bgCream,
          border: Border(
            top: BorderSide(
              color: AppTheme.secondaryBeige.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.textDark.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(0, Icons.explore_outlined, Icons.explore_rounded, isEn ? 'Explore' : 'Eksplor'),
              _buildTabItem(1, Icons.quiz_outlined, Icons.quiz_rounded, isEn ? 'Quiz' : 'Kuis'),
              _buildTabItem(2, Icons.bookmark_outline_rounded, Icons.bookmark_rounded, isEn ? 'Saved' : 'Disimpan'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, IconData outlineIcon, IconData filledIcon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setTab(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
            : const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.highlightGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: isSelected
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    filledIcon,
                    color: AppTheme.primaryGreen,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    outlineIcon,
                    color: AppTheme.textMuted,
                    size: 22,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
