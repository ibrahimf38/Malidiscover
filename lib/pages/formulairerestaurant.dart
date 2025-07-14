
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

class AddRestaurantPage extends StatefulWidget {
  const AddRestaurantPage({super.key});

  @override
  State<AddRestaurantPage> createState() => _AddRestaurantPageState();
}

class _AddRestaurantPageState extends State<AddRestaurantPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<TextEditingController> _controllers = List.generate(9, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(9, (_) => FocusNode());
  
  File? _selectedImage;
  Uint8List? _webImage;
  String? _selectedPayment;
  bool _isSubmitting = false;
  int _currentStep = 0;

  final List<Map<String, dynamic>> _paymentOptions = [
    {'value': 'orange', 'label': 'Orange Money', 'icon': 'assets/images/orange.png'},
    {'value': 'moov', 'label': 'Moov Africa', 'icon': 'assets/images/moov.png'},
    {'value': 'carte', 'label': 'Carte bancaire', 'icon': 'assets/images/banque.png'},
  ];

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(source: source, maxWidth: 800);
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImage == null && _webImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner une image.')),
      );
      return;
    }
    if (_selectedPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner un mode de paiement.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulation de traitement

    if (!mounted) return;
    
    final restaurantData = {
      'name': _controllers[0].text,
      'location': _controllers[1].text,
      'ownerFirstName': _controllers[2].text,
      'ownerLastName': _controllers[3].text,
      'phone': _controllers[4].text,
      'email': _controllers[5].text,
      'description': _controllers[6].text,
      'plat': _controllers[7].text,
      'price': _controllers[8].text,
      'quantity': '0',
      'payment': _selectedPayment!,
      'image': _webImage != null 
          ? 'data:image/png;base64,${base64Encode(_webImage!)}' 
          : _selectedImage!.path,
    };

    Navigator.of(context).pop(restaurantData);
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        const Text("Photo du restaurant", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: _selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_selectedImage!, fit: BoxFit.cover),
                  )
                : _webImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(_webImage!, fit: BoxFit.cover),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                          const SizedBox(height: 10),
                          Text('Ajouter une photo', style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text("Galerie"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text("Caméra"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),)
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Mode de paiement", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ..._paymentOptions.map((option) => RadioListTile<String>(
          value: option['value'],
          groupValue: _selectedPayment,
          onChanged: (v) => setState(() => _selectedPayment = v),
          title: Text(option['label']),
          secondary: Image.asset(option['icon'], width: 45),
        )).toList(),
      ],
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("Ajouter un Restaurant")),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0 && !_formKey.currentState!.validate()) return;
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          } else {
            _submit();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            Navigator.of(context).pop();
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                if (_currentStep != 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Retour'),
                    ),
                  ),
                if (_currentStep != 0) const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(_currentStep == 2 ? 'Soumettre' : 'Continuer'),
                  ),
                ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Informations de base'),
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controllers[0],
                    focusNode: _focusNodes[0],
                    decoration: const InputDecoration(
                      labelText: 'Nom du Restaurant',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.restaurant),
                    ),
                    validator: (v) => v!.isEmpty ? 'Ce champ est requis' : null,
                    onFieldSubmitted: (_) => _focusNodes[1].requestFocus(),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _controllers[1],
                    focusNode: _focusNodes[1],
                    decoration: const InputDecoration(
                      labelText: 'Localisation',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    validator: (v) => v!.isEmpty ? 'Ce champ est requis' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildImagePicker(),
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Détails du restaurant'),
            content: Column(
              children: [
                TextFormField(
                  controller: _controllers[6],
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                  validator: (v) => v!.isEmpty ? 'Ce champ est requis' : null,
                ),
                const SizedBox(height: 20),
                const Text("Menu", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllers[7],
                  decoration: const InputDecoration(
                    labelText: 'Nom du plat principal',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.fastfood),
                  ),
                  validator: (v) => v!.isEmpty ? 'Ce champ est requis' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllers[8],
                  decoration: const InputDecoration(
                    labelText: 'Prix (FCFA)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => v!.isEmpty ? 'Ce champ est requis' : null,
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Propriétaire & Paiement'),
            content: Column(
              children: [
                TextFormField(
                  controller: _controllers[2],
                  decoration: const InputDecoration(
                    labelText: 'Prénom du propriétaire',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (v) => v!.isEmpty ? 'Ce champ est requis' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllers[3],
                  decoration: const InputDecoration(
                    labelText: 'Nom du propriétaire',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) => v!.isEmpty ? 'Ce champ est requis' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllers[4],
                  decoration: const InputDecoration(
                    labelText: 'Téléphone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v!.isEmpty ? 'Ce champ est requis' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllers[5],
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => v!.isEmpty || !v.contains('@') 
                      ? 'Entrez un email valide' 
                      : null,
                ),
                const SizedBox(height: 20),
                _buildPaymentOptions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
