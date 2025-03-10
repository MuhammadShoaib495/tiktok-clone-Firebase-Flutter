import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/views/screens/Add_Screen.dart';
import 'package:tiktok/views/screens/ProfileScreen.dart';
import 'package:tiktok/views/screens/Searchscreen.dart';
import 'package:tiktok/views/screens/VideoScreen.dart';

import 'controllers/auth_controller.dart';

//Pages

List pages = [
  VideoScreen(),
  const Searchscreen(),
  const AddScreen(),
  Text('Messages Screen'),
  ProfileScreen(uid: authController.user.uid),
];

// Colors

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// Firebase

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// Controller
var authController = AuthController.instance;
