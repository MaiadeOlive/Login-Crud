import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../domain/business/auth/auth_service.dart';
import '../../domain/business/notes/note_service.dart';
import '../../utils/theme.dart';
import '../components/toast.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Future<NoteService> noteService;

  @override
  void initState() {
    super.initState();
    noteService = _initNoteService();
  }

  Future<NoteService> _initNoteService() async {
    final prefs = await SharedPreferences.getInstance();
    return NoteService(prefs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _buildAppBar(context),
      ),
      body: Observer(
        builder: (_) {
          return FutureBuilder<NoteService>(
            future: noteService,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final noteService = snapshot.data;
                if (noteService != null) {
                  return ListView.builder(
                    itemCount: noteService.getNotes().length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: _buildNoteCard(context, index, noteService),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          context.read<AuthService>().logout();
          Navigator.pushNamed(context, '/login');
        },
      ),
      title: const Text('Target Sistemas Test'),
    );
  }

  Widget _buildNoteCard(
      BuildContext context, int index, NoteService noteService) {
    final notes = noteService.getNotes();

    if (index >= notes.length) {
      return const SizedBox.shrink();
    }

    final note = notes[index];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: ListTile(
        title: Text(note),
        onTap: () => _editNote(context, index, noteService),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: ThemeColors.turkeyred,
          ),
          onPressed: () => _confirmDelete(context, index, noteService),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    ToastContext().init(context);

    return FloatingActionButton(
      backgroundColor: ThemeColors.turkeyred,
      onPressed: () => _addNote(context, noteService),
      tooltip: 'Adicionar Nota',
      child: const Icon(
        Icons.add,
        color: ThemeColors.white,
      ),
    );
  }

  void _addNote(BuildContext context, Future<NoteService> noteService) {
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();
    ToastContext().init(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        FocusScope.of(context).requestFocus(focusNode);

        return Stack(
          children: [
            const ModalBarrier(
              dismissible: false,
              color: Colors.transparent,
            ),
            _buildAlertDialog(
              'Adicionar Nota',
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Digite sua nota',
                  labelStyle: TextStyle(
                    color: ThemeColors.turkeyred,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.turkeyred,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.turkeyred,
                    ),
                  ),
                  hintText: 'Digite sua nota',
                ),
                cursorColor: ThemeColors.turkeyred,
                focusNode: focusNode,
                controller: controller,
              ),
              () => Navigator.of(context).pop(),
              () {
                if (controller.text.trim().isNotEmpty) {
                  noteService.then((service) {
                    service.addNote(controller.text);
                    Navigator.of(context).pop();
                    setState(() {});
                  });
                } else {
                  showToast('A nota não pode ser vazia');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _editNote(BuildContext context, int index, NoteService noteService) {
    final TextEditingController controller =
        TextEditingController(text: noteService.getNotes()[index]);
    final FocusNode focusNode = FocusNode();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        FocusScope.of(context).requestFocus(focusNode);
        return Stack(
          children: [
            const ModalBarrier(
              dismissible: false,
              color: Colors.transparent,
            ),
            _buildAlertDialog(
              'Editar Nota',
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Edite sua nota',
                  labelStyle: TextStyle(
                    color: ThemeColors.turkeyred,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.turkeyred,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.turkeyred,
                    ),
                  ),
                  hintText: 'Edite sua nota',
                ),
                cursorColor: ThemeColors.turkeyred,
                focusNode: focusNode,
                controller: controller,
              ),
              () => Navigator.of(context).pop(),
              () {
                noteService.editNote(index, controller.text);
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(
      BuildContext context, int index, NoteService noteService) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            const ModalBarrier(
              dismissible: false,
              color: Colors.transparent,
            ),
            _buildAlertDialog(
              'Deletar Nota',
              const Text('Tem certeza que quer deletar esta nota?'),
              () => Navigator.of(context).pop(),
              () {
                noteService.deleteNote(index);
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAlertDialog(
    String title,
    Widget content,
    VoidCallback onCancel,
    VoidCallback onConfirm,
  ) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: const Text(
            'Cancelar',
            style: TextStyle(color: ThemeColors.bloodRed),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text(
            'Confirmar',
            style: TextStyle(color: ThemeColors.green),
          ),
        ),
      ],
    );
  }
}
