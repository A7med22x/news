import 'package:flutter/material.dart';
import 'package:news/shared/app_theme.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/news/data/models/news.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomHomeBottomSheet extends StatelessWidget {
  News news;

  CustomHomeBottomSheet(this.news);

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.5,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: settingsProvider.isDark ? AppTheme.white : AppTheme.black,
      ),
      clipBehavior: .antiAlias,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                news.urlToImage ??
                    'https://thumb.ac-illust.com/8e/8e4070719d51bf84413a3c6019356f91_t.jpeg',
                height: .infinity,
                width: .infinity,
                fit: .fill,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            news.description ?? '',
            style: textTheme.labelMedium!.copyWith(
              color: settingsProvider.isDark ? AppTheme.black : AppTheme.white,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: .infinity,
            child: ElevatedButton(
              onPressed: () {
                launchInBrowser(news.url!);
              },
              child: Text(AppLocalizations.of(context)!.viewFullArticel),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> launchInBrowser(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
