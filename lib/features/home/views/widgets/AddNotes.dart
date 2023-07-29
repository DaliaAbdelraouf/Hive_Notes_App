import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes_app/cubits/add_note/add_note_cubit.dart';

import 'package:notes_app/features/home/views/widgets/add_note_bottom_sheet_form.dart';

import '../../../../cubits/fetch_notes_cubit/fetch_notes_cubit.dart';

//set state is the best option if we are working in the widget
//{State Management}providor,Mobox,(bloc,Gotx,riverbod)
//bloc :"busniess logic component" (bloc pattern)
// states cubit  blocprovider integrate trigger

class AddNotesBottomSheet extends StatelessWidget {
  const AddNotesBottomSheet({super.key});

  // bool isloading = false;
  @override
  Widget build(BuildContext context) {
    //use bloc consumer when i need listener
    return BlocConsumer<AddNoteCubit, AddNoteState>(
      listener: (context, state) {
        if (state is AddNoteLoading) {
          // isloading = true;
        }
        if (state is AddNoteSuccess) {
          //to rebuild
          BlocProvider.of<FetchNotesCubit>(context).fetchNotes();

          Navigator.pop(context); //to pop the bottom sheet
        }
        if (State is AddNoteFailure) {
          //show failure bar
        }
      },
      builder: (context, state) {
        //  ModalProgressHUD
        return AbsorbPointer(
          absorbing: state is AddNoteLoading ? true : false,
          child: Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const SingleChildScrollView(
              child: AddNoteBottomSheetForm(),
            ),
          ),
        );
      },
    );
  }
}

OutlineInputBorder builderBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.white));
