import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/village.dart';
import '../state/app_state.dart';
import 'main_navigation_wrapper.dart';

class DetailScreen extends StatelessWidget {
  final Village village;

  const DetailScreen({super.key, required this.village});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Hero(
                  tag: 'village-img-${village.id}',
                  child: Image.asset(
                    village.imagePath,
                    width: double.infinity,
                    height: 380,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppTheme.bgCream.withOpacity(0.9),
                          AppTheme.bgCream,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),



                Positioned(
                  bottom: 70,
                  left: 20,
                  right: 20,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: village.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            Transform.translate(
              offset: const Offset(0, -50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      village.name,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: AppTheme.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        final query = Uri.encodeComponent('${village.name} ${village.location}, Indonesia');
                        final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, color: AppTheme.primaryGreen, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${village.location}, Indonesia',
                              style: const TextStyle(
                                color: AppTheme.primaryGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.open_in_new_rounded, color: AppTheme.primaryGreen, size: 14),
                        ],
                      ),
                    ),



                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.cardWhite,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.info_outline_rounded, color: AppTheme.primaryGreen, size: 22),
                              const SizedBox(width: 8),
                              Text(
                                appState.isEnglish ? 'About Village' : 'Tentang Desa',
                                style: TextStyle(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            village.description,
                            style: const TextStyle(
                              color: AppTheme.textDark,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      children: [
                        const Icon(Icons.history_edu_rounded, color: AppTheme.primaryGreen, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          appState.isEnglish ? 'Brief History' : 'Sejarah Singkat',
                          style: TextStyle(
                            color: AppTheme.textDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: village.historyTimeline.length,
                      itemBuilder: (context, index) {
                        final timeline = village.historyTimeline[index];
                        final isLast = index == village.historyTimeline.length - 1;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: AppTheme.primaryGreen,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                if (!isLast)
                                  Container(
                                    width: 2,
                                    height: 70,
                                    color: AppTheme.primaryGreen.withOpacity(0.3),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    timeline.era,
                                    style: const TextStyle(
                                      color: AppTheme.primaryGreen,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    timeline.description,
                                    style: const TextStyle(
                                      color: AppTheme.textMuted,
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.collections_outlined, color: AppTheme.primaryGreen, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              appState.isEnglish ? 'Photo Gallery' : 'Galeri Foto',
                              style: TextStyle(
                                color: AppTheme.textDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            appState.isEnglish ? 'See All' : 'Lihat Semua',
                            style: const TextStyle(
                              color: AppTheme.textMuted,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: village.gallery.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                village.gallery[index],
                                width: 220,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      children: [
                        const Icon(Icons.gavel_rounded, color: AppTheme.primaryGreen, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          appState.isEnglish ? 'Local Culture' : 'Kebudayaan Lokal',
                          style: TextStyle(
                            color: AppTheme.textDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: village.cultureList.length,
                      itemBuilder: (context, index) {
                        final culture = village.cultureList[index];
                        IconData icon = Icons.gavel_rounded;
                        if (culture.title.toLowerCase().contains('arsitektur')) {
                          icon = Icons.home_work_rounded;
                        } else if (culture.title.toLowerCase().contains('tenun')) {
                          icon = Icons.brush_rounded;
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryBeige.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: AppTheme.cardWhite,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  icon,
                                  color: AppTheme.primaryGreen,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      culture.title,
                                      style: const TextStyle(
                                        color: AppTheme.textDark,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      culture.description,
                                      style: const TextStyle(
                                        color: AppTheme.textMuted,
                                        fontSize: 13,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        appState.startQuiz(village.id);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainNavigationWrapper(initialTab: 1),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        foregroundColor: AppTheme.cardWhite,
                        minimumSize: const Size.fromHeight(56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.library_books_rounded, size: 20),
                          const SizedBox(width: 8),
                          Text(appState.isEnglish ? 'Start ${village.name} Quiz' : 'Mulai Kuis ${village.name}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top > 0 
                ? MediaQuery.of(context).padding.top + 10 
                : kToolbarHeight - 10,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppTheme.primaryGreen,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}