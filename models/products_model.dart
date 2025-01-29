class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String categoryId;
  final String brandId;
  final List<String> images;
  final DateTime? createdAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.brandId,
    required this.images,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'categoryId': categoryId,
      'brandId': brandId,
      'images': images,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      categoryId: map['categoryId'],
      brandId: map['brandId'],
      images: List<String>.from(map['images']),
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }
}
