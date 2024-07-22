import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/user_provider.dart';
import 'package:travel_admin/view/post/cardWidget.dart';

class Reportpost extends StatefulWidget {
  const Reportpost({super.key});

  @override
  State<Reportpost> createState() => _Reportpostte();
}

class _Reportpostte extends State<Reportpost> {
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
            "Post Reported",
            style: TextStyle(fontSize: 15, color: primaryColorsWhite),
          ),
        ),
        body: Consumer<UserProvider>(builder: (context, userProvider, child) {
          return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("report").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Container();
                }
                List allreport = snapshot.data!.docs;
                return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: allreport.length,
                    itemBuilder: (context, index) {
                      var data = allreport[index];
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
                            isreport: true,
                            message: data["message"],
                            reportid: data["id"],
                          ),
                        ],
                      );
                    });
              });
        }));
  }
}
