class Reel {
  final String reelId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final DateTime publishedAt;
  final String channelId;
  final String channelTitle;

  // Constructor
  Reel({
    required this.reelId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.publishedAt,
    required this.channelId,
    required this.channelTitle,
  });

  // Factory constructor to create a Video instance from JSON
  factory Reel.fromJson(Map<String, dynamic> json) {
    return Reel(
      reelId: json['reel_id'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnail_url'],
      publishedAt: DateTime.parse(json['published_at']),
      channelId: json['channel_id'],
      channelTitle: json['channel_title'],
    );
  }

  // Method to convert a Video instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'reel_id': reelId,
      'title': title,
      'description': description,
      'thumbnail_url': thumbnailUrl,
      'published_at': publishedAt.toIso8601String(),
      'channel_id': channelId,
      'channel_title': channelTitle,
    };
  }
}
