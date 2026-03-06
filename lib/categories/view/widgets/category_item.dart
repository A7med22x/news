import 'package:flutter/material.dart';
import 'package:news/shared/app_theme.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/categories/data/models/category_model.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel category;
  int index;

  CategoryItem({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    Size screenSize = MediaQuery.sizeOf(context);

    return Container(
      width: .infinity,
      height: screenSize.height * 0.25,
      decoration: BoxDecoration(
        color: settingsProvider.isDark ? AppTheme.white : AppTheme.black,
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
            bottom: screenSize.height * .05,
            end: settingsProvider.isEnglish
                ? index.isEven
                      ? screenSize.width * .07
                      : null
                : index.isOdd
                ? screenSize.width * .07
                : null,
            start: settingsProvider.isEnglish
                ? index.isOdd
                      ? screenSize.width * .07
                      : null
                : index.isEven
                ? screenSize.width * .07
                : null,
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppTheme.grey,
                  ),
                  clipBehavior: .antiAlias,
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.viewAll,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: settingsProvider.isDark
                              ? AppTheme.black
                              : AppTheme.white,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: settingsProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
