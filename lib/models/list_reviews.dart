class ListReviews {
  int? id;
  int? rating;
  String? description;

  ListReviews(this.id, this.rating, this.description);

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'rating': rating,
      'description': description,
    };
  }
}
