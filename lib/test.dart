// import 'package:flutter/material.dart';
// import 'package:flutter_maduas/Database_Instance.dart';
// import 'package:flutter_maduas/product_model.dart';
// import './Controller.dart';
// import 'package:flutter_maduas/InputCard/view.dart';
// import 'package:flutter_maduas/Home/View.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends HomeController {
//   DatabaseInstance databaseInstance = DatabaseInstance();

//   Future _refresh() async {
//     setState(() {});
//   }

//   @override
//   void initState() {
//     databaseInstance.database();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bukuku'),
//         titleTextStyle: TextStyle(
//           color: Colors.black,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//         backgroundColor: Colors.pink,
//       ),
//       body: FutureBuilder<List<ProductModel>>(
//         future: databaseInstance.all(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             if (snapshot.data!.length == 0) {
//               return Center(
//                 child: Text('Masukkan Catatan'),
//               );
//             }
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(snapshot.data![index].Judul ?? ''),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
