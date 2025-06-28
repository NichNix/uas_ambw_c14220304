import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/mood_entry.dart';
import '../services/auth_service.dart';
import 'add_mood_page.dart';
import 'login_page.dart';
import '../utils/shared_prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  final auth = AuthService();

  List<MoodEntry> entries = [];
  bool loading = true;

  Future<void> fetchMoodEntries() async {
    final user = auth.currentUser();
    if (user == null) return;

    final response = await supabase
        .from('mood_entries')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    setState(() {
      entries = (response as List).map((e) => MoodEntry.fromMap(e)).toList();
      loading = false;
    });
  }

  void _logout() async {
    await auth.signOut();
    await SharedPrefsHelper.clearPrefs();
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMoodEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood Journal"),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : entries.isEmpty
              ? const Center(child: Text("Belum ada mood dicatat."))
              : ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final mood = entries[index];
                    return ListTile(
                      leading: Text(
                        mood.emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                      title: Text(mood.note ?? "(tidak ada catatan)"),
                      subtitle: Text(mood.createdAt.toLocal().toString()),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddMoodPage()));
          fetchMoodEntries();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}