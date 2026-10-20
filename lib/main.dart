import 'package:flutter/material.dart';
import 'package:projet_tuto/presentation/screens/home_screen.dart';


void main() {
  runApp(
    MaterialApp(            // ⚠️ plus de "const" : ThemeData n'est pas constant
      title: 'My app',
      theme: ThemeData(
        // Pour les widgets Icon "simples"
        iconTheme: const IconThemeData(
          color: Colors.green,
          size: 28,
        ),
        // Pour les IconButton
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Colors.green,          // icône quand le bouton est actif
            disabledForegroundColor: Colors.green,  // icône quand onPressed: null
            iconSize: 28,
          ),
        ),
      ),
      home: const SafeArea(child: HomeScreen()),
    ),
  );
}
