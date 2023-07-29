import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/add_note/add_note_cubit.dart';

import 'package:notes_app/features/home/views/widgets/AddNotes.dart';
import 'package:notes_app/features/home/views/widgets/home_view_body.dart';
import '../../../cubits/cubit/delete_note_cubit_cubit.dart';
import '../../../cubits/cubit/delete_note_cubit_state.dart';
import '../../../cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String id = 'HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<FetchNotesCubit>(context).fetchNotes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff303030),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // ....
            },
          ),
        ],
        title: const Text(
          'Notes',
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff62fcd6),
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              backgroundColor: const Color(0xff303030),
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) => AddNoteCubit(),
                  child: const AddNotesBottomSheet(), //BlocProvider
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            DeleteNoteCubit(), //manage the blocProvider of deleteCubit here
        child: const SafeArea(
          child: NotesViewBlocBodyConsumer(),
        ),
      ),
    );
  }
}

class NotesViewBlocBodyConsumer extends StatelessWidget {
  const NotesViewBlocBodyConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteNoteCubit, DeleteNoteCubitState>(
      listener: (context, state) {
        if (state is DeleteNoteCubitSuccess) {
          //to rebuild
          BlocProvider.of<FetchNotesCubit>(context).fetchNotes();
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is DeleteNoteCubitLoading ? true : false,
            child: const HomeViewBody());
        // return HomeViewBody();
      },
    );
  }
}
