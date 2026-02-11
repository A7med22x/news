import 'package:flutter/material.dart';
import 'package:news/app_theme.dart';
import 'package:news/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel category;
  int index;

  CategoryItem({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    return Container(
      width: .infinity,
      height: screenSize.height * 0.25,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: .antiAlias,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/${category.imageName}.png',
            width: .infinity,
            height: .infinity,
            fit: .fill,
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            top: screenSize.height * .05,
            end: index.isEven ? screenSize.width * .07 : null,
            start: index.isOdd ? screenSize.width * .07 : null,
            child: Text(
              category.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
