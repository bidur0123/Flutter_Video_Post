import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{

  String username;
  String comment;
  final datePub;
  List likes;
  List dislikes;
  String profilePic;
  String uid;
  String id;

  Comment({
    required this.username,
    required this.comment,
    required this.datePub,
    required this.likes,
    required this.dislikes,
    required this.profilePic,
    required this.uid,
    required this.id,
});


  Map<String, dynamic> toJson()=>{
    'username' : username,
    'comment' : comment,
    'datePub' : datePub,
    'likes' : likes,
    'dislikes' : dislikes,
    'profilePic' : profilePic,
    'uid' : uid,
    'id' : id,
  };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
        username : snapshot['username'],
        comment : snapshot['comment'],
        datePub : snapshot['datePub'],
        likes : snapshot['likes'],
        dislikes : snapshot['dislikes'],
        profilePic : snapshot['profilePic'],
        uid : snapshot['uid'],
        id : snapshot['id'],
    );
  }
}
