import 'package:biteful/recipe_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ValueNotifier<String> searchQuery = ValueNotifier<String>("");
final ValueNotifier<String> selectedCategory = ValueNotifier<String>("All");

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'logout') {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'logout',
                            child: Text('Logout'),
                          ),
                        ],
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('images/profile.jpg'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Hi, User!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "What do you want to cook today?",
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  searchQuery.value = value.toLowerCase();
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CategoryChip(label: 'All'),
                    CategoryChip(label: 'Veg'),
                    CategoryChip(label: 'Non-veg'),
                    CategoryChip(label: 'Desserts & Beverages'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Popular Recipe',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ValueListenableBuilder<String>(
                  valueListenable: selectedCategory,
                  builder: (context, categoryValue, _) {
                    return ValueListenableBuilder<String>(
                      valueListenable: searchQuery,
                      builder: (context, searchValue, _) {
                        return FirestoreListView(
                          query: FirebaseFirestore.instance.collection(
                            "recepies",
                          ),
                          itemBuilder: (context, doc) {
                            final Map<String, dynamic> recipe = doc.data();
                            if (searchValue.isNotEmpty &&
                                !recipe['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchValue)) {
                              return const SizedBox.shrink();
                            }
                            if (categoryValue != "All" &&
                                recipe['category'].toString().toLowerCase() !=
                                    categoryValue.toLowerCase()) {
                              return const SizedBox.shrink();
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeDetails(recipe: recipe),
                                  ),
                                );
                              },
                              child: RecipeCard(
                                title: recipe['name'],
                                time: recipe['prep_time'],
                                image: recipe['image'],
                                color: const Color.fromARGB(255, 235, 217, 235),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  const CategoryChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedCategory,
      builder: (context, selected, _) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(label),
            selected: selected == label,
            selectedColor: const Color.fromARGB(255, 232, 113, 113),
            backgroundColor: const Color.fromARGB(255, 236, 190, 190),
            labelStyle: TextStyle(
              color: selected == label ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            onSelected: (_) {
              selectedCategory.value = label;
            },
          ),
        );
      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String time;
  final String image;
  final Color color;

  const RecipeCard({
    Key? key,
    required this.title,
    required this.time,
    required this.image,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(image, fit: BoxFit.cover, height: 50, width: 50),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(time),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
