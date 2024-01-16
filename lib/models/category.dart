import 'package:flutter/material.dart';
//this acts just like a blueprint
class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  final String id;
  final String title;
  final Color color;
}
