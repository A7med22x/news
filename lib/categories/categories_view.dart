import 'package:flutter/material.dart';
import 'package:news/categories/category_item.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/models/category_model.dart';

class CategoriesView extends StatelessWidget {
  void Function(CategoryModel) onCategorySelected;

  CategoriesView({required this.onCategorySelected});
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16, end: 16, top: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(appLocalizations.goodMorningHere, style: textTheme.titleLarge),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  onCategorySelected(CategoryModel.categories(context)[index]);
                },
                child: CategoryItem(
                  category: CategoryModel.categories(context)[index],
                  index: index,
                ),
              ),
              itemCount: CategoryModel.categories(context).length,
              separatorBuilder: (_, _) => SizedBox(height: 16),
            ),
          ),
        ],
      ),
    );
  }
}
