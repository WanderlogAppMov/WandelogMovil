import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/list_reviews.dart';

class Dbservice {
  Database? db;
  int version = 1;

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(
        join(await getDatabasesPath(), 'wanderlog.db'),
        onCreate: (database, version) async {
          await _createReviewsTable(database);
        },
        version: version,
      );
    }
    return db!;
  }

  Future<void> _createReviewsTable(Database db) async {
    await db.execute('''
    CREATE TABLE reviews(
      id INTEGER PRIMARY KEY,
      travelPackageId INTEGER,
      rating INTEGER,
      description TEXT
    )
  ''');
  }

  Future<void> insertReview(ListReviews review) async {
    await db!.insert('reviews', review.toMap());
  }

  Future<void> deleteReview(ListReviews review) async {
    await db!.delete('reviews', where: 'id = ?', whereArgs: [review.id]);
  }

  Future<List<ListReviews>> getReviewsByTravelPackageId(int travelPackageId) async {
    final List<Map<String, dynamic>> maps = await db!.query(
      'reviews',
      where: 'travelPackageId = ?',
      whereArgs: [travelPackageId],
    );
    return List.generate(maps.length, (i) {
      return ListReviews.fromMap(maps[i]);
    });
  }

  Future<void> updateReview(ListReviews review) async {
    await db!.update(
      'reviews',
      review.toMap(),
      where: 'id = ?',
      whereArgs: [review.id],
    );
  }
}