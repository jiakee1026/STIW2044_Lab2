// import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:mytutor/view/coursescreen.dart';
// import '../constants.dart';
// import '../model/course.dart';
// import '../model/user.dart';
// import '../model/tutor.dart';
// import 'package:intl/intl.dart';

// class TutorScreen extends StatefulWidget {
//   final User user;
//   const TutorScreen({Key? key, required this.user}) : super(key: key);
//   @override
//   State<TutorScreen> createState() => _TutorScreenState();
// }

// class _TutorScreenState extends State<TutorScreen> {
//   List<Tutor> tutorList = <Tutor>[];
//   String titlecenter = "Loading...";
//   late double screenHeight, screenWidth, resWidth;
//   var _tapPosition;
//   var numofpage, curpage = 1;
//   var color;

//   @override
//   void initState() {
//     super.initState();
//     _loadTutors(1);
//   }

// void _loadTutors(int pageno) {
//     curpage = pageno;
//     numofpage ?? 1;
//     http.post(
//         Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_tutor.php"),
//         body: {'pageno': pageno.toString()}).then((response) {
//       var jsondata = jsonDecode(response.body);

//       print(jsondata);
//       if (response.statusCode == 200 && jsondata['status'] == 'success') {
//         var extractdata = jsondata['data'];
//         numofpage = int.parse(jsondata['numofpage']);

//         if (extractdata['tutors'] != null) {
//           tutorList = <Tutor>[];
//           extractdata['tutors'].forEach((v) {
//             tutorList.add(Tutor.fromJson(v));
//           });
//         } else {
//           titlecenter = "No Tutor Available";
//         }
//         setState(() {});
//       }
//     });
//   }