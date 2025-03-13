class BrandModel {
  final String id;
  final String name;
  final String image;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
  });

  // Convert to  map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  // Create  Brand object from  Firestore doc---map to  obj---
  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
    );
  }
}
