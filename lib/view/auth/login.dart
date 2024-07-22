import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/loading.dart';
import 'package:travel_admin/provider/user_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final email = TextEditingController();
  final password = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: globalKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 120),
                  Image.asset("assets/images/logo.png"),
                  SizedBox(height: 10),
                  Divider(
                    indent: 50,
                    endIndent: 50,
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ອີເມວຫ້າມວ່າງ!";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "example@gmail.com",
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ລະຫັດຜ່ານຫ້າມວ່າງ!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Password..",
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (globalKey.currentState!.validate()) {
                        Loading(context);
                        userProvider.login(
                          email: email.text,
                          password: password.text,
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xff62BFC5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Go to your new experience")
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
