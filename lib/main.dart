import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import screens
import 'screens/home_screen.dart';
import 'screens/recording_screen.dart';
import 'screens/style_selection_screen.dart';
import 'screens/editor_screen.dart';
import 'screens/export_screen.dart';

// Import providers
import 'providers/audio_provider.dart';
import 'providers/ai_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioProvider()),
        ChangeNotifierProvider(create: (_) => AIProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sirbituu - AI Music Studio',  // CHANGED HERE
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/record': (context) => const RecordingScreen(),
        '/style': (context) => const StyleSelectionScreen(),
        '/edit': (context) => const EditorScreen(),
        '/export': (context) => const ExportScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
