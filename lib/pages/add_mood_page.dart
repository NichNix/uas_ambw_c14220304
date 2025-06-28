import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

class AddMoodPage extends StatefulWidget {
  const AddMoodPage({super.key});

  @override
  State<AddMoodPage> createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  final supabase = Supabase.instance.client;
  final auth = AuthService();

  final noteController = TextEditingController();
  String? selectedEmoji;

  final emojis = ['😊', '😔', '😡', '😍', '😐', '😭'];

  void _submit() async {
    if (selectedEmoji == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Pilih emoji dulu")));
      return;
    }

    final user = auth.currentUser();
    if (user == null) return;

    await supabase.from('mood_entries').insert({
      'user_id': user.id,
      'emoji': selectedEmoji,
      'note': noteController.text.trim(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Mood")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Pilih mood hari ini", style: TextStyle(fontSize: 18)),
            Wrap(
              spacing: 12,
              children: emojis.map((e) {
                return GestureDetector(
                  onTap: () => setState(() => selectedEmoji = e),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedEmoji == e ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(e, style: const TextStyle(fontSize: 28)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: "Catatan (opsional)",
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
