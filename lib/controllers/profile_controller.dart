import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';

class ProfileController extends GetxController{
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async{
    List<String> thumbnails = [];
    QuerySnapshot myVideos = await firebaseFirestore
      .collection('videos')
      .where('uid', isEqualTo: _uid.value)
      .get();

      for(int i=0; i<myVideos.docs.length; i++){
        thumbnails.add((myVideos.docs[i].data()! as dynamic)['thumbnail']);
      }

      DocumentSnapshot userDoc = await firebaseFirestore.collection('users').doc(_uid.value).get();
      final userData = userDoc.data()! as dynamic;
      String name = userData['name'];
      String profilePhoto = userData['profilePhoto'];
      int likes = 0;
      int followers = 0;
      int following = 0;


      for(var item in myVideos.docs){
        likes+= (item.data()['likes'] as List).length;
      }
  }
}