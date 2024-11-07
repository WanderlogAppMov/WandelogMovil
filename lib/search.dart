import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final TextEditingController date1Controller = TextEditingController();
  final TextEditingController date2Controller = TextEditingController();
  final TextEditingController travelersController = TextEditingController();

  final List<String> orderOptions = ["Option 1", "Option 2"]; // Opciones del spinner
  String selectedOrder = "Option 1"; // Valor inicial del dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF084DA6),
        title: Text("Search"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto de origen
            TextField(
              decoration: InputDecoration(
                labelText: "Origin",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Campo de texto de destino con autocompletado (opcional)
            TextField(
              controller: destinationController,
              decoration: InputDecoration(
                labelText: "Destination",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Fecha 1 y Fecha 2
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: date1Controller,
                    decoration: InputDecoration(
                      labelText: "Date 1",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: date2Controller,
                    decoration: InputDecoration(
                      labelText: "Date 2",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Número de viajeros
            TextField(
              controller: travelersController,
              decoration: InputDecoration(
                labelText: "Travelers",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Precio mínimo y precio máximo
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minPriceController,
                    decoration: InputDecoration(
                      labelText: "Minimum price",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: maxPriceController,
                    decoration: InputDecoration(
                      labelText: "Maximum price",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Selector de orden (dropdown)
            DropdownButtonFormField<String>(
              value: selectedOrder,
              decoration: InputDecoration(
                labelText: "Order by",
                border: OutlineInputBorder(),
              ),
              items: orderOptions.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  selectedOrder = value;
                }
              },
            ),
            SizedBox(height: 20),
            // Botón de búsqueda
            ElevatedButton(
              onPressed: () {
                // Acción del botón de búsqueda
                Navigator.pushNamed(context, '/results', arguments: {
                  "destination": destinationController.text,
                  "minPrice": minPriceController.text,
                  "maxPrice": maxPriceController.text,
                  "order": selectedOrder,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF084DA6),
                minimumSize: Size(double.infinity, 50), // Tamaño ancho completo
              ),
              child: Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
