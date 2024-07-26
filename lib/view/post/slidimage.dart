import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideimage extends StatefulWidget {
  final List images;
  const Slideimage({super.key, required this.images});

  @override
  State<Slideimage> createState() => _SlideimageState();
}

class _SlideimageState extends State<Slideimage> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "${index}/${widget.images.length.toString()}",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 1.5,
              width: double.infinity,
              child: PageView(
                  children: widget.images.map((e) {
                    return Center(
                      child: Image.network(
                        e,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (num) {
                    setState(() {
                      index = num + 1;
                    });
                  }),
            )
          ],
        ));
  }
}
