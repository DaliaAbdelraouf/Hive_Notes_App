import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/features/home/views/models/notes_model.dart';

import 'delete_note_cubit_state.dart';


class DeleteNoteCubit extends Cubit<DeleteNoteCubitState> {
  DeleteNoteCubit() : super(DeleteNoteCubitInitial());

  deleteNote(NotesModel note) async {
    emit(DeleteNoteCubitLoading());
    try {
      await note.delete();
      emit(DeleteNoteCubitSuccess());
    } catch (e) {
      emit(DeleteNoteCubitFailure(e.toString()));
    }
  }
}
