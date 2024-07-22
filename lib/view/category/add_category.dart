import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/post_provider.dart';

class AddCate extends StatefulWidget {
  const AddCate({super.key});

  @override
  State<AddCate> createState() => _AddCateState();
}

class _AddCateState extends State<AddCate> {
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
          "Add category",
          style: TextStyle(fontSize: 15, color: primaryColorsWhite),
        ),
      ),
      body: Consumer<PostProvider>(builder: (context, cb, ch) {
        final name = TextEditingController();
        return SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Category name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Category name"),
                  ),
                ),
                Container(
                  height: 400,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: IconButton(
                        onPressed: () => cb.pickimage(),
                        icon: cb.image == null
                            ? Icon(
                                Icons.image,
                                size: 300,
                              )
                            : Image.file(
                                cb.image!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          name.text != ""
                              ? cb.addcate(name: name.text).then((_) {
                                  name.text = "";
                                })
                              : null;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            textAlign: TextAlign.center,
                            "Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
