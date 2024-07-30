import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/user_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuild('Dashboard Admin', () {}, () {}),
      body: gradViewBuild(),
    );
  }

  final List _listImg = [
    {
      'img': 'assets/images/menu5.jpeg',
      'name': 'Manage User',
      'press': () => navService.pushNamed('/user'),
    },
    {
      'img': 'assets/images/menu3.jpeg',
      'name': 'Report Post',
      'press': () => navService.pushNamed('/report_post'),
    },
    {
      'img': 'assets/images/menu6.jpeg',
      'name': 'Manage Post',
      'press': () => navService.pushNamed('/post'),
    },
    {
      'img': 'assets/images/menu2.jpeg',
      'name': 'Manage Categories',
      'press': () => navService.pushNamed('/cate'),
    },
    {
      'img': 'assets/images/menu1.jpeg',
      'name': 'Manage Admin',
      'press': () => navService.pushNamed('/admin'),
    },
    {
      'img': 'assets/images/menu4.jpeg',
      'name': 'Report',
      'press': () => navService.pushNamed('/report'),
    },
    {
      'img': 'assets/images/ads.png',
      'name': 'Advertisement',
      'press': () => navService.pushNamed('/advertiesment'),
    },
  ];

  Widget gradViewBuild() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemCount: _listImg.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: _listImg[index]['press'],
              child: Card(
                elevation: 5,
                color: primaryColorsWhite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _listImg[index]['press'],
                      child: SizedBox(
                        height: 100,
                        child: Image.asset(
                          _listImg[index]['img'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      _listImg[index]['name'],
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  AppBar appBarBuild(txt, VoidCallback user, exit) {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      leading: InkWell(
        onTap: user,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: primaryColorsWhite,
            backgroundImage: AssetImage('assets/images/user.png'),
            // backgroundImage: NetworkImage(controller.adminData['']),
          ),
        ),
      ),
      title: Text(
        txt,
        style: TextStyle(
          fontSize: 18,
          color: primaryColorsWhite,
        ),
      ),
      actions: [
        SizedBox(width: 10),
        InkWell(
          onTap: exit,
          child: Consumer<UserProvider>(builder: (context, cb, ch) {
            return IconButton(
              onPressed: () {
                cb.logout();
              },
              icon: Icon(
                CupertinoIcons.arrow_right_square_fill,
                color: primaryColorsWhite,
              ),
            );
          }),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
