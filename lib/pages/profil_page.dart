import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'dart:io' show Platform;

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String name = "Nom";
  String prenom = "Prenom";
  String phoneNumber = "";
  String email = "Nomprenom@gmail.com";
  String profilePictureUrl = "https://example.com/profile.jpg";
  String password = "";

  // Controller pour TextFields
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController callPhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Google Sign-In instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current profile data
    nomController.text = name;
    prenomController.text = prenom;
    callPhoneController.text = phoneNumber;
    emailController.text = email;
    passwordController.text = password;
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    callPhoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '1:166994087785:android:c309997c1d51595740f7f8', // ← À remplacer
  );
  Future<void> _signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // Obtain the authentication details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in with the credential

        final UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );

        // Get the user's information
        User? user = userCredential.user;

        setState(() {
          name = user?.displayName ?? "pas de nom";
          prenom = user?.displayName ?? "pas de prenom";
          phoneNumber = user?.phoneNumber ?? "pas de numero de telephone";
          email = user?.email ?? "pas d'Email";
          profilePictureUrl =
              user?.photoURL ?? "https://example.com/default_profile.jpg";
          password = "";
          // Reset password after successful login
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logged in as ${user?.displayName}')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with Google: $e')),
      );
    }
  }

  void saveProfile() {
    setState(() {
      name = nomController.text;
      prenom = prenomController.text;
      phoneNumber = callPhoneController.text;
      email = emailController.text;
      password = passwordController.text;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Profile updated!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MaliDiscover', style: TextStyle(color: Colors.lightGreen)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _googleSignIn.signOut();
              await FirebaseAuth.instance.signOut();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Logged out')));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture Section
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profilePictureUrl),
              ),
              SizedBox(height: 20),
              // Name Field
              TextField(
                controller: nomController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: prenomController,
                decoration: InputDecoration(
                  labelText: 'Prenom',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: callPhoneController,
                decoration: InputDecoration(
                  labelText: 'Telephone',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Email Field
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Champ de texte pour le mot de passe
              TextField(
                controller: passwordController,
                obscureText: true, // Masquer le texte pour le mot de passe
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text("$prenom $name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(email, style: TextStyle(color: Colors.grey[600])),

              // Save Button
              ElevatedButton(onPressed: saveProfile, child: Text('Enregistre'), ),
              SizedBox(height: 20),
              Text("Or", style: TextStyle(color: Colors.black)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signInWithGoogle,
                child: Text('Sign in with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
