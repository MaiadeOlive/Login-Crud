// data/note_repository_impl.dart
import 'package:mobx/mobx.dart';

import '../../domain/business/notes/note.dart';

part 'note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final Note _note = Note();

  @override
  ObservableList<String> getNotes() => _note.notes;

  @override
  void addNote(String note) => _note.addNote(note);

  @override
  void editNote(int index, String newNote) => _note.editNote(index, newNote);

  @override
  void deleteNote(int index) => _note.deleteNote(index);
}
