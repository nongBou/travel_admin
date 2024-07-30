import 'package:flutter/material.dart';
import 'package:travel_admin/view/admin/admin.dart';
import 'package:travel_admin/view/advertisement/advertisement.dart';
import 'package:travel_admin/view/auth/login.dart';
import 'package:travel_admin/view/category/category.dart';
import 'package:travel_admin/view/dashboard/dashboard.dart';
import 'package:travel_admin/view/post/post.dart';
import 'package:travel_admin/view/report/report.dart';
import 'package:travel_admin/view/reportpost/reportpost.dart';
import 'package:travel_admin/view/user/user.dart';

class RouteAPI {
  static const home = "/";
  static const login = "/login";
  static const register = "/register";
  static const bottom = "/bottom";
  static const manage_user = "/user";
  static const post = "/post";
  static const dashboard = "/dashboard";
  static const splashscreen = "/splashscreen";
  static const cate = "/cate";
  static const admin = "/admin";
  static const reportpost = "/report_post";
  static const report = "/report";
  static const advertiesment = "/advertiesment";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );

      case login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case post:
        return MaterialPageRoute(
          builder: (context) => const PostView(),
        );
      case manage_user:
        return MaterialPageRoute(
          builder: (context) => const UserView(),
        );

      case dashboard:
        return MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        );
      case cate:
        return MaterialPageRoute(builder: (context) => const Allcategory());
      case admin:
        return MaterialPageRoute(builder: (context) => const Admin());
      case reportpost:
        return MaterialPageRoute(builder: (context) => const Reportpost());
      case report:
        return MaterialPageRoute(builder: (context) => const Report());
      case advertiesment:
        return MaterialPageRoute(builder: (context) => const Advertisement());
      default:
        throw const FormatException("Route not found!");
    }
  }
}
