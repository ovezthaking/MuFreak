import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/controllers/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({super.key, required this.id});

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index){
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage('profile photo'),
                        ),
                        title: Row(
                          children: [
                            Text(
                              'username ',
                              style: TextStyle(
                                fontSize: 20,
                                color: buttonColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'comment description',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'date',
                               style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text('10 likes', 
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                        onTap:() {},
                          child: Icon(Icons.favorite, size: 25, color: Colors.red,)),
                      );
                    },);
                  }
                ),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Write your comment...',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () => commentController.postComment(_commentController.text),
                  child: const Text(
                    'Send',
                    style: TextStyle(fontSize: 16, color: Colors.white,),
                    ),
                ),
              ),
            ],
          ),

        ),
      )
    );
  }
}