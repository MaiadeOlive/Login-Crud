import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas_test_flutter_dev/domain/business/auth/auth_service.dart';

part 'note_service.g.dart';

class NoteService = ServiceNote with _$NoteService;

abstract class ServiceNote with Store {
  final SharedPreferences _prefs;
  final String userEmail = AuthService().getUserEmail();

  ServiceNote(this._prefs);

  List<String> getNotes() {
    final notes = _prefs.getStringList('user_notes_$userEmail') ?? [];
    return notes;
  }

  @computed
  List<String> get notes => _prefs.getStringList('user_notes_$userEmail') ?? [];

  @action
  void addNote(String note) {
    List<String> notes = this.notes;
    notes.add(note);
    _prefs.setStringList('user_notes_$userEmail', notes);
  }

  @action
  void editNote(int index, String newNote) {
    List<String> notes = this.notes;
    notes[index] = newNote;
    _prefs.setStringList('user_notes_$userEmail', notes);
  }

  @action
  void deleteNote(int index) {
    List<String> notes = this.notes;
    notes.removeAt(index);
    _prefs.setStringList('user_notes_$userEmail', notes);
  }
}
