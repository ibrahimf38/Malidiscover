import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? _selectedImage;
  String? _selectedPayment;
  String? _selectedCategory;
  Uint8List? _webImage;
 

  final List<String> _categories = [
    'Randonnée',
    'Concert',
    'Conference',
    'Visite historique',
    'Festival',
    'Excursion',
    'Artisanat local',
    'Gastronomie',
    'Autre',
  ];


  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImage = bytes;
          _selectedImage = null;
        });
      } else {
        setState(() {
          _selectedImage = File(pickedFile.path);
          _webImage = null;
        });
      }
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null && _webImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez sélectionner une image.')),
        );
        return;
      }
      if (_selectedPayment == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner un mode de paiement.'),
          ),
        );
        return;
      }
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez sélectionner une catégorie.')),
        );
        return;
      }
      String? imageData;
      if (_webImage != null) {
        imageData = 'data:image/png;base64,${base64Encode(_webImage!)}';
      } else if (_selectedImage != null) {
        imageData = _selectedImage!.path;
      }

      final activiteData = {
         'name': nameController.text,
        'location': locationController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'description': descriptionController.text,
        'payment': _selectedPayment!,
        'image': imageData!,
      };
      

      showDialog(
        context: context ,
        builder:
            (_) => AlertDialog(
              title: const Text("Succès"),
              content: const Text("Activite ajouté avec succès !"),
               actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(); // Fermer le dialogue
          Navigator.of(context).pop(activiteData); // Retourner les données
        },
        child: const Text("OK"),
      ),
    ],
            ),
      );
    }
  }

  Widget buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mode de paiement",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        RadioListTile<String>(
          value: 'orange',
          groupValue: _selectedPayment,
          onChanged: (value) => setState(() => _selectedPayment = value),
          title: const Text("Orange Money"),
          secondary: Image.asset('assets/images/orange.png', width: 45),
        ),
        RadioListTile<String>(
          value: 'moov',
          groupValue: _selectedPayment,
          onChanged: (value) => setState(() => _selectedPayment = value),
          title: const Text("Moov Africa"),
          secondary: Image.asset('assets/images/moov.png', width: 45),
        ),
        RadioListTile<String>(
          value: 'carte',
          groupValue: _selectedPayment,
          onChanged: (value) => setState(() => _selectedPayment = value),
          title: const Text("Carte bancaire"),
          secondary: Image.asset('assets/images/banque.png', width: 45),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter une activité")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom de l\'activité',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Entrez le nom de l\'activité' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Localisation (ville, lieu précis...)',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) => value!.isEmpty ? 'Entrez la localisation' : null,
              ),
              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Catégorie de l\'activité',
                  border: OutlineInputBorder(),
                ),
                items:
                    _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                validator:
                    (value) =>
                        value == null ? 'Sélectionnez une catégorie' : null,
              ),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Photo de l'activité",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  if (_selectedImage != null)
                   Image.file(_selectedImage!, height: 200, fit: BoxFit.cover)
                   else if (_webImage != null)
                    Image.memory(_webImage!, height: 200, fit: BoxFit.cover),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.photo),
                        label: const Text("Galerie"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.camera),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text("Caméra"),
                      ),
                    ],
                  ),
                  if (_selectedImage != null)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Aucune image sélectionnée",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description de l\'activité',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator:
                    (value) => value!.isEmpty ? 'Entrez une description' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Numéro de téléphone pour contact',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator:
                    (value) => value!.isEmpty ? 'Entrez un numéro' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email de contact (optionnel)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              buildPaymentOptions(),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Ajouter l'activité"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
