import 'package:flutter/material.dart';
import 'package:wanderlog_apli/models/attraction.dart';
import 'package:wanderlog_apli/models/continent.dart';
import 'package:wanderlog_apli/network/attraction_service.dart';
import 'package:wanderlog_apli/network/continent_service.dart';

class AttractionsEditor extends StatefulWidget {
  @override
  _AttractionsEditorScreenState createState() => _AttractionsEditorScreenState();
}

class _AttractionsEditorScreenState extends State<AttractionsEditor> {
  final AttractionService _attractionService = AttractionService();
  late Future<List<Attraction>> _attractionsFuture;
  final ContinentService _continentService = ContinentService();
  List<Continent> continents = List.empty();

  Continent? selectedContinent;

  @override
  void initState() {
    super.initState();
    _initAttractions();
    _initContinents();
  }

  void _initAttractions(){
    setState(() {
      _attractionsFuture = _attractionService.getAllAttraction();
    });
  }

  Future<void> _initContinents() async {
    setState(() async {
      continents = await _continentService.getAllContinents();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              'Attractions',
              style: TextStyle(
                color: Color(0xFF034BAC),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add, color: Color(0xFF034BAC)),
              onPressed: () => _showAttractionDialog(),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Attraction>>(
        future: _attractionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load attractions'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No attractions available'));
          } else {
            final attractions = snapshot.data!;
            return _buildAttractionList(attractions);
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Lógica para agregar a un plan
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFF034BAC),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text('Add to Plan'),
        ),
      ),
    );
  }

  Widget _buildAttractionList(List<Attraction> attractions) {
    // Obtener los continentes únicos de las atracciones
    final continents = attractions.map((a) => a.continent.continentName).toSet().toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: continents.length,
      itemBuilder: (context, index) {
        final continent = continents[index];
        final continentAttractions = attractions
            .where((a) => a.continent.continentName == continent)
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$continent:',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: continentAttractions.map((attraction) {
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: 180,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              attraction.imageUrl ?? 'https://via.placeholder.com/80',
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            attraction.attractionName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${attraction.city}, ${attraction.country}',
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.black),
                                onPressed: () {
                                  _showAttractionDialog(attraction: attraction); // Editar atracción
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await _attractionService.deleteAttraction(attraction);
                                  setState(() {
                                    _attractionsFuture = _attractionService.getAllAttraction();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  // Mostrar el cuadro de diálogo para agregar una nueva atracción
  void _showAttractionDialog({Attraction? attraction}) {
    // Controladores de texto con valores iniciales si la atracción ya existe
    final TextEditingController _attractionNameController =
    TextEditingController(text: attraction != null ? attraction.attractionName : '');
    final TextEditingController _cityController =
    TextEditingController(text: attraction != null ? attraction.city : '');
    final TextEditingController _countryController =
    TextEditingController(text: attraction != null ? attraction.country : '');
    final TextEditingController _imageUrlController =
    TextEditingController(text: attraction != null ? attraction.imageUrl : '');
    final TextEditingController _ticketPriceController =
    TextEditingController(text: attraction != null ? attraction.ticketPrice.toString() : '');

    Continent? selectedContinent = attraction != null ? attraction.continent : null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(attraction != null ? "Edit ${attraction.attractionName}" : "Add New Attraction"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _attractionNameController,
                  decoration: const InputDecoration(labelText: "Attraction Name"),
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
                  controller: _imageUrlController,
                  decoration: const InputDecoration(labelText: "Image URL"),
                ),
                TextField(
                  controller: _ticketPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Ticket Price"),
                ),
                DropdownMenu<Continent>(
                  hintText: "Select a Continent",
                  initialSelection: selectedContinent != null
                      ? continents.firstWhere((element) => element.continentName == selectedContinent!.continentName)
                      : null,
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
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text(attraction != null ? "Update" : "Add"),
              onPressed: () async {
                if (selectedContinent == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a continent")),
                  );
                  return;
                }

                try {
                  if (attraction != null) {
                    // Actualizar atracción
                    await _attractionService.updateAttraction(
                      attractionId: attraction.attractionId,
                      attractionName: _attractionNameController.text,
                      city: _cityController.text,
                      country: _countryController.text,
                      ticketPrice: double.tryParse(_ticketPriceController.text) ?? 0.0,
                      continentId: selectedContinent!.continentID,
                      imageUrl: _imageUrlController.text,
                    );
                  } else {
                    // Crear nueva atracción
                    await _attractionService.createAttraction(
                      attractionName: _attractionNameController.text,
                      city: _cityController.text,
                      country: _countryController.text,
                      ticketPrice: double.tryParse(_ticketPriceController.text) ?? 0.0,
                      continentId: selectedContinent!.continentID,
                      imageUrl: _imageUrlController.text,
                    );
                  }

                  // Actualizar la lista de atracciones
                  setState(() {
                    _attractionsFuture = _attractionService.getAllAttraction();
                  });

                  Navigator.of(context).pop();
                } catch (e) {
                  print("Error adding attraction: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to add attraction: $e")),
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