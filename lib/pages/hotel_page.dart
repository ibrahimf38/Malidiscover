// import 'dart:io';
// import 'dart:convert';

// import 'package:app01/pages/resevation.dart';
// import 'package:flutter/material.dart';
// import 'package:app01/pages/formulairehotel.dart';

// class HotelPage extends StatefulWidget {
//   @override
//   _HotelPageState createState() => _HotelPageState();
// }

// class _HotelPageState extends State<HotelPage> {
//   List<Map<String, String>> hotels = [
//     {
//       'name': 'Hôtel Maria',
//       'location': 'Bamako',
//       'image': 'https://source.unsplash.com/600x400/?hotel,1',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Hôtels")),
//       body: ListView.builder(
//         itemCount: hotels.length,
//         itemBuilder: (context, index) {
//           final hotel = hotels[index];
//           final imagePath = hotel['image']!;
//           final ImageProvider imageProvider;

//           if (imagePath.startsWith('http')) {
//             imageProvider = NetworkImage(imagePath);
//           } else if (imagePath.startsWith('data:image')) {
//             final base64Data = imagePath.split(',').last;
//             imageProvider = MemoryImage(base64Decode(base64Data));
//           } else {
//             imageProvider = FileImage(File(imagePath));
//           }

//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => HotelReservationPage(hotel: hotel),
//                 ),
//               );
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//               height: 300,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.greenAccent,
//                 image: DecorationImage(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Positioned(
//                     left: 16,
//                     bottom: 16,
//                     right: 16,
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.5),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             hotel['name'] ?? '',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Row(
//                             children: [
//                               const Icon(Icons.location_on,
//                                   color: Colors.white, size: 16),
//                               const SizedBox(width: 6),
//                               Text(
//                                 hotel['location'] ?? '',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () async {
//           final newHotel = await Navigator.push<Map<String, String>>(
//             context,
//             MaterialPageRoute(builder: (_) => const AddHotelPage()),
//           );
//           if (newHotel != null) {
//             setState(() {
//               hotels.add(newHotel);
//             });
//           }
//         },
//         icon: const Icon(Icons.add),
//         label: const Text("Ajouter"),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'formulairehotel.dart';
import 'resevation.dart';

class HotelPage extends StatefulWidget {
  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  List<Map<String, dynamic>> hotels = [
    {
      'name': 'Hôtel Maria',
      'location': 'Bamako',
      'image': 'https://images.unsplash.com/photo-1455396273-367ea4eb4db5',
      'price': '25000',
      'room': 'Chambre Deluxe',
      'description': 'Hôtel 4 étoiles avec piscine et spa',
      'rating': 4.5,
    },
    {
      'name': 'Hôtel bor de l/eau',
      'location': 'Bamako',
      'image': 'https://images.unsplash.com/photo-15396273-367ea4eb4db5',
      'price': '20000',
      'room': 'Chambre Deluxe',
      'description': 'Hôtel 3 étoiles avec piscine',
      'rating': 3.5,
    },
  ];

  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredHotels {
    if (_searchQuery.isEmpty) return hotels;
    return hotels.where((hotel) {
      return hotel['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          hotel['location'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hôtels Disponibles"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: HotelSearchDelegate(hotels: hotels),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un hôtel...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {});
              },
              child: ListView.builder(
                itemCount: filteredHotels.length,
                itemBuilder: (context, index) {
                  final hotel = filteredHotels[index];
                  return _buildHotelCard(context, hotel);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newHotel = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(builder: (_) => const AddHotelPage()),
          );
          if (newHotel != null) {
            setState(() {
              hotels.add(newHotel);
            });
          }
        },
        icon: const Icon(Icons.add_home_work),
        label: const Text("Ajouter Hôtel"),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget _buildHotelCard(BuildContext context, Map<String, dynamic> hotel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HotelReservationPage(hotel: hotel),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                hotel['image'],
                height: 180,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hotel['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          Text(
                            hotel['rating'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        hotel['location'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hotel['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${hotel['price']} FCFA/nuit',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HotelReservationPage(hotel: hotel),
                            ),
                          );
                        },
                        child: const Text('Réserver'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> hotels;

  HotelSearchDelegate({required this.hotels});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = hotels.where((hotel) {
      return hotel['name'].toLowerCase().contains(query.toLowerCase()) ||
          hotel['location'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildResultsList(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = hotels.where((hotel) {
      return hotel['name'].toLowerCase().contains(query.toLowerCase()) ||
          hotel['location'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _buildResultsList(suggestions);
  }

  Widget _buildResultsList(List<Map<String, dynamic>> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final hotel = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(hotel['image']),
          ),
          title: Text(hotel['name']),
          subtitle: Text(hotel['location']),
          trailing: Text('${hotel['price']} FCFA'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HotelReservationPage(hotel: hotel),
              ),
            );
          },
        );
      },
    );
  }
}
