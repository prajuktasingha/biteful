import 'package:flutter/material.dart';

class RecipeDetails extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetails({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ingredients = recipe['Ingredients'] as List<dynamic>? ?? [];
    final steps = recipe['Steps'] as List<dynamic>? ?? [];

    final ingredientColor = const Color(0xFFFFF3E0);
    final stepColor = const Color(0xFFFFF3E0);

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
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 199, 70, 60),
              ),
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
                    Text('${steps.length} Steps'),
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

            const SizedBox(height: 24),

            const Text(
              'Ingredients',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 126, 104, 163),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final String item = ingredients[index];
                return Card(
                  color: ingredientColor,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.orange,
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            const Text(
              'Steps',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 126, 104, 163),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final String step = steps[index];
                return Card(
                  color: stepColor,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.orange,
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            step,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
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
