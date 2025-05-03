import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mufreak/models/user.dart' as model;
import 'package:mufreak/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mufreak/views/screens/auth/login_screen.dart';
import 'package:mufreak/views/screens/home_screen.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;


  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if(user==null){
      Get.offAll(() => LoginScreen());
    }
    else{
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      Get.snackbar('Profile Picture', 'Image selected successfully');
    }
    _pickedImage = Rx<File> (File(pickedImage!.path));
  }
  
  //upload to fbase storager
  Future<String> _uploadToStorage(File image) async {
  try {
    String uid = firebaseAuth.currentUser?.uid ?? 'default_uid';
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(uid);
    
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;

    // Check for errors during upload
    if (snap.state != TaskState.success) {
      throw Exception('Error uploading image: Upload failed with state ${snap.state}');
    }

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    //print('Error uploading image: ${e.toString()}');
    Get.snackbar('Error uploading image', e.toString());
    rethrow;  // Rethrow to propagate the error
  }
}

  //regster user
  void registerUser(String username, String email, String password, File? image) async{
    try{
      if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null){
          //save user data to firebase
          UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, 
            password: password);
          String downloadUrl = await _uploadToStorage(image);

          model.User user = model.User(
            name: username, 
            email: email, 
            uid: cred.user!.uid , 
            profilePhoto: downloadUrl,
          );
          
          await firebaseFirestore.collection('users').doc(cred.user!.uid).set(user.toJson());
      }
      else{
        Get.snackbar('Error creating account', 'Please fill all the fields');
      }
    } 
    catch (e){
      Get.snackbar('Error in creating account into firebase', e.toString());
    }
  }

  //login
  void loginUser(String email, String password) async{
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        //print('login successssss');
      }
      else{
        Get.snackbar('Error login', "Please fill all the fields");
      }
    }
    catch (e){
      Get.snackbar('Error in login', e.toString());
    }
  }
}
