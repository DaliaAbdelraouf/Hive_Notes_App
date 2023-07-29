part of 'fetch_notes_cubit.dart';

@immutable
abstract class FetchNotesState {}

class FetchNotesInitial extends FetchNotesState {}

class FetchNotesLoading extends FetchNotesState {}

class FetchNotesFailure extends FetchNotesState {
  final String errMessage;
  FetchNotesFailure(this.errMessage);
}

class FetchNotesSuccess extends FetchNotesState {
  final List<NotesModel> notes;

  FetchNotesSuccess(this.notes);
}
