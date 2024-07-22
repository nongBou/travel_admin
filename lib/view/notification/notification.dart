import 'package:flutter/material.dart';
import 'package:travel_admin/components/colors.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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
            "Notification",
            style: TextStyle(fontSize: 15, color: primaryColorsWhite),
          ),
        ),
        
    );
  }
}