// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:mytutor/model/config.dart';

// import '../model/user.dart';
// import '../model/course.dart';

// class CourseScreen extends StatefulWidget {
//   final User user;
//   const CourseScreen({
//     Key? key,
//     required this.user,
//   }) : super(key: key);

//   @override
//   State<CourseScreen> createState() => _CourseScreenState();
// }

// class _CourseScreenState extends State<CourseScreen> {
//   List<Course> courselist = <Course>[];
//   String titlecenter = "Loading...";
//   late double screenHeight, screenWidth, resWidth;
//   var numofpage, curpage = 1;
//   //int numofitem = 0;
//   var color;
//   int cart = 0;
//   TextEditingController searchController = TextEditingController();
//   String search = "";
//   String dropdownvalue = 'Beverage';

//   @override
//   void initState() {
//     super.initState();
//     _loadProducts(1, search);
//   }

//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;
//     if (screenWidth <= 600) {
//       resWidth = screenWidth;
//       //rowcount = 2;
//     } else {
//       resWidth = screenWidth * 0.75;
//       //rowcount = 3;
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Course'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               _loadSearchDialog();
//             },
//           ),
//         ],
//       ),
//       body: courselist.isEmpty
//           ? Center(
//               child: Text(titlecenter,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold)))
//           : Column(children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//                 child: Text(titlecenter,
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//               ),
//               Expanded(
//                   child: GridView.count(
//                       crossAxisCount: 2,
//                       childAspectRatio: (1 / 1),
//                       children: List.generate(courselist.length, (index) {
//                         return InkWell(
//                           splashColor: Colors.amber,
//                           onTap: () => {_loadCourseDetails(index)},
//                           child: Card(
//                               child: Column(
//                             children: [
//                               Flexible(
//                                 flex: 6,
//                                 child: CachedNetworkImage(
//                                   imageUrl: MyConfig.server +
//                                       "/Mobile_lab3\assets\courses/" +
//                                       courselist[index].subject_id.toString() +
//                                       '.jpg',
//                                   fit: BoxFit.cover,
//                                   width: resWidth,
//                                   placeholder: (context, url) =>
//                                       const LinearProgressIndicator(),
//                                   errorWidget: (context, url, error) =>
//                                       const Icon(Icons.error),
//                                 ),
//                               ),
//                               Text(
//                                 courselist[index].subject_name.toString(),
//                                 style: const TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                               Flexible(
//                                   flex: 4,
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             flex: 7,
//                                             child: Column(children: [
//                                               Text("RM " +
//                                                   double.parse(courselist[index]
//                                                           .subject_price
//                                                           .toString())
//                                                       .toStringAsFixed(2)),
//                                               Text(courselist[index]
//                                                       .subject_sessions
//                                                       .toString() +
//                                                   " classes"),
//                                             ]),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ))
//                             ],
//                           )),
//                         );
//                       }))),
//               SizedBox(
//                 height: 30,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: numofpage,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     if ((curpage - 1) == index) {
//                       color = Colors.red;
//                     } else {
//                       color = Colors.black;
//                     }
//                     return SizedBox(
//                       width: 40,
//                       child: TextButton(
//                           onPressed: () => {_loadProducts(index + 1, "")},
//                           child: Text(
//                             (index + 1).toString(),
//                             style: TextStyle(color: color),
//                           )),
//                     );
//                   },
//                 ),
//               ),
//             ]),
//     );
//   }

//   void _loadProducts(int pageno, String _search) {
//     curpage = pageno;
//     numofpage ?? 1;
//     http.post(
//         Uri.parse(MyConfig.server + "/slumshop/mobile/php/load_products.php"),
//         body: {
//           'pageno': pageno.toString(),
//           'search': _search,
//         }).timeout(
//       const Duration(seconds: 5),
//       onTimeout: () {
//         return http.Response(
//             'Error', 408); // Request Timeout response status code
//       },
//     ).then((response) {
//       print(response.body);
//       var jsondata = jsonDecode(response.body);

//       if (response.statusCode == 200 && jsondata['status'] == 'success') {
//         var extractdata = jsondata['data'];
//         numofpage = int.parse(jsondata['numofpage']);
//         if (extractdata['courses'] != null) {
//           courselist = <Course>[];
//           extractdata['courses'].forEach((v) {
//             courselist.add(Course.fromJson(v));
//           });
//           titlecenter = courselist.length.toString() + " Course Available";
//         } else {
//           titlecenter = "No Course Available";
//           courselist.clear();
//         }
//         setState(() {});
//       } else {
//         //do something
//         titlecenter = "No Course Available";
//         courselist.clear();
//         setState(() {});
//       }
//     });
//   }

//   _loadCourseDetails(int index) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(20.0))),
//             title: const Text(
//               "Course Details",
//               style: TextStyle(),
//             ),
//             content: SingleChildScrollView(
//                 child: Column(
//               children: [
//                 CachedNetworkImage(
//                   imageUrl: MyConfig.server +
//                       "/slumshop/assets/products/" +
//                       courselist[index].subject_id.toString() +
//                       '.jpg',
//                   fit: BoxFit.cover,
//                   width: resWidth,
//                   placeholder: (context, url) =>
//                       const LinearProgressIndicator(),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                 ),
//                 Text(
//                   courselist[index].subject_name.toString(),
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   Text("Course Description: \n" +
//                       courselist[index].subject_description.toString()),
//                   Text("Price: RM " +
//                       double.parse(courselist[index].subject_price.toString())
//                           .toStringAsFixed(2)),
//                   Text("Session Available: " +
//                       courselist[index].subject_sessions.toString() +
//                       " classes"),
//                   Text("Rating : " +
//                       courselist[index].subject_rating.toString()),
//                 ]),
//               ],
//             )),
//           );
//         });
//   }

//   void _loadSearchDialog() {
//     searchController.text = "";
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           // return object of type Dialog
//           return StatefulBuilder(
//             builder: (context, StateSetter setState) {
//               return AlertDialog(
//                 title: const Text(
//                   "Search ",
//                 ),
//                 content: SizedBox(
//                   //height: screenHeight / 4,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextField(
//                         controller: searchController,
//                         decoration: InputDecoration(
//                             labelText: 'Search',
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5.0))),
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: [
//                   ElevatedButton(
//                     onPressed: () {
//                       search = searchController.text;
//                       Navigator.of(context).pop();
//                       _loadProducts(1, search);
//                     },
//                     child: const Text("Search"),
//                   )
//                 ],
//               );
//             },
//           );
//         });
//   }
// }
