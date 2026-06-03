import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../state/app_state.dart';
import '../models/village.dart';
import '../state/app_language.dart';
import 'detail_screen.dart';
import 'main_navigation_wrapper.dart';
import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final villages = appState.filteredVillages;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

                const SizedBox(height: 20),

                // Search Bar Custom Container
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.cardWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.secondaryBeige.withOpacity(0.8), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, color: AppTheme.textMuted, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          onChanged: (val) => appState.setSearchQuery(val),
                          decoration: InputDecoration(
                            hintText: appState.isEnglish ? 'Search for unique villages...' : 'Cari desa unik...',
                            hintStyle: const TextStyle(color: AppTheme.textMuted, fontSize: 15),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Category Chips Horizontal Scroll
                SizedBox(
                  height: 42,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildCategoryChip(context, appState, appState.isEnglish ? 'All Villages' : 'Semua Desa'),
                      _buildCategoryChip(context, appState, appState.isEnglish ? 'Traditional Village' : 'Desa Adat'),
                      _buildCategoryChip(context, appState, appState.isEnglish ? 'Nature Tourism' : 'Wisata Alam'),
                    ],
                  ),
                ),

                // Section Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appState.isEnglish ? 'Village Recommendations' : 'Rekomendasi Desa',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.textDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Grid of Village Cards
                if (villages.isNotEmpty) ...[
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: villages.length,
                    itemBuilder: (context, index) {
                      final village = villages[index];
                      return _buildSmallCard(context, appState, village);
                    },
                  ),
                  const SizedBox(height: 24),
                ] else ...[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Column(
                        children: [
                          const Icon(Icons.search_off_rounded, size: 48, color: AppTheme.textMuted),
                          const SizedBox(height: 12),
                          Text(
                            appState.isEnglish ? 'Village not found' : 'Desa tidak ditemukan',
                            style: const TextStyle(
                              color: AppTheme.textMuted,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                // Dynamic Banner Card (Mulai Kuis)
                _buildQuizBannerCard(context, appState),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MapScreen()),
          );
        },
        backgroundColor: AppTheme.primaryGreen,
        child: const Icon(Icons.map_rounded, color: Colors.white),
        tooltip: appState.isEnglish ? 'Map View' : 'Lihat Peta',
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, AppState state, String categoryName) {
    final isSelected = state.selectedCategory == categoryName;
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ChoiceChip(
        label: Text(
          categoryName,
          style: TextStyle(
            color: isSelected ? AppTheme.cardWhite : AppTheme.primaryGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        selected: isSelected,
        onSelected: (bool selected) {
          if (selected) {
            state.setSelectedCategory(categoryName);
          }
        },
        selectedColor: AppTheme.primaryGreen,
        backgroundColor: AppTheme.bgCream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.transparent : AppTheme.secondaryBeige,
            width: 1.5,
          ),
        ),
        elevation: 0,
        pressElevation: 0,
      ),
    );
  }



  Widget _buildSmallCard(BuildContext context, AppState state, Village village) {
    final isFav = state.isBookmarked(village.id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(village: village),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Hero(
                      tag: 'village-img-${village.id}',
                      child: Image.asset(
                        village.imagePath,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Bookmark
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        state.toggleBookmark(village.id);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFav ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                          color: isFav ? AppTheme.accentAmber : Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Text Metadata
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    village.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    village.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizBannerCard(BuildContext context, AppState state) {
    final isEn = state.isEnglish;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen,
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF076643),
            Color(0xFF04472E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background subtle vector pattern effect
          Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 24),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    '?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEn ? 'Find Your\nDream Village!' : 'Cari Desa\nImpianmu!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isEn 
                          ? 'Take a quick quiz to find a village that matches your personality.'
                          : 'Ikuti kuis singkat untuk menemukan desa yang cocok dengan kepribadianmu.',
                        style: const TextStyle(
                          color: Color(0xFFCBE6D9),
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Mulai Kuis Button
                      ElevatedButton(
                        onPressed: () {
                          // Switch active bottom tab to Quiz page (tab index 1)
                          final navWrapper = context.findAncestorStateOfType<MainNavigationWrapperState>();
                          if (navWrapper != null) {
                            navWrapper.setTab(1);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentAmber,
                          foregroundColor: AppTheme.textDark,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          isEn ? 'Start Quiz' : 'Mulai Kuis',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Custom illustration of Question Box (matches mock)
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24, width: 2),
                        ),
                        child: Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Text(
                                '?',
                                style: TextStyle(
                                  color: AppTheme.accentAmber,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
