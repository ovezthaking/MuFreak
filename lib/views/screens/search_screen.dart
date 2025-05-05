import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/controllers/search_controller.dart';
import 'package:mufreak/models/user.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchControllerMine searchController = Get.put(SearchControllerMine());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: buttonColor,
            title: TextFormField( 
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onFieldSubmitted: (value) => searchController.searchUser(value),
            ),
          ),
          body: searchController.searchedUsers.isEmpty ? const Center(
            child: Text(
              'Search for users!',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ) : ListView.builder(
            itemCount: searchController.searchedUsers.length,
            itemBuilder: (context, index){
              User user = searchController.searchedUsers[index];
              return InkWell(
                onTap: () {
                  
                },
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(user.profilePhoto),),
                  title: Text(user.name, style: const TextStyle(fontSize: 18, color: Colors.white),),
                ),
              );
            } ,
          ),
        );
      }
    );
  }
}