// data/note_repository.dart
part of 'note_repository_impl.dart';

abstract class NoteRepository {
  ObservableList<String> getNotes();
  void addNote(String note);
  void editNote(int index, String newNote);
  void deleteNote(int index);
}
