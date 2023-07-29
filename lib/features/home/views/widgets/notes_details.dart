import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import '../models/notes_model.dart';
import 'edit_note_colors.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key, required this.note});
  final NotesModel note;
  static const String id = 'EditNotes';

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  String? title, content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff303030),
          title: const Text(
            'Edit Notes',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  widget.note.Title = title ?? widget.note.Title;
                  widget.note.subtitle = content ?? widget.note.subtitle;
                  widget.note.save();
                  BlocProvider.of<FetchNotesCubit>(context).fetchNotes();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: widget.note.Title ?? '',
                    fillColor: const Color(0xff303030),
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 18),
                    focusedBorder: builderBorder(),
                    enabledBorder: builderBorder(),
                  ),
                  onSubmitted: (value) {
                    log("Message");
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 7,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: widget.note.subtitle ?? '',
                    fillColor: const Color(0xff303030),
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 18),
                    focusedBorder: builderBorder(),
                    enabledBorder: builderBorder(),
                  ),
                  onSubmitted: (value) {
                    log("Message");
                  },
                ),
                const SizedBox(height: 20),
                EditNoteColorsList(
                  note: widget.note,
                ),
              ],
            ),
          ),
        ));
  }
}

OutlineInputBorder builderBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.white));
