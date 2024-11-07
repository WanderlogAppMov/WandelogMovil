import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:reviews_attempt3/models/list_reviews.dart';

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

  Future<List<ListReviews>> getReviews() async {
    final List<Map<String, dynamic>> maps = await db!.query('reviews');
    return List.generate(maps.length, (i) {
      return ListReviews(
        maps[i]['id'],
        maps[i]['rating'], // Directly assign as int
        maps[i]['description'],
      );
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
