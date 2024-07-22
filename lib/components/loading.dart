import 'package:flutter/material.dart';


  Loading(context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              height: 50,
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 10),
                  Text("ກຳລັງໂຫຼດ...")
                ],
              ),
            ),
          );
        });
  }

  