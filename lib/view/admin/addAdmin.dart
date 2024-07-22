import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/post_provider.dart';

class Addadmin extends StatefulWidget {
  const Addadmin({super.key});

  @override
  State<Addadmin> createState() => _AddadminState();
}

bool hide = true;

class _AddadminState extends State<Addadmin> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
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
          "Add ADMIN",
          style: TextStyle(fontSize: 15, color: primaryColorsWhite),
        ),
      ),
      body: Consumer<PostProvider>(builder: (context, cb, ch) {
        return SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Name",
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
                        border: InputBorder.none, hintText: "Name"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Email",
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
                    controller: email,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "addmin@gmail.com"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Password",
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
                    obscureText: hide,
                    controller: password,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () => setState(() {
                                  hide = !hide;
                                }),
                            icon: hide == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        border: InputBorder.none,
                        hintText: "********"),
                  ),
                ),
                // Container(
                //   height: 400,
                //   margin: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //       border: Border.all(color: Colors.grey),
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Center(
                //     child: IconButton(
                //         onPressed: () => cb.pickimage(),
                //         icon: cb.image == null
                //             ? Icon(
                //                 Icons.image,
                //                 size: 300,
                //               )
                //             : Image.file(
                //                 cb.image!,
                //                 fit: BoxFit.cover,
                //                 width: double.infinity,
                //               )),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          name.text != "" &&
                                  email.text != "" &&
                                  password.text != ""
                              ? cb
                                  .addadmin(
                                      name: name.text,
                                      email: email.text,
                                      password: password.text)
                                  .then((_) {
                                  name.text = "";
                                }).then((_) {
                                  name.clear();
                                  email.clear();
                                  password.clear();
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
