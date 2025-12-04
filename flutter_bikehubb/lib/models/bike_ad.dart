class BikeAd {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String condition; // 'new', 'used', 'excellent'
  final String location;

  BikeAd({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.condition,
    required this.location,
  });

  factory BikeAd.fromJson(Map<String, dynamic> json) {
    return BikeAd(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      condition: json['condition'] ?? 'used',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'condition': condition,
      'location': location,
    };
  }
}
