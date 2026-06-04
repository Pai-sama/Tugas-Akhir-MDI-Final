import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../state/app_state.dart';
import '../state/app_language.dart';
import 'detail_screen.dart';
import 'auth_gate.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final savedIds = appState.bookmarkedVillageIds;
    final savedVillages = appState.villages.where((v) => savedIds.contains(v.id)).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    appState.isEnglish ? 'Favorite Villages' : 'Desa Favorit',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await appState.logout();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const AuthGate()),
                          (route) => false,
                        );
                      }
                    },
                    icon: const Icon(Icons.logout, color: AppTheme.errorRed),
                    tooltip: appState.isEnglish ? 'Logout' : 'Keluar',
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                appState.isEnglish ? 'Saved Explorations' : 'Simpanan Penjelajahan',
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                appState.isEnglish
                    ? 'List of unique villages you want to visit or learn more about.'
                    : 'Daftar desa unik yang ingin Anda kunjungi atau pelajari kembali.',
                style: const TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: savedVillages.isEmpty
                    ? _buildEmptyState(context, appState.isEnglish)
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: savedVillages.length,
                        itemBuilder: (context, index) {
                          final village = savedVillages[index];
                          return _buildSavedCard(context, appState, village);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isEn) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.secondaryBeige.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bookmark_border_rounded,
              color: AppTheme.primaryGreen,
              size: 48,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            isEn ? 'No Favorites Yet' : 'Belum Ada Favorit',
            style: const TextStyle(
              color: AppTheme.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              isEn
                  ? 'Press the bookmark button on the village recommendation page to save your dream destinations here.'
                  : 'Tekan tombol bookmark di halaman rekomendasi desa untuk menyimpan destinasi impian Anda di sini.',
              style: const TextStyle(
                color: AppTheme.textMuted,
                fontSize: 13,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedCard(BuildContext context, AppState state, dynamic village) {
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
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      village.imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                          color: Colors.black.withOpacity(0.35),
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
}