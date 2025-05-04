import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

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
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index){
                        final comment = commentController.comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(comment.profilePhoto),
                        ),
                        title: Row(
                          children: [
                            Text(
                              comment.username,
                              style: TextStyle(
                                fontSize: 20,
                                color: buttonColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              ' ${comment.comment}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              tago.format(comment.datePublished.toDate(),),
                               style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text('${comment.likes.length} likes', 
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                        onTap:() {},
                          child: const Icon(Icons.favorite, size: 25, color: Colors.red,)),
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