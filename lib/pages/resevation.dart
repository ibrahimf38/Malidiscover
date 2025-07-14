// import 'package:flutter/material.dart';

// class HotelReservationPage extends StatefulWidget {
//   final Map<String, String> hotel;

//   const HotelReservationPage({super.key, required this.hotel});

//   @override
//   State<HotelReservationPage> createState() => _HotelReservationPageState();
// }

// class _HotelReservationPageState extends State<HotelReservationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();

//   DateTime? checkInDate;
//   DateTime? checkOutDate;

//   final List<Map<String, dynamic>> roomTypes = [
//     {'type': 'Chambre simple', 'price': 20000, 'quantity': 0},
//     {'type': 'Chambre double', 'price': 30000, 'quantity': 0},
//     {'type': 'Suite', 'price': 50000, 'quantity': 0},
//   ];

//   int get totalPrice {
//     return roomTypes.fold(0, (sum, room) =>
//   sum + (room['price'] as int) * (room['quantity'] as int));

//   }

//   Future<void> _selectDate(bool isCheckIn) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );

//     if (picked != null) {
//       setState(() {
//         if (isCheckIn) {
//           checkInDate = picked;
//         } else {
//           checkOutDate = picked;
//         }
//       });
//     }
//   }

//   void _submitReservation() {
//     if (_formKey.currentState!.validate() &&
//         totalPrice > 0 &&
//         checkInDate != null &&
//         checkOutDate != null &&
//         checkInDate!.isBefore(checkOutDate!)) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text("Réservation confirmée"),
//           content: Text(
//               "Merci ${nameController.text}, votre réservation de ${totalPrice} FCFA a été enregistrée."),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
//               child: const Text("Fermer"),
//             ),
//           ],
//         ),
//       );
//     } else if (checkInDate == null || checkOutDate == null || !checkInDate!.isBefore(checkOutDate!)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Veuillez choisir des dates valides.")),
//       );
//     } else if (totalPrice == 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Sélectionnez au moins une chambre.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Réserver à ${widget.hotel['name']}")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // 👤 Infos client
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: "Votre nom", border: OutlineInputBorder()),
//                 validator: (value) => value!.isEmpty ? 'Entrez votre nom' : null,
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: phoneController,
//                 decoration: const InputDecoration(labelText: "Téléphone", border: OutlineInputBorder()),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) => value!.isEmpty ? 'Entrez un numéro de téléphone' : null,
//               ),
//               const SizedBox(height: 20),

//               // 🗓 Dates
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => _selectDate(true),
//                       child: Text(checkInDate == null
//                           ? "Date d'arrivée"
//                           : "Arrivée : ${checkInDate!.toLocal().toString().split(' ')[0]}"),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => _selectDate(false),
//                       child: Text(checkOutDate == null
//                           ? "Date de départ"
//                           : "Départ : ${checkOutDate!.toLocal().toString().split(' ')[0]}"),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // 🛏️ Chambres
//               const Text("Types de chambres", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               const SizedBox(height: 10),
//               ...roomTypes.map((room) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(room['type']),
//                     subtitle: Text('${room['price']} FCFA / nuit'),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.remove),
//                           onPressed: () {
//                             setState(() {
//                               if (room['quantity'] > 0) room['quantity']--;
//                             });
//                           },
//                         ),
//                         Text('${room['quantity']}'),
//                         IconButton(
//                           icon: const Icon(Icons.add),
//                           onPressed: () {
//                             setState(() {
//                               room['quantity']++;
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),

//               const SizedBox(height: 20),
//               Text('Total : $totalPrice FCFA', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 20),

//               ElevatedButton.icon(
//                 onPressed: _submitReservation,
//                 icon: const Icon(Icons.hotel),
//                 label: const Text("Réserver maintenant"),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HotelReservationPage extends StatefulWidget {
  final Map<String, dynamic> hotel;

  const HotelReservationPage({super.key, required this.hotel});

  @override
  State<HotelReservationPage> createState() => _HotelReservationPageState();
}

class _HotelReservationPageState extends State<HotelReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _quantity = 1;
  bool _isLoading = false;

  int get _pricePerNight {
    return int.tryParse(widget.hotel['price'].toString()) ?? 0;
  }

  int get _totalNights {
    if (_checkInDate == null || _checkOutDate == null) return 0;
    return _checkOutDate!.difference(_checkInDate!).inDays;
  }

  int get _totalPrice {
    return _pricePerNight * _quantity * (_totalNights == 0 ? 1 : _totalNights);
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate != null && !_checkInDate!.isBefore(_checkOutDate!)) {
            _checkOutDate = null;
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  void _submitReservation() {
    if (!_formKey.currentState!.validate()) return;
    if (_checkInDate == null || _checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner les dates de séjour'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (!_checkInDate!.isBefore(_checkOutDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La date de départ doit être après la date d\'arrivée'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simuler un traitement asynchrone
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      _showConfirmationDialog();
    });
  }

  void _showConfirmationDialog() {
    final dateFormat = DateFormat('dd/MM/yyyy');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Réservation confirmée'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Merci ${_nameController.text} !'),
              const SizedBox(height: 10),
              Text(
                  'Votre réservation à ${widget.hotel['name']} a bien été enregistrée.'),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 10),
              _buildReservationDetailRow('Type de chambre:',
                  widget.hotel['room'] ?? 'Chambre Standard'),
              _buildReservationDetailRow(
                  'Dates:', '${dateFormat.format(_checkInDate!)} - ${dateFormat.format(_checkOutDate!)}'),
              _buildReservationDetailRow('Durée:', '$_totalNights nuits'),
              _buildReservationDetailRow('Nombre de chambres:', '$_quantity'),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              _buildReservationDetailRow(
                  'Total:', '$_totalPrice FCFA', isBold: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Retour à l\'accueil'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationDetailRow(String label, String value,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.blue : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(String label, DateTime? date, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date != null
                    ? DateFormat('dd/MM/yyyy').format(date)
                    : 'Sélectionner',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: date != null ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nombre de chambres',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                ),
                Text(
                  '$_quantity',
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réserver à ${widget.hotel['name']}'),
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
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.hotel['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16),
                                const SizedBox(width: 4),
                                Text(widget.hotel['location']),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${widget.hotel['price']} FCFA / nuit',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Vos informations',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nom complet',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Entrez votre nom' : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Téléphone',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'Entrez un numéro de téléphone' : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email (facultatif)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Dates de séjour',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        _buildDateSelector(
                          "Date d'arrivée",
                          _checkInDate,
                          () => _selectDate(context, true),
                        ),
                        const SizedBox(width: 10),
                        _buildDateSelector(
                          "Date de départ",
                          _checkOutDate,
                          () => _selectDate(context, false),
                        ),
                      ],
                    ),
                    if (_checkInDate != null && _checkOutDate != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Durée du séjour: $_totalNights nuits',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    _buildQuantitySelector(),
                    const SizedBox(height: 20),
                    const Text(
                      'Notes supplémentaires (facultatif)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        hintText: 'Demandes spéciales, remarques...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          if (_checkInDate != null && _checkOutDate != null)
                            _buildPriceDetailRow(
                              '${widget.hotel['price']} FCFA x $_quantity chambre(s) x $_totalNights nuits',
                              '${_pricePerNight * _quantity * _totalNights} FCFA',
                            ),
                          if (_checkInDate == null || _checkOutDate == null)
                            _buildPriceDetailRow(
                              '${widget.hotel['price']} FCFA x $_quantity chambre(s) x 1 nuit',
                              '${_pricePerNight * _quantity} FCFA',
                            ),
                          const Divider(height: 20),
                          _buildPriceDetailRow(
                            'Total',
                            '$_totalPrice FCFA',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _submitReservation,
                      child: const Text(
                        'CONFIRMER LA RÉSERVATION',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildPriceDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.blue : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
