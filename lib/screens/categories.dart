import 'package:flutter/material.dart';
import 'package:final_project_1/data/dummy_data.dart';
import 'package:final_project_1/models/meal.dart';
import 'package:final_project_1/screens/meals.dart';
import 'package:final_project_1/models/category.dart';
import 'package:final_project_1/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.onToggleFavorite});
   final void Function(Meal meal) onToggleFavorite;
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>  MealsScreen(
          onToggleFavorite: onToggleFavorite,
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); 
   }

  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context,category);
              },
            )
        ],
      
    );
  }
}
