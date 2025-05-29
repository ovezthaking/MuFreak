import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mufreak/constants.dart';

class NotificationController extends GetxController {
  final Rx<List<Map<String, dynamic>>> _notifications = Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get notifications => _notifications.value;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  getNotifications() {
    _notifications.bindStream(
      firebaseFirestore
          .collection('notifications')
          .where('toUserId', isEqualTo: authController.user.uid)
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        List<Map<String, dynamic>> retVal = [];
        for (var element in query.docs) {
          retVal.add(element.data() as Map<String, dynamic>);
        }
        return retVal;
      }),
    );
  }

  markAsRead(String notificationId) async {
    await firebaseFirestore
        .collection('notifications')
        .doc(notificationId)
        .update({'read': true});
  }

  int get unreadCount {
    return notifications.where((notif) => !notif['read']).length;
  }
}