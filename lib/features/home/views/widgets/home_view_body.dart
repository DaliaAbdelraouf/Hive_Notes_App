import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes_app/features/home/views/widgets/notes_details.dart';

import '../../../../cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import 'home_view_item.dart';

// final  List<NoteModel> notes;
class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNotesCubit, FetchNotesState>(
        builder: (context, state) {
      if (state is FetchNotesSuccess) {
        return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              return HomeViewItem(note: state.notes[index]);
            });
      } else if (state is FetchNotesFailure) {
        return const Text('Failure ...');
      } else {
        return (const CircularProgressIndicator());
      }
    });
  }
}
