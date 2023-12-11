// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NoteService on ServiceNote, Store {
  Computed<List<String>>? _$notesComputed;

  @override
  List<String> get notes => (_$notesComputed ??=
          Computed<List<String>>(() => super.notes, name: 'ServiceNote.notes'))
      .value;

  late final _$ServiceNoteActionController =
      ActionController(name: 'ServiceNote', context: context);

  @override
  void addNote(String note) {
    final _$actionInfo =
        _$ServiceNoteActionController.startAction(name: 'ServiceNote.addNote');
    try {
      return super.addNote(note);
    } finally {
      _$ServiceNoteActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editNote(int index, String newNote) {
    final _$actionInfo =
        _$ServiceNoteActionController.startAction(name: 'ServiceNote.editNote');
    try {
      return super.editNote(index, newNote);
    } finally {
      _$ServiceNoteActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteNote(int index) {
    final _$actionInfo = _$ServiceNoteActionController.startAction(
        name: 'ServiceNote.deleteNote');
    try {
      return super.deleteNote(index);
    } finally {
      _$ServiceNoteActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notes: ${notes}
    ''';
  }
}
