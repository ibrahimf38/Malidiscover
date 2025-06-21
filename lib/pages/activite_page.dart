import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:app01/pages/formulaireActiviter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController mapController = MapController();
  final List<Map<String, dynamic>> locations = [];
  final LatLng _maliCenter = LatLng(18.5707, -2.9962);
  double _zoom = 6.6;

  @override
  void initState() {
    super.initState();
    _initializeLocations();
  }

  void _initializeLocations() {
    final data = [
      // Monuments
      {"lat": 12.6392, "lng": -8.0029, "title": "Monument de l’Indépendance", "color": Colors.yellow},
      {"lat": 12.6530, "lng": -8.0020, "title": "Monument de la Paix", "color": Colors.yellow},
      {"lat": 12.6152, "lng": -7.9844, "title": "Tour d’Afrique", "color": Colors.yellow},
      {"lat": 12.6496, "lng": -8.0002, "title": "Monument des Martyrs", "color": Colors.yellow},
      {"lat": 12.6385, "lng": -8.0049, "title": "Monument de la République", "color": Colors.yellow},
      {"lat": 12.6470, "lng": -8.0038, "title": "Monument Kwame Nkrumah", "color": Colors.yellow},
      {"lat": 11.3172, "lng": -5.6662, "title": "Monument Babemba Traoré", "color": Colors.yellow},
      {"lat": 12.8600, "lng": -5.4689, "title": "Monument Samory Touré", "color": Colors.yellow},

      // Sites
      {"lat": 14.4560, "lng": -11.4394, "title": "Tombouctou", "color": Colors.green},
      {"lat": 14.3526, "lng": -10.7810, "title": "Djenné", "color": Colors.green},
      {"lat": 13.4450, "lng": -9.4858, "title": "Pays Dogon", "color": Colors.green},
      {"lat": 13.9058, "lng": -3.5269, "title": "Ségou", "color": Colors.green},
      {"lat": 14.3333, "lng": -3.5833, "title": "Falaises de Bandiagara", "color": Colors.green},
      {"lat": 13.9049, "lng": -4.5532, "title": "Delta intérieur du Niger", "color": Colors.green},
      {"lat": 13.5500, "lng": -5.1000, "title": "Lac Débo", "color": Colors.green},
      {"lat": 13.6333, "lng": -5.5000, "title": "Réserve de la Boucle du Baoulé", "color": Colors.green},
      {"lat": 12.6125, "lng": -7.9747, "title": "Parc national de Bamako", "color": Colors.green},
      {"lat": 11.3233, "lng": -5.6636, "title": "Forêt classée de Wongo", "color": Colors.green},

      // Activités
      {"lat": 14.5126, "lng": -4.1186, "title": "Randonnée à Ségou", "color": Colors.orange},
      {"lat": 12.6392, "lng": -8.0029, "title": "Festival culturel à Bamako", "color": Colors.orange},
      {"lat": 13.4450, "lng": -9.4858, "title": "Exploration du Pays Dogon", "color": Colors.orange},
    ];

    setState(() {
      locations.clear();
      locations.addAll(data);
    });
  }

  List<Marker> get _markers => locations.map((loc) {
        return Marker(
          point: LatLng(loc["lat"], loc["lng"]),
          width: 40,
          height: 40,
          child: Tooltip(
            message: loc["title"],
            child: Icon(Icons.location_on, color: loc["color"], size: 30),
          ),
        );
      }).toList();

  void _addUserActivity() async {
    final newActivity = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddActivityPage()),
    );

    if (newActivity != null) {
      setState(() {
        locations.add({
          "lat": 13.0 + locations.length * 0.02,
          "lng": -6.0,
          "title": newActivity['name'],
          "color": Colors.orange,
        });
      });
    }
  }

  void _zoomIn() {
    setState(() {
      _zoom += 0.5;
      mapController.move(mapController.center, _zoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _zoom -= 0.5;
      mapController.move(mapController.center, _zoom);
    });
  }

  void _resetMap() {
    mapController.move(_maliCenter, 6.6);
    setState(() {
      _zoom = 6.6;
    });
  }

  void _centerOnLocation(double lat, double lng) {
    mapController.move(LatLng(lat, lng), 8.5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Carte des Activités")),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: _maliCenter,
              zoom: _zoom,
              interactiveFlags: InteractiveFlag.all,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(markers: _markers),
            ],
          ),
          Positioned(
            top: 20,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoom_in',
                  mini: true,
                  onPressed: _zoomIn,
                  child: Icon(Icons.zoom_in),
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoom_out',
                  mini: true,
                  onPressed: _zoomOut,
                  child: Icon(Icons.zoom_out),
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'reset',
                  mini: true,
                  onPressed: _resetMap,
                  child: Icon(Icons.my_location),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              color: Colors.white.withOpacity(0.85),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final loc = locations[index];
                  return GestureDetector(
                    onTap: () => _centerOnLocation(loc["lat"], loc["lng"]),
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: loc["color"]),
                            SizedBox(width: 6),
                            Text(loc["title"], style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addUserActivity,
        label: const Text("Ajouter activité"),
        icon: const Icon(Icons.add_location),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
