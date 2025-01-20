class Category {
  final String id; // Added id
  final String name;
  final String image;

  Category({
    required this.id, // Added id to constructor
    required this.name,
    required this.image,
  });

  // Convert a Category object into a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include id in the map
      'name': name,
      'image': image,
    };
  }

  // Create a Category object from a Firestore document snapshot
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'], // Assign id from map
      name: map['name'],
      image: map['image'],
    );
  }
}
