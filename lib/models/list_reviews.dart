class ListReviews {
  int? id;
  int? travelPackageId;
  int? rating;
  String? description;

  ListReviews(this.id, this.travelPackageId, this.rating, this.description);

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'travelPackageId': travelPackageId,
      'rating': rating,
      'description': description,
    };
  }

  factory ListReviews.fromMap(Map<String, dynamic> map) {
    return ListReviews(
      map['id'] as int?,
      map['travelPackageId'] as int?,
      map['rating'] as int?,
      map['description'] as String?,
    );
  }
}