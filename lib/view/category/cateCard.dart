import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/post_provider.dart';

class CateCard extends StatefulWidget {
  final String image;
  final String name;
  final String id;
  const CateCard(
      {super.key, required this.image, required this.name, required this.id});

  @override
  State<CateCard> createState() => _CateCardState();
}

class _CateCardState extends State<CateCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 250,
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        widget.name,
                        style: TextStyle(color: primaryColor, fontSize: 20),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 10,
                      child: Consumer<PostProvider>(builder: (context, cb, ch) {
                        return PopupMenuButton(
                          child: Icon(Icons.more_vert),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  onTap: () {
                                    cb.deletecate(cateid: widget.id);
                                  },
                                  child: Row(children: [
                                    Icon(Icons.delete),
                                    Text("Delete")
                                  ]))
                            ];
                          },
                        );
                      }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
