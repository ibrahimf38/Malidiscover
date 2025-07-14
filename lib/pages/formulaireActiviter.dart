// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class AddActivityPage extends StatefulWidget {
//   const AddActivityPage({super.key});

//   @override
//   State<AddActivityPage> createState() => _AddActivityPageState();
// }

// class _AddActivityPageState extends State<AddActivityPage> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   File? _selectedImage;
//   String? _selectedPayment;
//   String? _selectedCategory;
//   Uint8List? _webImage;
 

//   final List<String> _categories = [
//     'Randonnée',
//     'Concert',
//     'Conference',
//     'Visite historique',
//     'Festival',
//     'Excursion',
//     'Artisanat local',
//     'Gastronomie',
//     'Autre',
//   ];


//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       if (kIsWeb) {
//         final bytes = await pickedFile.readAsBytes();
//         setState(() {
//           _webImage = bytes;
//           _selectedImage = null;
//         });
//       } else {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
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
//           const SnackBar(
//             content: Text('Veuillez sélectionner un mode de paiement.'),
//           ),
//         );
//         return;
//       }
//       if (_selectedCategory == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Veuillez sélectionner une catégorie.')),
//         );
//         return;
//       }
//       String? imageData;
//       if (_webImage != null) {
//         imageData = 'data:image/png;base64,${base64Encode(_webImage!)}';
//       } else if (_selectedImage != null) {
//         imageData = _selectedImage!.path;
//       }

//       final activiteData = {
//          'name': nameController.text,
//         'location': locationController.text,
//         'phone': phoneController.text,
//         'email': emailController.text,
//         'description': descriptionController.text,
//         'payment': _selectedPayment!,
//         'image': imageData!,
//       };
      

//       showDialog(
//         context: context ,
//         builder:
//             (_) => AlertDialog(
//               title: const Text("Succès"),
//               content: const Text("Activite ajouté avec succès !"),
//                actions: [
//       TextButton(
//         onPressed: () {
//           Navigator.of(context).pop(); // Fermer le dialogue
//           Navigator.of(context).pop(activiteData); // Retourner les données
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
//         const Text(
//           "Mode de paiement",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         RadioListTile<String>(
//           value: 'orange',
//           groupValue: _selectedPayment,
//           onChanged: (value) => setState(() => _selectedPayment = value),
//           title: const Text("Orange Money"),
//           secondary: Image.asset('assets/images/orange.png', width: 45),
//         ),
//         RadioListTile<String>(
//           value: 'moov',
//           groupValue: _selectedPayment,
//           onChanged: (value) => setState(() => _selectedPayment = value),
//           title: const Text("Moov Africa"),
//           secondary: Image.asset('assets/images/moov.png', width: 45),
//         ),
//         RadioListTile<String>(
//           value: 'carte',
//           groupValue: _selectedPayment,
//           onChanged: (value) => setState(() => _selectedPayment = value),
//           title: const Text("Carte bancaire"),
//           secondary: Image.asset('assets/images/banque.png', width: 45),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Ajouter une activité")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Nom de l\'activité',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator:
//                     (value) =>
//                         value!.isEmpty ? 'Entrez le nom de l\'activité' : null,
//               ),
//               const SizedBox(height: 10),

//               TextFormField(
//                 controller: locationController,
//                 decoration: const InputDecoration(
//                   labelText: 'Localisation (ville, lieu précis...)',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator:
//                     (value) => value!.isEmpty ? 'Entrez la localisation' : null,
//               ),
//               const SizedBox(height: 10),

//               DropdownButtonFormField<String>(
//                 value: _selectedCategory,
//                 decoration: const InputDecoration(
//                   labelText: 'Catégorie de l\'activité',
//                   border: OutlineInputBorder(),
//                 ),
//                 items:
//                     _categories.map((String category) {
//                       return DropdownMenuItem<String>(
//                         value: category,
//                         child: Text(category),
//                       );
//                     }).toList(),
//                 onChanged: (value) => setState(() => _selectedCategory = value),
//                 validator:
//                     (value) =>
//                         value == null ? 'Sélectionnez une catégorie' : null,
//               ),
//               const SizedBox(height: 20),

//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Photo de l'activité",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   if (_selectedImage != null)
//                    Image.file(_selectedImage!, height: 200, fit: BoxFit.cover)
//                    else if (_webImage != null)
//                     Image.memory(_webImage!, height: 200, fit: BoxFit.cover),
//                   Row(
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () => _pickImage(ImageSource.gallery),
//                         icon: const Icon(Icons.photo),
//                         label: const Text("Galerie"),
//                       ),
//                       const SizedBox(width: 10),
//                       ElevatedButton.icon(
//                         onPressed: () => _pickImage(ImageSource.camera),
//                         icon: const Icon(Icons.camera_alt),
//                         label: const Text("Caméra"),
//                       ),
//                     ],
//                   ),
//                   if (_selectedImage != null)
//                     const Padding(
//                       padding: EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         "Aucune image sélectionnée",
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               TextFormField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(
//                   labelText: 'Description de l\'activité',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 4,
//                 validator:
//                     (value) => value!.isEmpty ? 'Entrez une description' : null,
//               ),
//               const SizedBox(height: 10),

//               TextFormField(
//                 controller: phoneController,
//                 decoration: const InputDecoration(
//                   labelText: 'Numéro de téléphone pour contact',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.phone,
//                 validator:
//                     (value) => value!.isEmpty ? 'Entrez un numéro' : null,
//               ),
//               const SizedBox(height: 10),

//               TextFormField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'Email de contact (optionnel)',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               const SizedBox(height: 20),

//               buildPaymentOptions(),

//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submit,
//                 child: const Text("Ajouter l'activité"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }








import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  final _scrollController = ScrollController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? _selectedImage;
  String? _selectedPayment;
  String? _selectedCategory;
  Uint8List? _webImage;
  int _currentStep = 0;
  bool _isSubmitting = false;

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

  final List<String> _requiredFields = [
    'Nom de l\'activité',
    'Localisation',
    'Catégorie',
    'Description',
    'Numéro de téléphone',
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

  void _nextStep() {
    if (_currentStep == 0 && !_validateStep1()) return;
    if (_currentStep < 2) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateStep1() {
    return nameController.text.isNotEmpty && 
           locationController.text.isNotEmpty && 
           _selectedCategory != null;
  }

  bool _validateStep2() {
    return descriptionController.text.isNotEmpty && 
           phoneController.text.isNotEmpty;
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

    // Simuler un traitement asynchrone
    await Future.delayed(const Duration(seconds: 2));

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
      'category': _selectedCategory!,
      'image': imageData!,
    };

    setState(() => _isSubmitting = false);

    if (!mounted) return;

    Navigator.pop(context, activiteData);
  }

  Widget buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mode de paiement",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ChoiceChip(
              label: const Text("Orange Money"),
              selected: _selectedPayment == 'orange',
              onSelected: (selected) => setState(() {
                _selectedPayment = selected ? 'orange' : null;
              }),
              avatar: Image.asset('assets/images/orange.png', width: 25),
              selectedColor: Colors.orange.withOpacity(0.2),
            ),
            ChoiceChip(
              label: const Text("Moov Africa"),
              selected: _selectedPayment == 'moov',
              onSelected: (selected) => setState(() {
                _selectedPayment = selected ? 'moov' : null;
              }),
              avatar: Image.asset('assets/images/moov.png', width: 25),
              selectedColor: Colors.blue.withOpacity(0.2),
            ),
            ChoiceChip(
              label: const Text("Carte bancaire"),
              selected: _selectedPayment == 'carte',
              onSelected: (selected) => setState(() {
                _selectedPayment = selected ? 'carte' : null;
              }),
              avatar: Image.asset('assets/images/banque.png', width: 25),
              selectedColor: Colors.green.withOpacity(0.2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          width: _currentStep == index ? 24 : 12,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _currentStep == index 
                ? Theme.of(context).primaryColor 
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter une activité"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildStepIndicator(),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Étape 1: Informations de base
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Nom de l\'activité',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.title),
                          ),
                          validator: (value) => value!.isEmpty 
                              ? 'Ce champ est requis' 
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: locationController,
                          decoration: InputDecoration(
                            labelText: 'Localisation',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.location_on),
                          ),
                          validator: (value) => value!.isEmpty 
                              ? 'Ce champ est requis' 
                              : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            labelText: 'Catégorie',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.category),
                          ),
                          items: _categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() => _selectedCategory = value),
                          validator: (value) => value == null 
                              ? 'Ce champ est requis' 
                              : null,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Photo de l'activité",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _showImagePickerDialog(),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              ),
                              color: Colors.grey.shade100,
                            ),
                            child: _selectedImage != null || _webImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: kIsWeb
                                        ? Image.memory(_webImage!, fit: BoxFit.cover)
                                        : Image.file(_selectedImage!, fit: BoxFit.cover),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.add_a_photo, size: 40),
                                      SizedBox(height: 8),
                                      Text("Ajouter une photo"),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Étape 2: Description et contacts
                  SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignLabelWithHint: true,
                          ),
                          maxLines: 5,
                          validator: (value) => value!.isEmpty 
                              ? 'Ce champ est requis' 
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Numéro de téléphone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) => value!.isEmpty 
                              ? 'Ce champ est requis' 
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email (optionnel)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                  
                  // Étape 3: Paiement et soumission
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildPaymentOptions(),
                        const SizedBox(height: 32),
                        if (_isSubmitting)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        else
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Valider l'activité",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _prevStep,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Retour"),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _currentStep == 2 ? "Terminer" : "Suivant",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Galerie photos"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Prendre une photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
