// main.dart
import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotels App',
      home: const HotelsScreen(),
    );
  }
}

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  List<dynamic> hotels = [];

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final priceController = TextEditingController();

  int? editingId; // null = adding new, not null = editing that hotel's id

  @override
  void initState() {
    super.initState();
    loadHotels();
  }

  void loadHotels() async {
    hotels = await ApiService.getHotels();
    setState(() {});
  }

  void saveHotel() async {
    final name = nameController.text;
    final address = addressController.text;
    final price = double.tryParse(priceController.text) ?? 0.0;

    if (editingId == null) {
      await ApiService.createHotel(name, address, price);
    } else {
      await ApiService.updateHotel(editingId!, name, address, price);
    }

    clearForm();
    loadHotels();
  }

  void deleteHotel(int id) async {
    await ApiService.deleteHotel(id);
    loadHotels();
  }

  void loadHotelIntoForm(dynamic hotel) {
    nameController.text = hotel['name'] ?? '';
    addressController.text = hotel['address'] ?? '';
    priceController.text = hotel['price'].toString();
    editingId = hotel['id'];
    setState(() {});
  }

  void clearForm() {
    nameController.clear();
    addressController.clear();
    priceController.clear();
    editingId = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hotels')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: saveHotel,
                    child: Text(editingId == null ? 'Add Hotel' : 'Update Hotel'),
                  ),
                ),
                if (editingId != null) ...[
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: clearForm,
                    child: const Text('Cancel'),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return ListTile(
                    title: Text(hotel['name'] ?? ''),
                    subtitle: Text('${hotel['address'] ?? ''} - ₹${hotel['price']}'),
                    onTap: () => loadHotelIntoForm(hotel),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteHotel(hotel['id']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}