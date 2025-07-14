
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddRestaurantPage extends StatefulWidget {
//   const AddRestaurantPage({super.key});

//   @override
//   State<AddRestaurantPage> createState() => _AddRestaurantPageState();
// }

// class _AddRestaurantPageState extends State<AddRestaurantPage> {
//   final _formKey = GlobalKey<FormState>();

//   final nameController = TextEditingController();
//   final locationController = TextEditingController();
//   final ownerFirstNameController = TextEditingController();
//   final ownerLastNameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final priceController = TextEditingController();

//   File? _selectedImage;
//   Uint8List? _webImage;
//   String? _selectedPayment;

//   Future<void> _pickImage(ImageSource source) async {
//     final picked = await ImagePicker().pickImage(source: source);
//     if (picked != null) {
//       if (kIsWeb) {
//         final bytes = await picked.readAsBytes();
//         setState(() {
//           _webImage = bytes;
//           _selectedImage = null;
//         });
//       } else {
//         setState(() {
//           _selectedImage = File(picked.path);
//           _webImage = null;
//         });
//       }
//     }
//   }

//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       if (_selectedImage == null && _webImage == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Veuillez sélectionner une image.')),
//         );
//         return;
//       }

//       if (_selectedPayment == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Veuillez sélectionner un mode de paiement.')),
//         );
//         return;
//       }

//       String? imageData;
//       if (_webImage != null) {
//         imageData = 'data:image/png;base64,${base64Encode(_webImage!)}';
//       } else if (_selectedImage != null) {
//         imageData = _selectedImage!.path;
//       }

//       final restaurantData = {
//         'name': nameController.text,
//         'location': locationController.text,
//         'ownerFirstName': ownerFirstNameController.text,
//         'ownerLastName': ownerLastNameController.text,
//         'phone': phoneController.text,
//         'email': emailController.text,
//         'description': descriptionController.text,
//         'price': priceController.text,
//         'payment': _selectedPayment!,
//         'image': imageData!,
//       };

//       showDialog(
//       context: context , 
//       builder: 
//        (_) => AlertDialog(
//               title: const Text("Succès"),
//               content: const Text("Votre restaurant ajouté avec succès !"),
//                actions: [
//       TextButton(
//         onPressed: () {
//           Navigator.of(context).pop(); // Fermer le dialogue
//           Navigator.of(context).pop(restaurantData); // Retourner les données
//         },
//         child: const Text("OK"),
//       ),
//     ],
//             ),
//       );
//     }
//   }

//   Widget buildPaymentOptions() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Mode de paiement", style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 10),
//         RadioListTile<String>(
//           value: 'orange',
//           groupValue: _selectedPayment,
//           onChanged: (v) => setState(() => _selectedPayment = v),
//           title: const Text("Orange Money"),
//           secondary: Image.asset('assets/images/orange.png', width: 45),
//         ),
//         RadioListTile<String>(
//           value: 'moov',
//           groupValue: _selectedPayment,
//           onChanged: (v) => setState(() => _selectedPayment = v),
//           title: const Text("Moov Africa"),
//           secondary: Image.asset('assets/images/moov.png', width: 45),
//         ),
//         RadioListTile<String>(
//           value: 'carte',
//           groupValue: _selectedPayment,
//           onChanged: (v) => setState(() => _selectedPayment = v),
//           title: const Text("Carte bancaire"),
//           secondary: Image.asset('assets/images/banque.png', width: 45),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Ajouter un Restaurant")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'Nom du Restaurant', border: OutlineInputBorder()),
//                 validator: (v) => v!.isEmpty ? 'Entrez le nom du restaurant' : null,
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: locationController,
//                 decoration: const InputDecoration(labelText: 'Localisation', border: OutlineInputBorder()),
//                 validator: (v) => v!.isEmpty ? 'Entrez la localisation' : null,
//               ),
//               const SizedBox(height: 20),
//               const Text("Photo du restaurant", style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               if (_selectedImage != null)
//                 Image.file(_selectedImage!, height: 200, fit: BoxFit.cover)
//               else if (_webImage != null)
//                 Image.memory(_webImage!, height: 200, fit: BoxFit.cover),
//               Row(
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.gallery),
//                     icon: const Icon(Icons.photo),
//                     label: const Text("Galerie"),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.camera),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text("Caméra"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Divider(),
//               const Text("Informations du propriétaire", style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: ownerFirstNameController,
//                 decoration: const InputDecoration(labelText: 'Prénom', border: OutlineInputBorder()),
//                 validator: (v) => v!.isEmpty ? 'Entrez le prénom' : null,
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: ownerLastNameController,
//                 decoration: const InputDecoration(labelText: 'Nom', border: OutlineInputBorder()),
//                 validator: (v) => v!.isEmpty ? 'Entrez le nom' : null,
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: phoneController,
//                 decoration: const InputDecoration(labelText: 'Téléphone', border: OutlineInputBorder()),
//                 keyboardType: TextInputType.phone,
//                 validator: (v) => v!.isEmpty ? 'Entrez le numéro de téléphone' : null,
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: emailController,
//                 decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (v) => v!.isEmpty ? 'Entrez l’email' : null,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
//                 maxLines: 3,
//                 validator: (v) => v!.isEmpty ? 'Entrez une description' : null,
//               ),
//               const SizedBox(height: 20),
//               buildPaymentOptions(),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submit,
//                 child: const Text("Ajouter votre restaurant"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddHotelPage extends StatefulWidget {
  const AddHotelPage({super.key});

  @override
  State<AddHotelPage> createState() => _AddHotelPageState();
}

class _AddHotelPageState extends State<AddHotelPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final ownerFirstNameController = TextEditingController();
  final ownerLastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final roomController = TextEditingController();

  File? _selectedImage;
  Uint8List? _webImage;
  String? _selectedPayment;
  bool _isLoading = false;

  final List<String> _facilities = [
    'Wi-Fi',
    'Piscine',
    'Spa',
    'Restaurant',
    'Parking',
    'Climatisation',
    'Petit-déjeuner',
  ];
  final List<String> _selectedFacilities = [];

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(source: source);
      if (picked != null) {
        if (kIsWeb) {
          final bytes = await picked.readAsBytes();
          setState(() {
            _webImage = bytes;
            _selectedImage = null;
          });
        } else {
          setState(() {
            _selectedImage = File(picked.path);
            _webImage = null;
          });
        }
      }
    } catch (e) {
      _showSnackBar('Erreur lors de la sélection de l\'image: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImage == null && _webImage == null) {
      _showSnackBar('Veuillez sélectionner une image');
      return;
    }
    if (_selectedPayment == null) {
      _showSnackBar('Veuillez sélectionner un mode de paiement');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simuler un traitement asynchrone
      await Future.delayed(const Duration(seconds: 2));

      String? imageData;
      if (_webImage != null) {
        imageData = 'data:image/png;base64,${base64Encode(_webImage!)}';
      } else if (_selectedImage != null) {
        imageData = _selectedImage!.path;
      }

      final hotelData = {
        'name': nameController.text,
        'location': locationController.text,
        'ownerFirstName': ownerFirstNameController.text,
        'ownerLastName': ownerLastNameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'description': descriptionController.text,
        'price': priceController.text,
        'room': roomController.text,
        'payment': _selectedPayment!,
        'image': imageData!,
        'facilities': _selectedFacilities,
        'rating': 4.0, // Valeur par défaut
      };

      Navigator.of(context).pop(hotelData);
    } catch (e) {
      _showSnackBar('Erreur lors de l\'enregistrement: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildImageSelector() {
    return Column(
      children: [
        const Text(
          "Photo de l'hôtel",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(_selectedImage!,
                          fit: BoxFit.cover),
                    )
                  : _webImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(_webImage!, fit: BoxFit.cover),
                        )
                      : const Icon(Icons.hotel, size: 50, color: Colors.grey),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.blueAccent,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => SafeArea(
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('Galerie'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('Caméra'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add_a_photo, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mode de paiement accepté",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.5,
          children: [
            _buildPaymentOption('Orange Money', 'orange', Icons.phone_android),
            _buildPaymentOption('Moov Money', 'moov', Icons.phone_iphone),
            _buildPaymentOption('Carte bancaire', 'carte', Icons.credit_card),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentOption(String title, String value, IconData icon) {
    return Card(
      elevation: _selectedPayment == value ? 4 : 1,
      color: _selectedPayment == value ? Colors.blue[50] : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: _selectedPayment == value ? Colors.blue : Colors.grey[300]!,
          width: _selectedPayment == value ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() {
            _selectedPayment = value;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: Colors.blue),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFacilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Équipements disponibles",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _facilities.map((facility) {
            final isSelected = _selectedFacilities.contains(facility);
            return FilterChip(
              label: Text(facility),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedFacilities.add(facility);
                  } else {
                    _selectedFacilities.remove(facility);
                  }
                });
              },
              selectedColor: Colors.blue[100],
              checkmarkColor: Colors.blue,
              labelStyle: TextStyle(
                color: isSelected ? Colors.blue : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Ajouter un Hôtel"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _submit,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildImageSelector(),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nom de l\'Hôtel',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.hotel),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Entrez le nom de l\'hôtel' : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: 'Localisation',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Entrez la localisation' : null,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Informations du propriétaire",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ownerFirstNameController,
                            decoration: const InputDecoration(
                              labelText: 'Prénom',
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                v!.isEmpty ? 'Entrez le prénom' : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: ownerLastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Nom',
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                v!.isEmpty ? 'Entrez le nom' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Téléphone',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (v) =>
                          v!.isEmpty ? 'Entrez le numéro de téléphone' : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          v!.isEmpty ? 'Entrez l\'email' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 3,
                      validator: (v) =>
                          v!.isEmpty ? 'Entrez une description' : null,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: roomController,
                            decoration: const InputDecoration(
                              labelText: 'Type de chambre',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.king_bed),
                            ),
                            validator: (v) =>
                                v!.isEmpty ? 'Entrez le type de chambre' : null),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: priceController,
                            decoration: const InputDecoration(
                              labelText: 'Prix (FCFA/nuit)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.attach_money),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (v) =>
                                v!.isEmpty ? 'Entrez le prix' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildFacilities(),
                    const SizedBox(height: 20),
                    _buildPaymentOptions(),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _submit,
                      child: const Text(
                        "ENREGISTRER L'HÔTEL",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    ownerFirstNameController.dispose();
    ownerLastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    roomController.dispose();
    super.dispose();
  }
}
