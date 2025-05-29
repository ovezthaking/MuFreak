import 'package:cloud_firestore/cloud_firestore.dart';

class Playlist {
  String id;
  String name;
  String description;
  String creatorId;
  String creatorName;
  List<String> videoIds;
  List<String> collaborators;
  bool isPublic;
  DateTime createdAt;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.creatorId,
    required this.creatorName,
    required this.videoIds,
    required this.collaborators,
    required this.isPublic,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'creatorId': creatorId,
    'creatorName': creatorName,
    'videoIds': videoIds,
    'collaborators': collaborators,
    'isPublic': isPublic,
    'createdAt': createdAt,
  };

  static Playlist fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Playlist(
      id: snapshot['id'],
      name: snapshot['name'],
      description: snapshot['description'],
      creatorId: snapshot['creatorId'],
      creatorName: snapshot['creatorName'],
      videoIds: List<String>.from(snapshot['videoIds']),
      collaborators: List<String>.from(snapshot['collaborators']),
      isPublic: snapshot['isPublic'],
      createdAt: snapshot['createdAt'].toDate(),
    );
  }
}