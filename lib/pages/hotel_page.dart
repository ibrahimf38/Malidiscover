import 'dart:io';
import 'dart:convert';

import 'package:app01/pages/resevation.dart';
import 'package:flutter/material.dart';
import 'package:app01/pages/formulairehotel.dart';

class HotelPage extends StatefulWidget {
  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  List<Map<String, String>> hotels = [
    {
      'name': 'Hôtel Maria',
      'location': 'Bamako',
      'image': 'https://source.unsplash.com/600x400/?hotel,1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hôtels")),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          final imagePath = hotel['image']!;
          final ImageProvider imageProvider;

          if (imagePath.startsWith('http')) {
            imageProvider = NetworkImage(imagePath);
          } else if (imagePath.startsWith('data:image')) {
            final base64Data = imagePath.split(',').last;
            imageProvider = MemoryImage(base64Decode(base64Data));
          } else {
            imageProvider = FileImage(File(imagePath));
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HotelReservationPage(hotel: hotel),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.greenAccent,
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
                            hotel['name'] ?? '',
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
                                hotel['location'] ?? '',
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
          final newHotel = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(builder: (_) => const AddHotelPage()),
          );
          if (newHotel != null) {
            setState(() {
              hotels.add(newHotel);
            });
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Ajouter"),
      ),
    );
  }
}
