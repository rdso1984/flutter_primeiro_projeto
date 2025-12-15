class BikeAd {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String condition; // 'new', 'used', 'excellent'
  final String location;
  final String city;
  final String state;
  final bool isActive;
  final bool isPaid;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime? paymentDate;
  final String status;
  final String? userId;

  BikeAd({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.condition,
    required this.location,
    required this.city,
    required this.state,
    required this.isActive,
    required this.isPaid,
    this.expiresAt,
    required this.createdAt,
    this.paymentDate,
    required this.status,
    this.userId,
  });

  factory BikeAd.fromJson(Map<String, dynamic> json) {
    return BikeAd(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
      condition: json['condition'] ?? 'used',
      location: '${json['city'] ?? ''}, ${json['state'] ?? ''}',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      isActive: json['is_active'] ?? false,
      isPaid: json['is_paid'] ?? false,
      expiresAt: json['expires_at'] != null 
          ? DateTime.parse(json['expires_at']) 
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      paymentDate: json['payment_date'] != null
          ? DateTime.parse(json['payment_date'])
          : null,
      status: json['status'] ?? 'pending',
      userId: json['user_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'condition': condition,
      'city': city,
      'state': state,
      'is_active': isActive,
      'is_paid': isPaid,
      'expires_at': expiresAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'payment_date': paymentDate?.toIso8601String(),
      'status': status,
      'user_id': userId,
    };
  }
  
  // Helper para verificar se expira em breve (próximos 7 dias)
  bool get expiresIn7Days {
    if (expiresAt == null) return false;
    final now = DateTime.now();
    final difference = expiresAt!.difference(now);
    return difference.inDays >= 0 && difference.inDays <= 7;
  }
  
  // Helper para verificar se está expirado
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }
}
