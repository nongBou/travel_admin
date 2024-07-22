import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/view/category/add_category.dart';
import 'package:travel_admin/view/category/cateCard.dart';

class Allcategory extends StatefulWidget {
  const Allcategory({super.key});

  @override
  State<Allcategory> createState() => _AllcategoryState();
}

class _AllcategoryState extends State<Allcategory> {
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
                  context, MaterialPageRoute(builder: (context) => AddCate())),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
        title: Text(
          "All categories",
          style: TextStyle(fontSize: 15, color: primaryColorsWhite),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("category").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return CateCard(
                    image: data["image"],
                    name: data["name"],
                    id: data["id"],
                  );
                }),
          );
        },
      ),
    );
  }
}
