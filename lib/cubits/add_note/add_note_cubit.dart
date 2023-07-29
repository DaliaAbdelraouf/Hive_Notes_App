import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/features/home/views/models/notes_model.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());
  Color color = const Color(0xffAC3931);
  addNote(NotesModel notesModel) async {
      notesModel.color = color.value;
    emit(AddNoteLoading());
    try {
      var box = Hive.box<NotesModel>('notes');
      await box.add(notesModel);
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFailure());
    }
  }
}
