// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class RecipeSteps extends StatelessWidget {
//   final String documentId; // Firestore document ID of recipe

//   const RecipeSteps({Key? key, required this.documentId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final recipeRef = FirebaseFirestore.instance
//         .collection('recepies')
//         .doc(documentId);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Recipe Steps')),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: recipeRef.get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return const Center(child: Text('Recipe not found.'));
//           }

//           final recipeData = snapshot.data!.data() as Map<String, dynamic>;
//           final String imageUrl =
//               recipeData['image'] ?? 'https://via.placeholder.com/300';
//           final List<dynamic> steps = recipeData['steps'] ?? [];

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Recipe Image
//                 Image.network(
//                   imageUrl,
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),

//                 const SizedBox(height: 16),

//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     'Steps',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),

//                 const SizedBox(height: 8),

//                 ListView.builder(
//                   itemCount: steps.length,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   itemBuilder: (context, index) {
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 4),
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           radius: 14,
//                           child: Text('${index + 1}'),
//                         ),
//                         title: Text(steps[index].toString()),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
