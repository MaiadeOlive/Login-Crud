import 'package:mobx/mobx.dart';

part 'note.g.dart';

class Note = Notes with _$Note;

abstract class Notes with Store {
  @observable
  ObservableList<String> notes = ObservableList<String>();

  @action
  void addNote(String note) {
    notes.add(note);
  }

  @action
  void editNote(int index, String newNote) {
    notes[index] = newNote;
  }

  @action
  void deleteNote(int index) {
    notes.removeAt(index);
  }
}
