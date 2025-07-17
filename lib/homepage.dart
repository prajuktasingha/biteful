import 'dart:math';

import 'package:biteful/recipe_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 255, 253, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Hi, User!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "What do you want to cook today?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16),

              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryChip(label: 'All', selected: true),
                    CategoryChip(label: 'Meat'),
                    CategoryChip(label: 'Noodles'),
                    CategoryChip(label: 'Vegetables'),
                  ],
                ),
              ),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Recipe',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Expanded(
                child: FirestoreListView(
                  query: FirebaseFirestore.instance.collection("recepies"),
                  itemBuilder: (context, doc) {
                    final Map<String, dynamic> recipe = doc.data();

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetails(recipe: recipe),
                          ),
                        );
                      },
                      child: RecipeCard(
                        title: recipe['name'],
                        time: recipe['prep_time'],
                        image: recipe['image'],
                        color: [
                          Colors.yellow.shade100,
                          Colors.orange.shade100,
                          Colors.blue.shade100,
                          Colors.green.shade100,
                        ][Random().nextInt(4)],
                      ),
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
  final bool selected;

  const CategoryChip({Key? key, required this.label, this.selected = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: Colors.green,
        backgroundColor: Colors.green.shade100,
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        onSelected: (_) {},
      ),
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
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$time'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
