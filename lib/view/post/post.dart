import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/post_provider.dart';
import 'package:travel_admin/view/post/cardWidget.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: primaryColorsWhite,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Post List",
            style: TextStyle(fontSize: 15, color: primaryColorsWhite),
          ),
        ),
        body: Consumer<PostProvider>(builder: (context, postProvider, child) {
          postProvider.getallpost();
          return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: postProvider.PostAll != null
                  ? postProvider.PostAll!.length
                  : 0,
              itemBuilder: (context, index) {
                var data = postProvider.PostAll![index];
                return Column(
                  children: [
                    Divider(
                      color: Colors.black,
                    ),
                    CardWidgets(
                      profile: data["profile"] ?? "",
                      postid: data["postid"],
                      username: data["username"],
                      address: data["location"],
                      image: data["imageURL"],
                      caption: data["caption"],
                      userid: data["userid"],
                    ),
                  ],
                );
              });
        }));
  }
}
