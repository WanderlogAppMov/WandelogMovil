import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wanderlog_movil/models/continent.dart';
import 'package:wanderlog_movil/network/continent_service.dart';


class ContinentsEditor extends StatefulWidget {
  const ContinentsEditor({super.key});

  @override
  _ContinentsEditorScreenState createState() => _ContinentsEditorScreenState();
}

class _ContinentsEditorScreenState extends State<ContinentsEditor> {
  final ContinentService _continentService = ContinentService();
  late Future<List<Continent>> _continentsFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _continentsFuture = _continentService.getAllContinents();
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
              'Continents',
              style: TextStyle(
                color: Color(0xFF034BAC),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add, color: Color(0xFF034BAC)),
              onPressed: () => _showAddHotelDialog(),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Continent>>(
        future: _continentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load continents'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No continents available'));
          } else {
            final continents = snapshot.data!;
            return _buildContinentList(continents);
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
          child: Text('Delete all'),
        ),
      ),
    );
  }

  Widget _buildContinentList(List<Continent> continents) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: continents.length,
      itemBuilder: (context, index) {
        final Continent continent = continents[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: Text(
                continent.continentName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // Para ajustar el tamaño del Row al contenido
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black),
                  onPressed: () async {
                    await _continentService.editContinent(continent: continent); // Llama a la función para editar el vuelo
                    _loadData();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await _continentService.deleteContinent(continent: continent); // Llama a la función para eliminar el vuelo
                    _loadData();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Mostrar el cuadro de diálogo para agregar un nuevo hotel
  void _showAddHotelDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String continentName = '';

        return AlertDialog(
          title: const Text("Add New Continent"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => continentName = value,
                  decoration: const InputDecoration(labelText: "Continent Name"),
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
                try {
                  await _continentService.createContinent(
                    continentName: continentName,
                  );
                  setState(() {
                    _continentsFuture = _continentService.getAllContinents();
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to add continent: $e")),
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