import 'package:flutter/material.dart';

class RestaurantOrderPage extends StatefulWidget {
  final Map<String, String> restaurant;

  const RestaurantOrderPage({super.key, required this.restaurant});

  @override
  State<RestaurantOrderPage> createState() => _RestaurantOrderPageState();
}

class _RestaurantOrderPageState extends State<RestaurantOrderPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Exemple de menu
  final List<Map<String, dynamic>> menu = [
    {'name': 'Poulet Yassa', 'price': 2500, 'quantity': 0},
    {'name': 'Thieboudienne', 'price': 3000, 'quantity': 0},
    {'name': 'Brochettes de bœuf', 'price': 2000, 'quantity': 0},
    {'name': 'Jus de bissap', 'price': 1000, 'quantity': 0},
  ];

  int get totalPrice {
    return menu.fold(0, (sum, item) =>
  sum + (item['price'] as int) * (item['quantity'] as int));

  }

  void _submitOrder() {
    if (_formKey.currentState!.validate() && totalPrice > 0) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Commande envoyée'),
          content: Text(
              'Merci ${nameController.text}, votre commande de ${totalPrice} FCFA a été prise en compte.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Fermer'),
            ),
          ],
        ),
      );
    } else if (totalPrice == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner au moins un plat.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Commander chez ${widget.restaurant['name']}")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Infos client
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

              // 🍽️ Menu
              const Text("Menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              ...menu.map((item) {
                return Card(
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text('${item['price']} FCFA'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (item['quantity'] > 0) item['quantity']--;
                            });
                          },
                        ),
                        Text('${item['quantity']}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              item['quantity']++;
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
                onPressed: _submitOrder,
                icon: const Icon(Icons.check),
                label: const Text("Passer la commande"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }
}
