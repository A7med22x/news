import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';

class CategoryModel {
  String id;
  String name;
  String imageName;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageName,
  });

  static List<CategoryModel> categories(BuildContext context) => [
    CategoryModel(
      id: 'general',
      name: AppLocalizations.of(context)!.general,
      imageName: 'general',
    ),
    CategoryModel(
      id: 'business',
      name: AppLocalizations.of(context)!.busniess,
      imageName: 'busniess',
    ),
    CategoryModel(
      id: 'entertainment',
      name: AppLocalizations.of(context)!.entertainment,
      imageName: 'entertainment',
    ),
    CategoryModel(
      id: 'health',
      name: AppLocalizations.of(context)!.helth,
      imageName: 'helth',
    ),
    CategoryModel(
      id: 'science',
      name: AppLocalizations.of(context)!.science,
      imageName: 'science',
    ),
    CategoryModel(
      id: 'technology',
      name: AppLocalizations.of(context)!.technology,
      imageName: 'technology',
    ),
    CategoryModel(
      id: 'sports',
      name: AppLocalizations.of(context)!.sport,
      imageName: 'sport',
    ),
  ];
}
