import 'package:flutter/material.dart';
import 'package:frontend/features/home/views/roadmap_page.dart';
import 'package:frontend/shared/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Growthway Hack',
      theme: AppTheme.lightTheme,
      home: const RoadmapPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
