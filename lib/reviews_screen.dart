import 'package:flutter/material.dart';
import 'package:reviews_attempt3/UI/review_dialog.dart';
import '../models/list_reviews.dart';

class ReviewsScreen extends StatelessWidget {
  final List<ListReviews> reviews;

  ReviewsScreen({required this.reviews});

  @override
  Widget build(BuildContext context) {
    double averageRating = reviews.isNotEmpty
        ? reviews.map((r) => r.rating ?? 0).reduce((a, b) => a + b) / reviews.length
        : 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Student Adventure in Cusco',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            // Display average rating with stars
            AverageRatingDisplay(averageRating: averageRating, reviewCount: reviews.length),
            SizedBox(height: 16.0),

            // "Write a Review" Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                ),
                onPressed: () async {
                  final newReview = await showDialog<ListReviews>(
                    context: context,
                    builder: (BuildContext context) {
                      return ReviewDialog(
                        review: ListReviews(0, 0, ''), // Pass a new review object
                        isNew: true,
                      );
                    },
                  );

                  if (newReview != null) {
                    // Refresh the list of reviews
                    reviews.add(newReview);
                    (context as Element).markNeedsBuild();
                  }
                },
                child: Text('Write a Review'),
              ),
            ),
            SizedBox(height: 16.0),

            // Display List of Reviews or Empty Message
            Expanded(
              child: reviews.isNotEmpty
                  ? ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return ReviewItem(review: reviews[index]);
                },
              )
                  : Center(
                child: Text(
                  'No reviews yet. Be the first to write one!',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on double {
  get fontWeight => null;
}

class AverageRatingDisplay extends StatelessWidget {
  final double averageRating;
  final int reviewCount;

  const AverageRatingDisplay({
    required this.averageRating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display average rating
        Text(
          averageRating.toStringAsFixed(1),
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8.0),

        // Display stars
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < averageRating ? Icons.star : Icons.star_border,
              color: Colors.yellow,
              size: 24.0,
            );
          }),
        ),
        SizedBox(width: 8.0),

        // Display review count
        Text(
          '($reviewCount reviews)',
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
      ],
    );
  }
}

class ReviewItem extends StatelessWidget {
  final ListReviews review;

  const ReviewItem({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display review rating with stars
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < (review.rating ?? 0) ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                  size: 20.0,
                );
              }),
            ),
            SizedBox(height: 8.0),

            // Display review description
            Text(
              review.description ?? 'No description provided',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}