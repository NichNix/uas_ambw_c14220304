import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mood_journal/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rorbkwujunryugibgpmr.supabase.co/', 
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJvcmJrd3VqdW5yeXVnaWJncG1yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMTQyODEsImV4cCI6MjA2NjY5MDI4MX0.-INbyUIF-PpCeP6WPo1CJPDVIV9ADdvcGzHPfJGYaxM', 
  );

  runApp(const MoodJournalApp());
}

class MoodJournalApp extends StatelessWidget {
  const MoodJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Journal',
      debugShowCheckedModeBanner: false,
      home: SplashPage(), 
    );
  }
}
