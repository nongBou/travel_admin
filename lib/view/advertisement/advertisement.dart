import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/post_provider.dart';
import 'package:travel_admin/view/advertisement/addadvertiesment.dart';

class Advertisement extends StatefulWidget {
  const Advertisement({super.key});

  @override
  State<Advertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
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
          "Advertisement",
          style: TextStyle(fontSize: 15, color: primaryColorsWhite),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddADs();
                }));
              },
              icon: Icon(
                Icons.add,
                color: primaryColorsWhite,
              ))
        ],
      ),
      body: Consumer<PostProvider>(builder: (context, cb, ch) {
        return Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("advertiesment")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Image.network(
                                  data["image"],
                                  height: MediaQuery.sizeOf(context).width,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                IconButton(
                                    onPressed: () {
                                      cb.deleteads(id: data["id"]);
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            ),
                          ),
                        );
                      }));
            },
          ),
        );
      }),
    );
  }
}
