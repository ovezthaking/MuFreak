import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mufreak/controllers/auth_controller.dart';
import 'package:mufreak/views/screens/activity_screen.dart';
import 'package:mufreak/views/screens/add_video_screen.dart';
import 'package:mufreak/views/screens/ai_screen.dart';
import 'package:mufreak/views/screens/profile_screen.dart';
import 'package:mufreak/views/screens/video_screen.dart';

List pages = [
  VideoScreen(),
  AiScreen(),
  const AddVideoScreen(),
  ActivityScreen(),
  ProfileScreen(uid: authController.user.uid),
];


// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.green[400];
const borderColor = Colors.grey;

// IMAGES
//const defaultProfileImage = '../../../assets/images/DefaultProfileImage.png';
class DefaultProfileImage {
  static const String png = 'assets/images/default_profile_image.png';    //default user avatar
}

class AiAssistantImage{
  static const String png = 'assets/images/ai_assist.png'; // ai assistant avatar
}

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseFirestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;