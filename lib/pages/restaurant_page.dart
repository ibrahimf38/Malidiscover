// import 'dart:io';
// import 'dart:convert';
// import 'package:app01/pages/commande.dart';
// import 'package:flutter/material.dart';
// import 'package:app01/pages/formulairerestaurant.dart';

// class RestaurantPage extends StatefulWidget {
//   @override
//   _RestaurantPageState createState() => _RestaurantPageState();
// }

// class _RestaurantPageState extends State<RestaurantPage> {
//   List<Map<String, String>> restaurants = [
//     {
//       'name': 'Restaurant Nom',
//       'location': 'Position',
//       'image': 'photo',
//     }
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Restaurants")),
//       body: ListView.builder(
//         itemCount: restaurants.length,
//         itemBuilder: (context, index) {
//           final restaurant = restaurants[index];
//           final imagePath = restaurant['image']!;
//           final imageProvider = imagePath.startsWith('http')
//               ? NetworkImage(imagePath)
//               : (imagePath.startsWith('data:image')
//                   ? MemoryImage(base64Decode(imagePath.split(',').last))
//                   : FileImage(File(imagePath))) as ImageProvider;

//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => RestaurantOrderPage(restaurant: restaurant),
//                 ),
//               );
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//               height: 300,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.amberAccent,
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
//                             restaurant['name']!,
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
//                                 restaurant['location']!,
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
//           final newRestaurant = await Navigator.push<Map<String, String>>(
//             context,
//             MaterialPageRoute(builder: (_) => const AddRestaurantPage()),
//           );
//           if (newRestaurant != null) {
//             setState(() {
//               restaurants.add(newRestaurant);
//             });
//           }
//         },
//         icon: const Icon(Icons.add),
//         label: const Text("Ajouter"),
//       ),
//     );
//   }
// }






import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app01/pages/commande.dart';
import 'package:app01/pages/formulairerestaurant.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  List<Map<String, dynamic>> restaurants = [];
  bool _isLoading = true;
  String _searchQuery = '';
  int _selectedFilter = 0; // 0: Tous, 1: Populaires, 2: Proches

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulation de chargement
    setState(() {
      restaurants = [
        {
          'name': 'Le Délicieux', 
          'location': 'Bamako, golf', 
          'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
          'description': 'Cuisine sénégalaise traditionnelle dans un cadre moderne',
          'plat': 'Thieboudienne',
          'price': '3500',
          'quantity': '0',
          'rating': 4.5,
        },
        {
          'name': 'La Paillote', 
          'location': 'Saly, Mbour', 
          'image': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5',
          'description': 'Spécialités de fruits de mer face à la mer',
          'plat': 'Plateau de fruits de mer',
          'price': '12000',
          'quantity': '0',
          'rating': 4.8,
        },
      ];
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> get _filteredRestaurants {
    List<Map<String, dynamic>> result = restaurants.where((resto) {
      final nameMatch = resto['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      final locationMatch = resto['location'].toLowerCase().contains(_searchQuery.toLowerCase());
      return nameMatch || locationMatch;
    }).toList();

    if (_selectedFilter == 1) {
      result.sort((a, b) => (b['rating'] ?? 0).compareTo(a['rating'] ?? 0));
    } else if (_selectedFilter == 2) {
      // Simuler un tri par distance
      result.sort((a, b) => a['name'].length.compareTo(b['name'].length));
    }

    return result;
  }

  Future<void> _refresh() async {
    setState(() => _isLoading = true);
    await _loadRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurants"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Filtrer par', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      RadioListTile<int>(
                        value: 0,
                        groupValue: _selectedFilter,
                        onChanged: (v) {
                          setState(() => _selectedFilter = v!);
                          Navigator.pop(context);
                        },
                        title: const Text('Tous les restaurants'),
                      ),
                      RadioListTile<int>(
                        value: 1,
                        groupValue: _selectedFilter,
                        onChanged: (v) {
                          setState(() => _selectedFilter = v!);
                          Navigator.pop(context);
                        },
                        title: const Text('Les plus populaires'),
                      ),
                      RadioListTile<int>(
                        value: 2,
                        groupValue: _selectedFilter,
                        onChanged: (v) {
                          setState(() => _selectedFilter = v!);
                          Navigator.pop(context);
                        },
                        title: const Text('Les plus proches'),
                      ),
                    ],
                  ),
                ),
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
              decoration: InputDecoration(
                hintText: 'Rechercher un restaurant...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredRestaurants.isEmpty
                      ? const Center(child: Text('Aucun restaurant trouvé'))
                      : ListView.builder(
                          itemCount: _filteredRestaurants.length,
                          itemBuilder: (context, index) {
                            final restaurant = _filteredRestaurants[index];
                            return _buildRestaurantCard(restaurant);
                          },
                        ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newRestaurant = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(builder: (_) => const AddRestaurantPage()),
          );
          if (newRestaurant != null) {
            setState(() => restaurants.add(newRestaurant));
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Ajouter"),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildRestaurantCard(Map<String, dynamic> restaurant) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RestaurantOrderPage(restaurant: restaurant),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Image.network(
                  restaurant['image'],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => const Icon(Icons.restaurant, size: 50),
                ),
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
                      Expanded(
                        child: Text(
                          restaurant['name'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Chip(
                        label: Text('${restaurant['rating'] ?? 'N/A'}'),
                        backgroundColor: Colors.amber.withOpacity(0.2),
                        labelStyle: const TextStyle(color: Colors.amber),
                        avatar: const Icon(Icons.star, size: 16, color: Colors.amber),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          restaurant['location'],
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    restaurant['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Plat: ${restaurant['plat']}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${restaurant['price']} FCFA',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
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
