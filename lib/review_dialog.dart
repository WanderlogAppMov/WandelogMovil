import 'package:flutter/material.dart';
import 'package:wanderlog_movil/utils/dbservice.dart';
import 'models/list_reviews.dart';

class ReviewDialog extends StatefulWidget {
  final ListReviews review;
  final bool isNew;
  final int travelPackageId;

  ReviewDialog({required this.review, required this.isNew, required this.travelPackageId});

  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final TextEditingController txtDescription = TextEditingController();
  int rating = 0;
  late Dbservice dbservice;

  @override
  void initState() {
    super.initState();
    dbservice = Dbservice();

    if (!widget.isNew) {
      txtDescription.text = widget.review.description ?? '';
      rating = widget.review.rating ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Students adventure in Cusco")),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: index < rating ? Colors.yellow : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = index + 1;
                      });
                    },
                  );
                }),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: txtDescription,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Share details about your experience with this package",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog without saving
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    widget.review.description = txtDescription.text;
                    widget.review.rating = rating;
                    widget.review.travelPackageId = widget.travelPackageId;

                    await dbservice.openDb();
                    if (widget.isNew) {
                      await dbservice.insertReview(widget.review);
                    } else {
                      await dbservice.updateReview(widget.review);
                    }

                    Navigator.pop(context, widget.review); // Close the dialog
                  },
                  child: Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}