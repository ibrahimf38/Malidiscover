import 'dart:io';
import 'dart:convert';
import 'package:app01/pages/commande.dart';
import 'package:flutter/material.dart';
import 'package:app01/pages/formulairerestaurant.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  List<Map<String, String>> restaurants = [
    {
      'name': 'Restaurant Nom',
      'location': 'Position',
      'image': 'photo',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurants")),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          final imagePath = restaurant['image']!;
          final imageProvider = imagePath.startsWith('http')
              ? NetworkImage(imagePath)
              : (imagePath.startsWith('data:image')
                  ? MemoryImage(base64Decode(imagePath.split(',').last))
                  : FileImage(File(imagePath))) as ImageProvider;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RestaurantOrderPage(restaurant: restaurant),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.amberAccent,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                restaurant['location']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newRestaurant = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(builder: (_) => const AddRestaurantPage()),
          );
          if (newRestaurant != null) {
            setState(() {
              restaurants.add(newRestaurant);
            });
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Ajouter"),
      ),
    );
  }
}
