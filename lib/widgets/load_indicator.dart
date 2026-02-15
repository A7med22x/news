import 'package:flutter/material.dart';
import 'package:news/app_theme.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class LoadIndicator extends StatelessWidget {
  const LoadIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Provider.of<SettingsProvider>(context).isDark
            ? AppTheme.white
            : AppTheme.black,
      ),
    );
  }
}
