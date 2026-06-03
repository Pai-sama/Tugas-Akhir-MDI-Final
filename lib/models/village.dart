class TimelineEvent {
  final String era;
  final String description;

  TimelineEvent({required this.era, required this.description});
}

class CultureItem {
  final String title;
  final String description;

  CultureItem({required this.title, required this.description});
}

class Village {
  final String id;
  final String name;
  final String location;
  final String province;
  final String category;
  final String imagePath;
  final double rating;
  final List<String> tags;
  final String description;
  final double latitude;
  final double longitude;
  final List<TimelineEvent> historyTimeline;
  final List<String> gallery;
  final List<CultureItem> cultureList;
  final bool isFeatured;

  Village({
    required this.id,
    required this.name,
    required this.location,
    required this.province,
    required this.category,
    required this.imagePath,
    required this.rating,
    required this.tags,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.historyTimeline,
    this.gallery = const [],
    this.cultureList = const [],
    this.isFeatured = false,
  });
}
