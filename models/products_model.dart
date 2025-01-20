import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id; // Added id
  final String name;
  final double price;
  final String description;
  final String categoryId; // Updated to store category id
  final String brandId; // Updated to store brand id
  final String image;
  final Timestamp? createdAt;

  Product({
    this.createdAt,
    required this.id, // Added id to constructor
    required this.name,
    required this.price,
    required this.description,
    required this.categoryId, // categoryId instead of category name
    required this.brandId, // brandId instead of brand name
    required this.image,
  });

  // Convert a Product object into a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include id in the map
      'name': name,
      'price': price,
      'description': description,
      'categoryId': categoryId, // Use categoryId
      'brandId': brandId, // Use brandId
      'image': image,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  // Create a Product object from a Firestore document snapshot
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'], // Assign id from map
      name: map['name'],
      price: map['price'],
      description: map['description'],
      categoryId: map['categoryId'], // categoryId from map
      brandId: map['brandId'], // brandId from map
      image: map['image'],
      createdAt: map['createdAt'],
    );
  }
}
