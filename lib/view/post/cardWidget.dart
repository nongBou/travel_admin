import 'package:fitted_gridview/fitted_gridview.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:travel_admin/components/colors.dart';
import 'package:travel_admin/provider/post_provider.dart';

class CardWidgets extends StatefulWidget {
  final String reportid;
  final bool isreport;
  final String message;
  final String username;
  final String userid;
  final String address;
  final List image;
  final String caption;
  final bool iscomment;
  final String postid;
  final String profile;
  const CardWidgets({
    super.key,
    this.message = "",
    this.iscomment = false,
    required this.username,
    required this.postid,
    required this.address,
    required this.image,
    required this.caption,
    required this.userid,
    required this.profile,
    this.isreport = false,
    this.reportid = "",
  });

  @override
  State<CardWidgets> createState() => _CardWidgetsState();
}

class _CardWidgetsState extends State<CardWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.profile == ""
                      ? SvgPicture.asset(
                          "assets/icons/user.svg",
                          color: Colors.white,
                        )
                      : Image.network(
                          widget.profile,
                          color: Colors.white,
                        ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.username,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.address,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Spacer(),
              // Container(
              //   decoration: BoxDecoration(
              //       // border: Border.all(color: Colors.grey),
              //       // borderRadius: BorderRadius.circular(30),
              //       ),
              //   child: Builder(builder: (context) {
              //     return Consumer<UserProvider>(
              //         builder: (context, cubit, child) {
              //       Stream<dynamic> followingStream() {
              //         return FirebaseFirestore.instance
              //             .collection('user')
              //             .doc(cubit.user!.userid)
              //             .snapshots()
              //             .map((snapshot) {
              //           if (snapshot.exists) {
              //             return snapshot.data()!["following"];
              //           } else {
              //             return null;
              //           }
              //         });
              //       }

              //       return StreamBuilder<dynamic>(
              //           stream: followingStream(),
              //           builder: (context, snapshot) {
              //             if (snapshot.connectionState ==
              //                 ConnectionState.waiting) {
              //               return CircularProgressIndicator();
              //             }
              //             List data = snapshot.data;
              //             var check = data.any(
              //               (element) => element["id"] == widget.userid,
              //             );

              //             return check == false
              //                 ? TextButton(
              //                     style: TextButton.styleFrom(
              //                         padding: EdgeInsets.zero,
              //                         minimumSize: Size(50, 30)),
              //                     onPressed: () {},
              //                     child: Text("Follow"),
              //                   )
              //                 : TextButton(
              //                     style: TextButton.styleFrom(
              //                         padding: EdgeInsets.zero,
              //                         minimumSize: Size(50, 30)),
              //                     onPressed: () {},
              //                     child: Text(
              //                       "Followed",
              //                       style: TextStyle(color: primaryColor),
              //                     ),
              //                   );
              //           });
              //     });
              //   }),
              // ),
              SizedBox(
                width: 20,
              ),
              Consumer<PostProvider>(builder: (context, cubit, child) {
                return PopupMenuButton(
                  child: Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          onTap: () async {
                            cubit.deletePost(
                                postid: widget.postid,
                                reportid: widget.isreport == true
                                    ? widget.reportid
                                    : "",
                                isreport: widget.isreport);
                          },
                          child: Row(
                            children: [Icon(Icons.delete), Text("Delete Post")],
                          )),
                      if (widget.isreport)
                        PopupMenuItem(
                            onTap: () async {
                              cubit.deletereport(id: widget.reportid);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                                Text("Delete Report")
                              ],
                            )),
                    ];
                  },
                );
              })
            ],
          ),
        ),
        widget.isreport == true
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  "Reason: ${widget.message}",
                  style: TextStyle(color: Colors.red),
                ),
              )
            : Container(),
        Container(
          padding: EdgeInsets.all(2),
          height: 400,
          width: double.infinity,
          child: FittedGridView(
            maxItemDisplay: 4,
            itemCount: widget.image.length,
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.all(0.8),
                  child: Image.network(
                    widget.image[index],
                    height: 400,
                    fit: BoxFit.cover,
                  ));
            },
            remainingItemsOverlay: (remain) {
              return Container(
                color: Colors.grey.withOpacity(0.2),
                alignment: Alignment.center,
                child: Text(
                  "+$remain",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ReadMoreText(
            widget.caption,
            trimLines: 2,
            colorClickableText: primaryColor,
            trimMode: TrimMode.Line,
            style: TextStyle(fontSize: 15),
            trimCollapsedText: 'ອ່ານເພີ່ມ',
            trimExpandedText: ' ນ້ອຍລົງ',
            lessStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor),
            moreStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor),
          ),
        ),
        Container(
          width: double.infinity,
          height: 30,
          // color: Colors.white,
        )
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     children: [
        //       Spacer(),
        //       Consumer<PostProvider>(builder: (context, cubit, child) {
        //         var cubitUser = context.read<UserProvider>();
        //         return IconButton(
        //           onPressed: () {},
        //           icon: StreamBuilder<DocumentSnapshot>(
        //               stream: FirebaseFirestore.instance
        //                   .collection("post")
        //                   .doc(widget.postid)
        //                   .snapshots(),
        //               builder: (context, snapshot) {
        //                 var data = snapshot.data;
        //                 List fav = data != null ? data["likes"] : [];

        //                 return fav
        //                             .where((element) =>
        //                                 element["userid"] ==
        //                                 cubitUser.user!.userid)
        //                             .toString() ==
        //                         "()"
        //                     ? SvgPicture.asset(
        //                         "assets/icons/heart.svg",
        //                         height: 20,
        //                         color: primaryColor,
        //                       )
        //                     : SvgPicture.asset(
        //                         "assets/icons/heartActive.svg",
        //                         height: 20,
        //                         color: primaryColor,
        //                       );
        //               }),
        //         );
        //       }),
        //       SizedBox(width: 15),
        //       widget.iscomment == false
        //           ? GestureDetector(
        //               onTap: () {},
        //               child: SvgPicture.asset(
        //                 "assets/icons/comment.svg",
        //                 height: 20,
        //                 color: primaryColor,
        //               ),
        //             )
        //           : Container(),
        //       SizedBox(width: 15),
        //       IconButton(
        //         onPressed: () {
        //           Share.share("https://travelappfinalproject.com/rout");
        //         },
        //         icon: SvgPicture.asset(
        //           "assets/icons/share.svg",
        //           height: 20,
        //           color: primaryColor,
        //         ),
        //       ),
        //       SizedBox(width: 10),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
