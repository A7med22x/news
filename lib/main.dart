import 'package:flutter/material.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(ChangeNotifierProvider (create: (_) => SettingsProvider()..loadLanguage(), child:  NewsApp()));
}

class NewsApp extends StatelessWidget{
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
    routes: {},
    initialRoute: ,
    );
  }
  
}