import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/business/notes/note_service.dart';

class HomeController {
  NoteService? noteService;

  Future<void> initNoteService() async {
    final prefs = await SharedPreferences.getInstance();
    noteService = NoteService(prefs);
  }
}
