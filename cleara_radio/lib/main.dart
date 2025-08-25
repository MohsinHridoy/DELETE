import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/info_page.dart';
import 'services/radio_player_service.dart';

const String kDefaultStream = 'https://ice1.somafm.com/groovesalad-128-mp3';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RadioPlayerService(streamUrl: kDefaultStream)..initialize(),
      child: const RadioApp(),
    ),
  );
}

class RadioApp extends StatelessWidget {
  const RadioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cleara Radio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF111111)),
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const HomePage(),
        '/about': (_) => const InfoPage(title: 'About App', body: 'Cleara Radio demo built with Flutter.'),
        '/terms': (_) => const InfoPage(title: 'Terms', body: 'Terms placeholder.'),
        '/privacy': (_) => const InfoPage(title: 'Privacy', body: 'Privacy policy placeholder.'),
        '/disclaimer': (_) => const InfoPage(title: 'Disclaimer', body: 'Disclaimer placeholder.'),
        '/contact': (_) => const InfoPage(title: 'Contact', body: 'Contact us at hello@example.com'),
      },
    );
  }
}
