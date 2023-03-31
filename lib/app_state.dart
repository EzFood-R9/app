import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
   
import 'firebase_options.dart';

import 'dart:async';     
import 'public_recipe.dart';
class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
    
  }
 

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

   StreamSubscription<QuerySnapshot>? _publicRecipeSubscription;
  List<PublicRecipe> _publicRecipes= [];
  List<PublicRecipe> get publicRecipes => _publicRecipes;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);
    
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _publicRecipeSubscription = FirebaseFirestore.instance
            .collection('recipes')
            .orderBy('materials', descending: true)
            .snapshots()
            .listen((snapshot) {
          _publicRecipes = [];
          for (final document in snapshot.docs) {
           _publicRecipes.add(
              PublicRecipe(
                name: document.data()['name'] as String,
                materials: document.data()['materials'] as String,
                 instructions: document.data()['instructions'] as String,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _publicRecipes = [];
        _publicRecipeSubscription?.cancel();
      }
      notifyListeners();
    });
  }
  Future<DocumentReference> addRecipe(String name, String materials,String instructions) {
      if (!_loggedIn) {
        throw Exception('Must be logged in');
      }

      return FirebaseFirestore.instance
          .collection('recipes')
          .add(<String, dynamic>{
        'name': name,
        'instructions': instructions,
        'materials': materials,
        'userId': FirebaseAuth.instance.currentUser!.uid,
      });
    }
}
