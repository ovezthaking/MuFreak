import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({super.key, required this.id});

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _replyController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  // Zmienne do zarządzania stanem odpowiedzi
  final RxString _replyingTo = ''.obs;
  final RxString _replyingToUsername = ''.obs;

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Comments',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          // Lista komentarzy
          Expanded(
            child: Obx(
              () {
                return ListView.builder(
                  itemCount: commentController.comments.length,
                  itemBuilder: (context, index) {
                    final comment = commentController.comments[index];
                    return _buildCommentItem(comment);
                  },
                );
              }
            ),
          ),
          
          // Sekcja odpowiedzi (jeśli ktoś odpowiada)
          Obx(() {
            if (_replyingTo.value.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.all(10),
                color: Colors.grey[800],
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Replying to ${_replyingToUsername.value}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        _replyingTo.value = '';
                        _replyingToUsername.value = '';
                        _replyController.clear();
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          
          // Input komentarza/odpowiedzi
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return TextFormField(
                      controller: _replyingTo.value.isNotEmpty 
                          ? _replyController 
                          : _commentController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: _replyingTo.value.isNotEmpty 
                            ? 'Write your reply...' 
                            : 'Write your comment...',
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: buttonColor!),
                        ),
                      ),
                      maxLines: null,
                    );
                  }),
                ),
                const SizedBox(width: 10),
                Obx(() {
                  return TextButton(
                    onPressed: () {
                      if (_replyingTo.value.isNotEmpty) {
                        // Wyślij odpowiedź
                        commentController.replyToComment(
                          _replyingTo.value,
                          _replyController.text,
                        );
                        _replyController.clear();
                        _replyingTo.value = '';
                        _replyingToUsername.value = '';
                      } else {
                        // Wyślij komentarz
                        commentController.postComment(_commentController.text);
                        _commentController.clear();
                      }
                    },
                    child: Text(
                      _replyingTo.value.isNotEmpty ? 'Reply' : 'Send',
                      style: TextStyle(
                        fontSize: 16,
                        color: buttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(comment) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Główny komentarz
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(comment.profilePhoto),
              ),
              const SizedBox(width: 12),
              
              // Treść komentarza
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username i treść
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${comment.username} ',
                            style: TextStyle(
                              fontSize: 16,
                              color: buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: comment.comment,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    
                    // Metadata (czas, polubienia, odpowiedź)
                    Row(
                      children: [
                        Text(
                          tago.format(comment.datePublished.toDate()),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          '${comment.likes.length} likes',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            _replyingTo.value = comment.id;
                            _replyingToUsername.value = comment.username;
                          },
                          child: const Text(
                            'Reply',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Przycisk polubienia
              Column(
                children: [
                  InkWell(
                    onTap: () => commentController.likeComment(comment.id),
                    child: Icon(
                      Icons.favorite,
                      size: 20,
                      color: comment.likes.contains(authController.user.uid)
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Odpowiedzi
          StreamBuilder(
            stream: firebaseFirestore
                .collection('videos')
                .doc(id)
                .collection('comments')
                .doc(comment.id)
                .collection('replies')
                .orderBy('datePublished', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const SizedBox.shrink();
              }
              
              return Container(
                margin: const EdgeInsets.only(left: 50, top: 10),
                child: Column(
                  children: snapshot.data!.docs.map((replyDoc) {
                    final replyData = replyDoc.data() as Map<String, dynamic>;
                    // Przekaż parentCommentId do _buildReplyItem
                    return _buildReplyItem(replyData, comment.id);
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReplyItem(Map<String, dynamic> reply, String parentCommentId) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reply avatar
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(reply['profilePhoto'] ?? ''),
          ),
          const SizedBox(width: 10),
          
          // Reply content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${reply['username']} ',
                        style: TextStyle(
                          fontSize: 14,
                          color: buttonColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: reply['comment'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      tago.format((reply['datePublished']).toDate()),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      '${(reply['likes'] as List).length} likes',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Like reply button
          InkWell(
            onTap: () {
              commentController.likeReply(parentCommentId, reply['id']);
            },
            child: Icon(
              (reply['likes'] as List).contains(authController.user.uid)
                  ? Icons.favorite
                  : Icons.favorite_border,
              size: 16,
              color: (reply['likes'] as List).contains(authController.user.uid)
                  ? Colors.red
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}