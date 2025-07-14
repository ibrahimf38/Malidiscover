// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// //import 'dart:io' show Platform;

// class MyProfilePage extends StatefulWidget {
//   const MyProfilePage({super.key});
//   @override
//   State<MyProfilePage> createState() => _MyProfilePageState();
// }

// class _MyProfilePageState extends State<MyProfilePage> {
//   String name = "Nom";
//   String prenom = "Prenom";
//   String phoneNumber = "";
//   String email = "Nomprenom@gmail.com";
//   String profilePictureUrl = "https://example.com/profile.jpg";
//   String password = "";

//   // Controller pour TextFields
//   TextEditingController nomController = TextEditingController();
//   TextEditingController prenomController = TextEditingController();
//   TextEditingController callPhoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   // Google Sign-In instance
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers with current profile data
//     nomController.text = name;
//     prenomController.text = prenom;
//     callPhoneController.text = phoneNumber;
//     emailController.text = email;
//     passwordController.text = password;
//   }

//   @override
//   void dispose() {
//     nomController.dispose();
//     prenomController.dispose();
//     callPhoneController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   final GoogleSignIn googleSignIn = GoogleSignIn(
//     clientId: '1:166994087785:android:c309997c1d51595740f7f8', // ← À remplacer
//   );
//   Future<void> _signInWithGoogle() async {
//     try {
//       // Trigger the Google Sign-In flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       if (googleUser != null) {
//         // Obtain the authentication details from the request
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;

//         // Create a new credential
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         // Sign in with the credential

//         final UserCredential userCredential = await _auth.signInWithCredential(
//           credential,
//         );

//         // Get the user's information
//         User? user = userCredential.user;

//         setState(() {
//           name = user?.displayName ?? "pas de nom";
//           prenom = user?.displayName ?? "pas de prenom";
//           phoneNumber = user?.phoneNumber ?? "pas de numero de telephone";
//           email = user?.email ?? "pas d'Email";
//           profilePictureUrl =
//               user?.photoURL ?? "https://example.com/default_profile.jpg";
//           password = "";
//           // Reset password after successful login
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Logged in as ${user?.displayName}')),
//         );
//       }
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to sign in with Google: $e')),
//       );
//     }
//   }

//   void saveProfile() {
//     setState(() {
//       name = nomController.text;
//       prenom = prenomController.text;
//       phoneNumber = callPhoneController.text;
//       email = emailController.text;
//       password = passwordController.text;
//     });
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('Profile updated!')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MaliDiscover', style: TextStyle(color: Colors.lightGreen)),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await _googleSignIn.signOut();
//               await FirebaseAuth.instance.signOut();
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text('Logged out')));
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Profile Picture Section
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage(profilePictureUrl),
//               ),
//               SizedBox(height: 20),
//               // Name Field
//               TextField(
//                 controller: nomController,
//                 decoration: InputDecoration(
//                   labelText: 'Nom',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: prenomController,
//                 decoration: InputDecoration(
//                   labelText: 'Prenom',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: callPhoneController,
//                 decoration: InputDecoration(
//                   labelText: 'Telephone',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Email Field
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Champ de texte pour le mot de passe
//               TextField(
//                 controller: passwordController,
//                 obscureText: true, // Masquer le texte pour le mot de passe
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text("$prenom $name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               Text(email, style: TextStyle(color: Colors.grey[600])),

//               // Save Button
//               ElevatedButton(onPressed: saveProfile, child: Text('Enregistre'), ),
//               SizedBox(height: 20),
//               Text("Or", style: TextStyle(color: Colors.black)),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _signInWithGoogle,
//                 child: Text('Sign in with Google'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// //import 'dart:io' show Platform;

// class MyProfilePage extends StatefulWidget {
//   const MyProfilePage({super.key});
//   @override
//   State<MyProfilePage> createState() => _MyProfilePageState();
// }

// class _MyProfilePageState extends State<MyProfilePage> {
//   String name = "Nom";
//   String prenom = "Prenom";
//   String phoneNumber = "";
//   String email = "Nomprenom@gmail.com";
//   String profilePictureUrl = "https://example.com/profile.jpg";
//   String password = "";

//   // Controller pour TextFields
//   TextEditingController nomController = TextEditingController();
//   TextEditingController prenomController = TextEditingController();
//   TextEditingController callPhoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   // Google Sign-In instance
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers with current profile data
//     nomController.text = name;
//     prenomController.text = prenom;
//     callPhoneController.text = phoneNumber;
//     emailController.text = email;
//     passwordController.text = password;
//   }

//   @override
//   void dispose() {
//     nomController.dispose();
//     prenomController.dispose();
//     callPhoneController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   final GoogleSignIn googleSignIn = GoogleSignIn(
//     clientId: '1:166994087785:android:c309997c1d51595740f7f8', // ← À remplacer
//   );
//   Future<void> _signInWithGoogle() async {
//     try {
//       // Trigger the Google Sign-In flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       if (googleUser != null) {
//         // Obtain the authentication details from the request
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;

//         // Create a new credential
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         // Sign in with the credential

//         final UserCredential userCredential = await _auth.signInWithCredential(
//           credential,
//         );

//         // Get the user's information
//         User? user = userCredential.user;

//         setState(() {
//           name = user?.displayName ?? "pas de nom";
//           prenom = user?.displayName ?? "pas de prenom";
//           phoneNumber = user?.phoneNumber ?? "pas de numero de telephone";
//           email = user?.email ?? "pas d'Email";
//           profilePictureUrl =
//               user?.photoURL ?? "https://example.com/default_profile.jpg";
//           password = "";
//           // Reset password after successful login
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Logged in as ${user?.displayName}')),
//         );
//       }
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to sign in with Google: $e')),
//       );
//     }
//   }

//   void saveProfile() {
//     setState(() {
//       name = nomController.text;
//       prenom = prenomController.text;
//       phoneNumber = callPhoneController.text;
//       email = emailController.text;
//       password = passwordController.text;
//     });
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('Profile updated!')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MaliDiscover', style: TextStyle(color: Colors.lightGreen)),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await _googleSignIn.signOut();
//               await FirebaseAuth.instance.signOut();
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text('Logged out')));
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Profile Picture Section
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage(profilePictureUrl),
//               ),
//               SizedBox(height: 20),
//               // Name Field
//               TextField(
//                 controller: nomController,
//                 decoration: InputDecoration(
//                   labelText: 'Nom',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: prenomController,
//                 decoration: InputDecoration(
//                   labelText: 'Prenom',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: callPhoneController,
//                 decoration: InputDecoration(
//                   labelText: 'Telephone',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Email Field
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Champ de texte pour le mot de passe
//               TextField(
//                 controller: passwordController,
//                 obscureText: true, // Masquer le texte pour le mot de passe
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text("$prenom $name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               Text(email, style: TextStyle(color: Colors.grey[600])),

//               // Save Button
//               ElevatedButton(onPressed: saveProfile, child: Text('Enregistre'), ),
//               SizedBox(height: 20),
//               Text("Or", style: TextStyle(color: Colors.black)),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _signInWithGoogle,
//                 child: Text('Sign in with Google'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

















import 'package:app01/pages/acceil_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  // Données du profil
  String name = "Nom";
  String prenom = "Prenom";
  String phoneNumber = "";
  String email = "Nomprenom@gmail.com";
  String profilePictureUrl = "https://www.gravatar.com/avatar/default?s=200";
  bool isLoggedIn = false;
  bool _isEditing = false;

  // Contrôleurs
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "Nom";
      prenom = prefs.getString('prenom') ?? "Prenom";
      phoneNumber = prefs.getString('phoneNumber') ?? "";
      email = prefs.getString('email') ?? "Nomprenom@gmail.com";
      profilePictureUrl = prefs.getString('profilePictureUrl') ?? 
          "https://www.gravatar.com/avatar/default?s=200";
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      
      _nomController.text = name;
      _prenomController.text = prenom;
      _phoneController.text = phoneNumber;
      _emailController.text = email;
    });
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('prenom', prenom);
    await prefs.setString('phoneNumber', phoneNumber);
    await prefs.setString('email', email);
    await prefs.setString('profilePictureUrl', profilePictureUrl);
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        setState(() {
          name = googleUser.displayName?.split(" ").first ?? "Nom";
          prenom = googleUser.displayName?.split(" ").last ?? "Prenom";
          email = googleUser.email ?? "Nomprenom@gmail.com";
          profilePictureUrl = googleUser.photoUrl ?? 
              "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=retro&s=200";
          isLoggedIn = true;
          
          _nomController.text = name;
          _prenomController.text = prenom;
          _emailController.text = email;
        });

        await _saveProfileData();
        _showSnackBar('Connecté en tant que ${googleUser.displayName}');
      }
    } catch (e) {
      _showSnackBar('Échec de la connexion avec Google: $e');
    }
  }

  void _saveProfile() {
    setState(() {
      name = _nomController.text;
      prenom = _prenomController.text;
      phoneNumber = _phoneController.text;
      email = _emailController.text;
      isLoggedIn = true;
      _isEditing = false;
    });

    _saveProfileData();
    _showSnackBar('Profil mis à jour!');
  }

  Future<void> _logout() async {
    try {
      await _googleSignIn.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      setState(() {
        name = "Nom";
        prenom = "Prenom";
        phoneNumber = "";
        email = "Nomprenom@gmail.com";
        profilePictureUrl = "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=retro&s=200";
        isLoggedIn = false;
        _isEditing = false;
        
        _nomController.clear();
        _prenomController.clear();
        _phoneController.clear();
        _emailController.clear();
        _passwordController.clear();
      });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AcceilPage()),
        (route) => false,
      );

      _showSnackBar('Déconnexion réussie');
    } catch (e) {
      _showSnackBar('Erreur lors de la déconnexion: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Mon Profil', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          if (isLoggedIn)
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: _logout,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Section Photo de Profil
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.teal.withOpacity(0.5),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      profilePictureUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / 
                                  loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => 
                          Icon(Icons.person, size: 60, color: Colors.grey),
                    ),
                  ),
                ),
                if (_isEditing)
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.camera_alt, size: 20),
                    onPressed: () {
                      // Ajouter la logique pour changer la photo
                    },
                  ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Nom et Prénom
            Text(
              "$prenom $name",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            
            const SizedBox(height: 5),
            
            // Email
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Bouton d'édition
            if (!_isEditing && isLoggedIn)
              ElevatedButton(
                onPressed: () => setState(() => _isEditing = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'Modifier le Profil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            
            if (_isEditing || !isLoggedIn) ...[
              const SizedBox(height: 30),
              
              // Formulaire
              _buildFormField(
                controller: _nomController,
                label: 'Nom',
                icon: Icons.person,
                enabled: _isEditing || !isLoggedIn,
              ),
              
              const SizedBox(height: 15),
              
              _buildFormField(
                controller: _prenomController,
                label: 'Prénom',
                icon: Icons.person_outline,
                enabled: _isEditing || !isLoggedIn,
              ),
              
              const SizedBox(height: 15),
              
              _buildFormField(
                controller: _phoneController,
                label: 'Téléphone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                enabled: _isEditing || !isLoggedIn,
              ),
              
              const SizedBox(height: 15),
              
              _buildFormField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                enabled: _isEditing || !isLoggedIn,
              ),
              
              if (_isEditing || !isLoggedIn) ...[
                const SizedBox(height: 15),
                
                _buildFormField(
                  controller: _passwordController,
                  label: 'Mot de passe',
                  icon: Icons.lock,
                  obscureText: true,
                  enabled: _isEditing || !isLoggedIn,
                ),
              ],
              
              const SizedBox(height: 30),
              
              // Boutons d'action
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_isEditing)
                    OutlinedButton(
                      onPressed: () {
                        setState(() => _isEditing = false);
                        _loadProfileData(); // Recharger les données originales
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.teal),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      ),
                      child: Text(
                        'Annuler',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                  
                  ElevatedButton(
                    onPressed: _isEditing || !isLoggedIn ? _saveProfile : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: _isEditing ? 25 : 30, 
                        vertical: 12
                      ),
                    ),
                    child: Text(
                      _isEditing ? 'Enregistrer' : 
                      isLoggedIn ? 'Connecté' : 'Créer un compte',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
            
            if (!isLoggedIn) ...[
              const SizedBox(height: 30),
              
              // Séparateur
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[400])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'OU',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[400])),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Connexion Google
              OutlinedButton.icon(
                onPressed: _signInWithGoogle,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                ),
                icon: Image.asset(
                  'assets/images/google_logo.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  'Continuer avec Google',
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    bool enabled = true,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey[100],
      ),
    );
  }
}
