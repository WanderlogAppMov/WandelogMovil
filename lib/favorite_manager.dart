import 'models/TravelPackage.dart';

class FavoriteManager {
  static final List<TravelPackage> _favoritePackages = [];

  static List<TravelPackage> getFavoritePackages() => _favoritePackages;

  static void addPackage(TravelPackage travelPackage) {
    if (!_favoritePackages.contains(travelPackage)) {
      _favoritePackages.add(travelPackage);
    }
  }

  static void removePackage(TravelPackage travelPackage) {
    _favoritePackages.remove(travelPackage);
  }

  static bool isFavorite(TravelPackage travelPackage) {
    return _favoritePackages.contains(travelPackage);
  }
}
