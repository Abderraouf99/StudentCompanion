import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Widgets/DeleteDismissWidget.dart';
import 'package:to_do_app/Widgets/NoteTile.dart';
import 'package:to_do_app/Widgets/unArchiveDismissWidget.dart';
import 'package:to_do_app/models/DataNotes.dart';

class NoteList extends StatelessWidget {
  final bool _isArchived = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<NotesController>(
      builder: (context, notesController, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Dismissible(
              background: UnArchiveDismissWidget(),
              secondaryBackground: DeleteDismissWidget(),
              onDismissed: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  await notesController.moveToBin(index, _isArchived);
                } else {
                  await notesController.archiveNote(index);
                }
              },
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  await showAlertDialog(
                    context: context,
                    title: 'Deleted notes',
                    message: 'This note will be moved to the bin',
                    barrierDismissible: false,
                    actions: [
                      AlertDialogAction(label: 'Confirm'),
                    ],
                  );
                } else {
                  await showAlertDialog(
                    context: context,
                    title: 'Archived notes',
                    message: 'This note will be moved to the archive',
                    barrierDismissible: false,
                    actions: [
                      AlertDialogAction(label: 'Confirm'),
                    ],
                  );
                }
                return true;
              },
              key: UniqueKey(),
              child: NoteTile(
                note: notesController.notes[index],
              ),
            );
          },
          itemCount: (notesController.notes != null) ? notesController.notes.length : 0,
        );
      },
    );
  }
}
