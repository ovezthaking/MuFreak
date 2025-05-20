import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/models/video.dart';


class VideoController extends GetxController{
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;


  @override
  void onInit(){
    super.onInit();
    _videoList.bindStream(firebaseFirestore.collection('videos').orderBy('id', descending: true).snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];
      for(var element in query.docs){
        retVal.add(Video.fromSnap(element),);
      }
      return retVal;
    }));
  }
  
  likeVideo(String id) async {
    DocumentSnapshot doc = await firebaseFirestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    if((doc.data()! as dynamic)['likes'].contains(uid)){
      await firebaseFirestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    }
    else{
      await firebaseFirestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}