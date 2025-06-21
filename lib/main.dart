import 'package:flutter/material.dart';
import 'package:app01/pages/loading_page.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyDzCHg3SlMDM_kmDQGQZYVHaS44rDgoV7Q',
      appId: '1:166994087785:android:c309997c1d51595740f7f8',
      messagingSenderId: '',
      projectId: 'malidicover',
    ),
    
  );
  runApp(MyApp());
}


 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // cet widget est la racine de application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent,  ),
        useMaterial3: true,
      ),
      home: const MyloadingPage(title: 'loading'),
    );
  }
}

