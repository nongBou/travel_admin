import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:travel_admin/components/messageHepler.dart';
import 'package:travel_admin/service/post_service.dart';

class PostProvider extends ChangeNotifier {
  PostService service = PostService();
  ImagePicker imagepicker = ImagePicker();
  final caption = TextEditingController();
  final topic = TextEditingController();
  final location = TextEditingController();
  String? category;
  String? categoryid;
  List<dynamic>? allcategory;
  String? status;
  List<dynamic>? PostAll;
  List<dynamic>? PostBeforSelectcate;
  List<dynamic>? PostBeforSearch;
  bool issearch = false;
  String selectedcate = "";
  List<dynamic> myPost = [];
  List<dynamic> mysave = [];
  File? image;

  PostProvider() {
    initialize();
  }
  void initialize() {
    getcategory();
    getallpost();
  }

  bool isadads = false;
  Future<void> addads() async {
    try {
      isadads = true;
      notifyListeners();
      final result = await service.addads(image: image!);
      if (result == 1) {
        image = null;
        isadads = false;
        notifyListeners();
      }
      isadads = false;
      notifyListeners();
    } catch (e) {}
  }

  Future<void> deleteads({required String id}) async {
    try {
      final result = await service.deleteads(id: id);
      if (result == 1) {}
    } catch (e) {}
  }

  Future<void> pickimage() async {
    try {
      final img = await imagepicker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        image = File(await img.path);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool isaddcate = false;
  Future<void> addcate({
    required String name,
  }) async {
    try {
      isaddcate = true;
      notifyListeners();
      final result = await service.addCategory(name: name, image: image!);
      if (result == true) {
        image = null;
        notifyListeners();

        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Deleted Post Success");
      } else {
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Deleted Post Fail");
      }
      isaddcate = false;
      notifyListeners();
    } catch (e) {}
  }

  bool isaddadmin = false;
  Future<void> addadmin({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isaddadmin = true;
      notifyListeners();
      final result = await service.addadmin(
        name: name,
        email: email,
        password: password,
      );
      if (result == true) {
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Add ADMIN Success");
      } else {
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Add ADMIN Fail");
      }
      isaddadmin = false;
      notifyListeners();
    } catch (e) {}
  }

  Future<void> deletePost(
      {required String postid,
      required bool isreport,
      String? reportid}) async {
    try {
      // print(PostAll);
      if (isreport == false) {
        int indexfrompostid =
            await PostAll!.indexWhere((p) => p["postid"] == postid);

        await PostAll!.removeAt(indexfrompostid);
      } else {
        deletereport(id: reportid!);
      }

      final result = await service.deletePost(postid: postid);
      if (result == 1) {
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Deleted Post Success");
      } else if (result == 2) {
        MessageHepler.showSnackBarMessage(
            isSuccess: false, message: "Deleted Post Fail");
      } else {
        MessageHepler.showSnackBarMessage(
            isSuccess: false,
            message: "Post is deleted before just keep delete report");
      }
    } catch (e) {}
  }

  Future<void> deletereport({required String id}) async {
    try {
      final result = await service.deletereport(id: id);
      if (result == true) {
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Deleted Post Success");
      } else {
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Deleted Post Fail");
      }
    } catch (e) {}
  }

  Future<void> deletecate({required String cateid}) async {
    try {
      final result = await service.deletecate(cateid: cateid);
      if (result == true) {
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Deleted Post Success");
      } else {
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Deleted Post Fail");
      }
    } catch (e) {}
  }

  Future<void> deleteaddmin({required String id}) async {
    try {
      final result = await service.deleteaddmin(id: id);
      if (result == true) {
        await navService.pushNamedAndRemoveUntil("/");
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Deleted Post Success");
      } else {
        MessageHepler.showSnackBarMessage(
            isSuccess: true, message: "Deleted Post Fail");
      }
    } catch (e) {}
  }

  Future<void> getallpost() async {
    try {
      final r = await service.getallpost();
      PostAll = r;
      notifyListeners();
    } catch (e) {}
  }

  // Future<void> pickimage() async {
  //   try {
  //     image = [];
  //     final List<XFile> pickimg = await imagepicker.pickMultiImage();
  //     if (pickimg != []) {
  //       for (var images in pickimg) {
  //         image.add(File(images.path));
  //       }
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> getcategory() async {
    try {
      status = "LoadingCate";
      var r = await service.getcategory();
      allcategory = await r;

      notifyListeners();
      status = "Success";
    } catch (e) {}
  }
}
