import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'package:flutter/material.dart';

import '../../../features/home/views/models/notes_model.dart';

part 'fetch_notes_state.dart';

class FetchNotesCubit extends Cubit<FetchNotesState> {
  FetchNotesCubit() : super(FetchNotesInitial());
  void fetchNotes() {
    var box = Hive.box<NotesModel>('notes');
    box.values.toList();

    try {
      var box = Hive.box<NotesModel>('notes');
      var notesList = box.values.toList();

      emit(FetchNotesSuccess(notesList));
    } catch (e) {
      emit(FetchNotesFailure("errMessage"));
    }
  }
}
