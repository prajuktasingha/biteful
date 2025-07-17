import 'package:biteful/steps.dart';
import 'package:flutter/material.dart';

class RecipeDetails extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetails({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final steps = recipe['steps'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(recipe['name'] ?? 'Recipe')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe['image'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  recipe['image'],
                  height: 200,

                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),

            Text(
              recipe['name'] ?? 'Recipe',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(Icons.timer),
                    Text(recipe['prep_time'] ?? 'N/A'),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.list_alt),
                    Text('${recipe['Ingredients'].length} Steps'),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.star_border),
                    Text(recipe['Category'] ?? 'N/A'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              'Steps',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recipe['Steps'].length,
              itemBuilder: (context, index) {
                final String item = recipe['Steps'][index];
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(child: Text("${index + 1}")),
                        SizedBox(width: 8),
                        Expanded(child: Text(item)),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recipe['Ingredients'].length,
              itemBuilder: (context, index) {
                final String item = recipe['Ingredients'][index];
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(child: Text("${index + 1}")),
                        SizedBox(width: 8),
                        Expanded(child: Text(item)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
