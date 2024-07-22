import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/post_provider.dart';
import 'package:travel_admin/view/admin/addAdmin.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
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
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Addadmin())),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
        title: Text(
          "ADMIN",
          style: TextStyle(fontSize: 15, color: primaryColorsWhite),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("user").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List<Map<String, dynamic>> alladmin = snapshot.data!.docs
              .where((e) => e["role"] == "admin")
              .map((e) => e.data())
              .toList();
          print(alladmin);
          return Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: alladmin.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // data[index]['profile'] != ""
                        //     ? SizedBox(
                        //        height: 80,
                        //        width: 80,
                        //       child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(80),
                        //         child: Image.network(
                        //             data[index]['profile'],
                        //             fit: BoxFit.cover,
                        //           ),
                        //       ),
                        //     )
                        //     :
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.asset(
                              "assets/images/user.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              alladmin[index]['name'],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                alladmin[index]['email'],
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                alladmin[index]['password'],
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          child: Center(
                            child: Consumer<PostProvider>(
                                builder: (context, cb, ch) {
                              return FirebaseAuth.instance.currentUser!.uid ==
                                      alladmin[index]["id"]
                                  ? PopupMenuButton(
                                      child: Icon(Icons.more_vert),
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                              onTap: () {
                                                cb.deleteaddmin(
                                                    id: alladmin[index]["id"]);
                                              },
                                              child: Row(children: [
                                                Icon(Icons.delete),
                                                Text("Delete")
                                              ]))
                                        ];
                                      },
                                    )
                                  : Container();
                            }),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
