import 'package:flutter/material.dart';
import 'package:penyakit_tanaman/daftar_penyakit_tanaman.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Diseases',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: daftarPenyakitTanaman()
    );
  }
}