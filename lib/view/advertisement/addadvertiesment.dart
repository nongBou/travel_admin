import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/post_provider.dart';
import 'package:travel_admin/provider/user_provider.dart';

class AddADs extends StatefulWidget {
  const AddADs({super.key});

  @override
  State<AddADs> createState() => _AddADsState();
}

class _AddADsState extends State<AddADs> {
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
          "Add ADS",
          style: TextStyle(fontSize: 15, color: primaryColorsWhite),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<PostProvider>(builder: (context, cb, ch) {
          return Column(
            children: [
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
                  child: cb.isadads == false
                      ? ElevatedButton(
                          onPressed: () {
                            cb.image != null ? cb.addads() : null;
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
                          ))
                      : CircularProgressIndicator(),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
