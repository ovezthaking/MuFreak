import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/models/user.dart';

class SearchControllerMine extends GetxController{
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;


  searchUser(String typedUser) async {
    _searchedUsers.bindStream(
      firebaseFirestore.collection('users').where('name', isGreaterThanOrEqualTo : typedUser).snapshots().map((QuerySnapshot query){
        List<User> retVal = [];
        for(var elem in query.docs){
          retVal.add(User.fromSnap(elem));
        }
        return retVal;
      })
    );
  }
}