import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';

class ProfileController extends GetxController{
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;

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
      bool isFollowing = true;


      for(var item in myVideos.docs){
        likes += (((item.data() as Map<String, dynamic>?)?['likes'] as List?)?.length ?? 0);
      }

      var followerDoc = await firebaseFirestore.collection('users')
        .doc(_uid.value).collection('followers').get();

      var followingDoc = await firebaseFirestore.collection('users')
        .doc(_uid.value).collection('following').get();

      followers = followerDoc.docs.length;
      following = followingDoc.docs.length;

      firebaseFirestore.collection('users').doc(_uid.value).collection('followers').doc(authController.user.uid).get().then((value) {
        if(value.exists){
          isFollowing = true;
        }
        else{
          isFollowing = false;
        }
      });

      _user.value = {
        'followers': followers.toString(),
        'following': following.toString(),
        'isFollowing': isFollowing,
        'likes': likes.toString(),
        'profilePhoto': profilePhoto,
        'name': name,
        'thumbnails': thumbnails,
      };
      
      update();
  }

  followUser() async {
    var doc = await firebaseFirestore
      .collection('users')
      .doc(_uid.value)
      .collection('followers')
      .doc(authController.user.uid)
      .get();

      if(!doc.exists){
        await firebaseFirestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({'followedAt': DateTime.now(),
          'username': authController.user.displayName ?? 'User',});
        await firebaseFirestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
        
        await _addFollowActivity(_uid.value);
        _user.value.update('followers', (value) => (int.parse(value) + 1).toString());
      }
      else{
        await firebaseFirestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
        await firebaseFirestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();

        _user.value.update('followers', (value) => (int.parse(value) - 1).toString());
      }

      _user.value.update('isFollowing', (value) => !value);
      update();
  }

  _addFollowActivity(String followedUserId) async {
    await firebaseFirestore.collection('activities').add({
      'type': 'follow',
      'fromUserId': authController.user.uid,
      'toUserId': followedUserId,
      'timestamp': DateTime.now(),
    });
  }
}