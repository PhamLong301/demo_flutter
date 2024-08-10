import 'package:demo_flutter/demo_getx/binding/my_binding.dart';
import 'package:demo_flutter/demo_getx/binding/ui_getx_binding.dart';
import 'package:demo_flutter/demo_getx/presentations/ui_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetXUIDemo(),
      getPages: [
        GetPage(
          name: '/home',
          page: () => UIBindingScreen(),
          binding: MyBinding(),
        ),
        GetPage(
          name: '/main',
          page: () => GetXUIDemo(),
        ),
      ],
    );
  }
}

// class FirstScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Text(
//                 'Hang thu nhat',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Hang thu hai 1',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Hang thu hai 2',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Hang thu ba: ',
//                     style: TextStyle(
//                       fontSize: 18,
// //                   fontWeight: FontWeight.bold,
//                   color: Colors.grey,
//                     ),),
//                   Text(
//                     'bold 1',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.yellow,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 1,
//                 color: Colors.grey,
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Center(
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 20,
//                   left: 20,
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     color: Colors.green,
//                   ),
//                 ),
//                 Positioned(
//                   top: 60,
//                   left: 60,
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     color: Colors.red,
//                   ),
//                 ),
//                 Positioned(
//                   top: 100,
//                   left: 100,
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     color: Colors.yellow,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
