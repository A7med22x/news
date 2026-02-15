import 'package:flutter/material.dart';
import 'package:news/models/sources_response/source.dart';

class TabItem extends StatelessWidget {
  Source source;
  bool isSelected;

  TabItem({required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      source.name!,
      style: isSelected ? textTheme.titleSmall : textTheme.labelMedium,
    );
  }
}
