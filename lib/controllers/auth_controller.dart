import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/models/user.dart' as model;
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/views/screens/HomeScreen.dart';
import 'package:tiktok/views/screens/login_screen.dart';


class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;


  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

   _setInitialScreen(User? user) {
    if(user == null) {
      Get.offAll(()=> LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      Get.snackbar('Profile Picture', 'You have successfully selected your profile');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage.ref().child('profilePics').child(
        firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // save out user to our ath and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profilePhoto: downloadUrl,
        );
        await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
      } else {
        Get.snackbar(
        'Error Creating Account',
        'Please enter All fields');
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }
  void loginUser(String email, String password) async {
    try {
      if(email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        print('log success');
      } else {
        Get.snackbar('Error logging in', 'Please enter all the Fields');
      }
    } catch(e){
      Get.snackbar('Error Loggin in', e.toString());
    }
  }
  signOut() async {
    await firebaseAuth.signOut();
  }
}
