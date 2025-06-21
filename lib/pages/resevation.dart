import 'package:flutter/material.dart';

class HotelReservationPage extends StatefulWidget {
  final Map<String, String> hotel;

  const HotelReservationPage({super.key, required this.hotel});

  @override
  State<HotelReservationPage> createState() => _HotelReservationPageState();
}

class _HotelReservationPageState extends State<HotelReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  DateTime? checkInDate;
  DateTime? checkOutDate;

  final List<Map<String, dynamic>> roomTypes = [
    {'type': 'Chambre simple', 'price': 20000, 'quantity': 0},
    {'type': 'Chambre double', 'price': 30000, 'quantity': 0},
    {'type': 'Suite', 'price': 50000, 'quantity': 0},
  ];

  int get totalPrice {
    return roomTypes.fold(0, (sum, room) =>
  sum + (room['price'] as int) * (room['quantity'] as int));

  }

  Future<void> _selectDate(bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  void _submitReservation() {
    if (_formKey.currentState!.validate() &&
        totalPrice > 0 &&
        checkInDate != null &&
        checkOutDate != null &&
        checkInDate!.isBefore(checkOutDate!)) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Réservation confirmée"),
          content: Text(
              "Merci ${nameController.text}, votre réservation de ${totalPrice} FCFA a été enregistrée."),
          actions: [
            TextButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text("Fermer"),
            ),
          ],
        ),
      );
    } else if (checkInDate == null || checkOutDate == null || !checkInDate!.isBefore(checkOutDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez choisir des dates valides.")),
      );
    } else if (totalPrice == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sélectionnez au moins une chambre.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Réserver à ${widget.hotel['name']}")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 👤 Infos client
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Votre nom", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Entrez votre nom' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Téléphone", border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Entrez un numéro de téléphone' : null,
              ),
              const SizedBox(height: 20),

              // 🗓 Dates
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _selectDate(true),
                      child: Text(checkInDate == null
                          ? "Date d'arrivée"
                          : "Arrivée : ${checkInDate!.toLocal().toString().split(' ')[0]}"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _selectDate(false),
                      child: Text(checkOutDate == null
                          ? "Date de départ"
                          : "Départ : ${checkOutDate!.toLocal().toString().split(' ')[0]}"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🛏️ Chambres
              const Text("Types de chambres", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              ...roomTypes.map((room) {
                return Card(
                  child: ListTile(
                    title: Text(room['type']),
                    subtitle: Text('${room['price']} FCFA / nuit'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (room['quantity'] > 0) room['quantity']--;
                            });
                          },
                        ),
                        Text('${room['quantity']}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              room['quantity']++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              const SizedBox(height: 20),
              Text('Total : $totalPrice FCFA', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: _submitReservation,
                icon: const Icon(Icons.hotel),
                label: const Text("Réserver maintenant"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
