import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class LikeModel {
  String userid;

  LikeModel({this.userid = ""});

  Map<String, dynamic> toJson() {
    return {'userid': userid};
  }

  factory LikeModel.fromDocument(DocumentSnapshot doc) {
    return LikeModel(
      userid: doc.data()["userid"],
    );
  }

  addLike(String postId, LikeModel like) {
    // ignore: deprecated_member_use
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance
            .collection('post')
            // ignore: deprecated_member_use
            .document(postId)
            .collection('like')
            .doc();

    ///////////////Test////////////////
    // like.userid = "j9ppSV3XMgP96xIYYrfFLfN4B4u2";

    documentReference.set(like.toJson());
  }

  Future<List<LikeModel>> getPostLikes(String postId) async {
    // ignore: deprecated_member_use
    CollectionReference ref =
        // ignore: deprecated_member_use
        Firestore.instance.collection('post').doc(postId).collection('like');
    // ignore: deprecated_member_use
    QuerySnapshot likesQuery = await ref.getDocuments();

    HashMap<String, LikeModel> likesHashMap =
        new HashMap<String, LikeModel>();

    // ignore: deprecated_member_use
    likesQuery.documents.forEach((document) {
      likesHashMap.putIfAbsent(document['id'], () {
        var likeModel = new LikeModel.fromDocument(document);
        return likeModel;
      });
    });
    print(likesHashMap.values.toList().length);

    return likesHashMap.values.toList();
  }
}
