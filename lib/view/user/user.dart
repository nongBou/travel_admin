import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/user_provider.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
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
            "Manage User",
            style: TextStyle(fontSize: 15, color: primaryColorsWhite),
          ),
        ),
        
        body: Consumer<UserProvider>(builder: (context, userProvider, child) {
          return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final data = userProvider.users;
                if (data[index]['role'] == "admin") {
                  return Container();
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data[index]['profile'] != ""
                            ? SizedBox(
                               height: 80,
                               width: 80,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                child: Image.network(
                                    data[index]['profile'],
                                    fit: BoxFit.cover,
                                  ),
                              ),
                            )
                            : 
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
                            Row(
                              children: [
                                Text(
                                  data[index]['firstname'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  data[index]['lastname'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                data[index]['email'],
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
                                data[index]['password'],
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        }));
  }
}
