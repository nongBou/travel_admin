import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_admin/components/colors.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  Future getuser() async {
    var a = await FirebaseFirestore.instance
        .collection("user")
        .where("role", isNotEqualTo: "admin")
        .get();

    return await a.docs;
  }

  Future getadmin() async {
    var a = await FirebaseFirestore.instance
        .collection("user")
        .where("role", isEqualTo: "admin")
        .get();

    return await a.docs;
  }

  Future getcate() async {
    var a = await FirebaseFirestore.instance.collection("category").get();

    return await a.docs;
  }

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
          "Report",
          style: TextStyle(fontSize: 15, color: primaryColorsWhite),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            FutureBuilder(
              future: getadmin(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return optioncard(
                    content: "Admins Report",
                    image: 'assets/images/menu5.jpeg',
                    title: "Admins",
                    data: snapshot.data);
              },
            ),
            FutureBuilder(
              future: getuser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return optioncard(
                    content: "Users Report",
                    image: 'assets/images/menu1.jpeg',
                    title: "Users",
                    data: snapshot.data);
              },
            ),
            FutureBuilder(
              future: getcate(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return optioncard(
                    content: "Categories Report",
                    image: 'assets/images/menu2.jpeg',
                    title: "Categories",
                    data: snapshot.data);
              },
            ),
          ],
        ),
      ),
    );
  }

  Container optioncard(
      {required String title,
      required String image,
      required List data,
      required String content}) {
    // print(data[0]["name"]);
    return Container(
      child: GestureDetector(
        child: Card(
          child: Row(
            children: [
              Container(width: 100, child: Image.asset(image)),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    textAlign: TextAlign.center,
                    title,
                    style: TextStyle(color: primaryColor, fontSize: 50),
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(content),
                  content: Container(
                    width: double.maxFinite,
                    height: 300, // Set a fixed height for the ListView
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Text(
                                  style: TextStyle(fontSize: 18),
                                  title == "Admins"
                                      ? "${index + 1}. ${data[index]["name"]}"
                                      : title == "Users"
                                          ? "${index + 1}. ${data[index]["firstname"]} ${data[index]["lastname"]}"
                                          : "${index + 1}. ${data[index]["name"]}");
                            },
                          ),
                        ),
                        Spacer(),
                        Container(
                            width: double.infinity,
                            child: Text(
                              "Total: ${data.length}",
                              textAlign: TextAlign.end,
                            ))
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"))
                  ],
                );
              });
        },
      ),
    );
  }
}
