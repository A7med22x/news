import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/shared/app_theme.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback onGoToHomeCliced;

  const HomeDrawer({super.key, required this.onGoToHomeCliced});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);

    return Container(
      width: screenSize.width * 0.7,
      color: AppTheme.black,
      child: Column(
        children: [
          Container(
            height: screenSize.height * 0.2,
            color: AppTheme.white,
            alignment: .center,
            child: Text(
              appLocalizations.newsApp,
              style: textTheme.titleLarge!.copyWith(color: AppTheme.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: InkWell(
              onTap: () {
                onGoToHomeCliced();
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/Home.svg'),
                  SizedBox(width: 12),
                  Text(
                    appLocalizations.goToHome,
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(indent: 16, endIndent: 16),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/theme.svg'),
                SizedBox(width: 12),
                Text(
                  appLocalizations.theme,
                  style: textTheme.titleLarge!.copyWith(color: AppTheme.white),
                ),
              ],
            ),
          ),
          Container(
            width: .infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.white),
            ),
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<ThemeMode>(
              value: settingsProvider.themeMode,
              items: [
                DropdownMenuItem(
                  value: .dark,
                  child: Text(
                    appLocalizations.dark,
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.white,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: .light,
                  child: Text(
                    appLocalizations.light,
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ],
              onChanged: (themeMode) {
                if (themeMode == null) return;
                settingsProvider.changeTheme(themeMode);
                Navigator.of(context).pop();
              },
              borderRadius: BorderRadius.circular(16),
              dropdownColor: AppTheme.black,
              isExpanded: true,
              underline: SizedBox(),
              iconEnabledColor: AppTheme.white,
              iconSize: 32,
            ),
          ),
          Divider(indent: 16, endIndent: 16),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/language.svg'),
                SizedBox(width: 12),
                Text(
                  appLocalizations.language,
                  style: textTheme.titleLarge!.copyWith(color: AppTheme.white),
                ),
              ],
            ),
          ),
          Container(
            width: .infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.white),
            ),
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton(
              value: settingsProvider.languageCode,
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text(
                    appLocalizations.english,
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.white,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'ar',
                  child: Text(
                    appLocalizations.arabic,
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ],
              onChanged: (languageCode) {
                if (languageCode == null) return;
                settingsProvider.changeLanguage(languageCode);
                Navigator.of(context).pop();
              },
              borderRadius: BorderRadius.circular(16),
              dropdownColor: AppTheme.black,
              isExpanded: true,
              underline: SizedBox(),
              iconEnabledColor: AppTheme.white,
              iconSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}
