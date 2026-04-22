import 'package:flutter/material.dart';
import 'package:news/shared/app_theme.dart';
import 'package:news/news/data/models/news.dart';
import 'package:news/shared/providers/settings_provider.dart';
import 'package:news/shared/widgets/custom_home_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  final News news;

  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        showBotomSheet(news, context);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: settingsProvider.isDark ? AppTheme.white : AppTheme.black,
          ),
        ),
        clipBehavior: .antiAlias,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                news.urlToImage ??
                    'https://thumb.ac-illust.com/8e/8e4070719d51bf84413a3c6019356f91_t.jpeg',
                height: MediaQuery.sizeOf(context).height * 0.25,
                width: .infinity,
                fit: .fill,
              ),
            ),
            SizedBox(height: 10),
            Text(news.title ?? '', style: textTheme.titleSmall),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text('By : ${news.source?.name}', style: textTheme.labelSmall),
                Text(
                  timeago.format(news.publishedAt!),
                  style: textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  

  void showBotomSheet(News news, BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => CustomHomeBottomSheet(news),
    );
  }
}
