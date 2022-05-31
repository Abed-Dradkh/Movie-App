// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/helper/builders.dart';
// import 'package:flutter_application_2/helper/functions.dart';
// import 'package:flutter_application_2/helper/variables.dart';

// class NewMovie extends StatelessWidget {
//   NewMovie({Key? key}) : super(key: key);
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.save_rounded),
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             settingUpMovie(controllers);
//           }
//         },
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.width * 0.075,
//             vertical: MediaQuery.of(context).size.height * 0.035,
//           ),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Column(
//                     children: List.generate(
//                       textNames.length,
//                       ((index) {
//                         return buildInput(
//                             context, controllers[index], textNames[index]);
//                       }),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
