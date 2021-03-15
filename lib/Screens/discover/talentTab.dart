import 'package:flutter/material.dart';
import 'package:sout/Screens/discover/postCard.dart';
import 'package:sout/blocs/blocs.dart';
import 'package:sout/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TalentTab extends StatefulWidget {
  final String talentId;
  TalentTab(this.talentId);
  @override
  _TalentTabState createState() => _TalentTabState();
}

class _TalentTabState extends State<TalentTab> {
  PostModel postModel = new PostModel();
  List<PostModel> posts = [];

LikeModel likeModel = new LikeModel();
  // FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<LikeModel> likes = [];

  @override
  void initState() {
    super.initState();
    getPostsbyTalent(widget.talentId);
  }

  getPostsbyTalent(id) async {
    posts = await postModel.getPostsbyTalent(id);

    setState(() {});
  }

  getPostLikes(PostModel post) {
    
   likeModel.getPostLikes(post.id).then((value) => likes=value);
   print("hhhhhhhhhhh"+likes.length.toString());
    return likes.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          for (var post in posts)
            PostCard(
              ownerName: post.owner["name"],
              ownerImg: post.owner["picURL"],
              img: post.image,
              description: post.description,
              date: DateFormat('yyyy-MM-dd')
                  .format(post.date.toDate())
                  .toString(),
              audio: post.audio,
              likes: getPostLikes(post),
            ),
        ],
      ),
    );
  }
}
