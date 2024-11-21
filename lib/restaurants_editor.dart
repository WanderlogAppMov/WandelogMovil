import 'package:flutter/material.dart';
import 'package:wanderlog_movil/models/continent.dart';
import 'package:wanderlog_movil/models/restaurant.dart';
import 'package:wanderlog_movil/network/continent_service.dart';
import 'package:wanderlog_movil/network/restaurant_service.dart';


class RestaurantsEditor extends StatefulWidget {
  @override
  _RestaurantsEditorScreenState createState() => _RestaurantsEditorScreenState();
}

class _RestaurantsEditorScreenState extends State<RestaurantsEditor> {
  final RestaurantService _restaurantService = RestaurantService();
  late Future<List<Restaurant>> _restaurantsFuture;
  List<Continent> continents = [];
  Continent? selectedContinent;

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
    _loadContinents();
  }

  void _loadRestaurants(){
    setState(() {
      _restaurantsFuture = _restaurantService.getAllRestaurants();
    });
  }

  Future<void> _loadContinents() async {
    try {
      continents = await ContinentService().getAllContinents();
      setState(() {});
    } catch (error) {
      print("Error loading continents: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState)
    {
      return Scaffold(
        backgroundColor: Color(0xFF034BAC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF034BAC)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 10),
              Text(
                'Restaurants',
                style: TextStyle(
                  color: Color(0xFF034BAC),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.add, color: Color(0xFF034BAC)),
                onPressed: () => _showRestaurantDialog(),
              ),
            ],
          ),
        ),
        body: FutureBuilder<List<Restaurant>>(
          future: _restaurantsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load restaurants'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No restaurants available'));
            } else {
              final restaurants = snapshot.data!;
              return _buildRestaurantList(restaurants);
            }
          },
        ),
      );
    });
  }

  Widget _buildRestaurantList(List<Restaurant> restaurants) {
    // Agrupar los restaurantes por continente
    final Map<String, List<Restaurant>> restaurantsByContinent = {};
    for (var restaurant in restaurants) {
      final continent = restaurant.continent.continentName; // Asegúrate de que `continentName` sea parte de `Restaurant`
      restaurantsByContinent.putIfAbsent(continent, () => []).add(restaurant);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: restaurantsByContinent.entries.map((entry) {
        final continent = entry.key;
        final continentRestaurants = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              continent,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: continentRestaurants.map((restaurant) {
                  return Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              restaurant.imageUrl ?? 'https://via.placeholder.com/120',
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              restaurant.restaurantName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${restaurant.city}, ${restaurant.country}',
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Cuisine: ${restaurant.cuisineType}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Price Range: ${restaurant.priceRange}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.black),
                                  onPressed: () {
                                    _showRestaurantDialog(restaurant: restaurant); // Editar restaurante
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await _restaurantService.deleteRestaurant(restaurant);
                                    setState(() {
                                      _restaurantsFuture = _restaurantService.getAllRestaurants();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }

  // Mostrar el cuadro de diálogo para agregar un nuevo restaurante
  void _showRestaurantDialog({Restaurant? restaurant}) {
    final TextEditingController _restaurantNameController =
      TextEditingController(text: restaurant != null?restaurant.restaurantName:'');
    final TextEditingController _countryController =
      TextEditingController(text: restaurant != null?restaurant.country:'');
    final TextEditingController _cityController =
      TextEditingController(text: restaurant != null?restaurant.city:'');
    final TextEditingController _cuisineTypeController =
      TextEditingController(text: restaurant != null?restaurant.cuisineType:'');
    final TextEditingController _priceRangeController =
      TextEditingController(text: restaurant != null?restaurant.priceRange:'');
    final TextEditingController _imageUrlController =
      TextEditingController(text: restaurant != null?restaurant.imageUrl:'');

    if(restaurant != null){
      setState(() {
        selectedContinent = restaurant.continent;
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: restaurant != null?Text("Edit ${restaurant.restaurantName}"):const Text("Add New Restaurant"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _restaurantNameController,
                  decoration: const InputDecoration(labelText: "Restaurant Name"),
                ),
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: "City"),
                ),
                TextField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: "Country"),
                ),
                TextField(
                  controller: _cuisineTypeController,
                  decoration: const InputDecoration(labelText: "Cuisine Type"),
                ),
                TextField(
                  controller: _priceRangeController,
                  decoration: const InputDecoration(labelText: "Price Range"),
                ),
                DropdownMenu<Continent>(
                  hintText: "Select a Continent",
                  initialSelection: selectedContinent != null?continents.firstWhere(
                        (Continent element) => element.continentName == selectedContinent?.continentName
                  ):selectedContinent,
                  onSelected: (Continent? newValue) {
                    setState(() {
                      selectedContinent = newValue;
                    });
                  },
                  dropdownMenuEntries: continents.map<DropdownMenuEntry<Continent>>((Continent continent) {
                    return DropdownMenuEntry<Continent>(
                      value: continent,
                      label: continent.continentName,
                    );
                  }).toList(),
                ),
                TextField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(labelText: "Image URL"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () async {
                if (selectedContinent == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a continent")),
                  );
                  return;
                }

                try {
                  if(restaurant != null){
                    await _restaurantService.updateRestaurant(
                      restaurantId: restaurant.restaurantId,
                      restaurantName: _restaurantNameController.text,
                      country: _countryController.text,
                      city: _cityController.text,
                      cuisineType: _cuisineTypeController.text,
                      priceRange: _priceRangeController.text,
                      continentId: selectedContinent!.continentID,
                      imageUrl: _imageUrlController.text
                    );
                  } else {
                    await _restaurantService.createRestaurant(
                      restaurantName: _restaurantNameController.text,
                      country: _countryController.text,
                      city: _cityController.text,
                      cuisineType: _cuisineTypeController.text,
                      priceRange: _priceRangeController.text,
                      continentId: selectedContinent!.continentID,
                      imageUrl: _imageUrlController.text,
                    );
                  }

                  // Actualizar la lista de restaurantes
                  setState(() {
                    _restaurantsFuture = _restaurantService.getAllRestaurants();
                  });

                  Navigator.of(context).pop();
                } catch (e) {
                  print("Error adding restaurant: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to add restaurant: $e")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
