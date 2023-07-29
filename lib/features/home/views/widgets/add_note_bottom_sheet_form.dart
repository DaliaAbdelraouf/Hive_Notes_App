import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/add_note/add_note_cubit.dart';
import 'package:notes_app/features/home/views/models/notes_model.dart';
import 'package:notes_app/features/home/views/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';
import 'colors_list_view.dart';

class AddNoteBottomSheetForm extends StatefulWidget {
  const AddNoteBottomSheetForm({super.key});

  @override
  State<AddNoteBottomSheetForm> createState() => _AddNoteBottomSheetFormState();
}

class _AddNoteBottomSheetFormState extends State<AddNoteBottomSheetForm> {
  String? Title;

  String? Subtitle;

  GlobalKey<FormState> formkey = GlobalKey();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 20),
        CustomTextField(
          onSaved: (value) {
            Title = value;
          },
          hint: 'Title',
          lines: 2,
        ),
        const SizedBox(height: 15),
        CustomTextField(
          onSaved: (value) {
            Subtitle = value;
          },
          hint: 'Content',
          lines: 6,
        ),
        const SizedBox(height: 15),
        const ColorsListView(),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () async {
            if (formkey.currentState!.validate()) {
              formkey.currentState!.save();
              var currentDate = DateTime.now();

              var formattedCurrentDate =
                  DateFormat('dd-mm-yyyy').format(currentDate);

              await BlocProvider.of<AddNoteCubit>(context).addNote(NotesModel(
                  Title: Title!,
                  subtitle: Subtitle!,
                  date: formattedCurrentDate,
                  color: Colors.white.value));
            } else {
              autoValidateMode = AutovalidateMode.always;
              setState(() {});
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff62fcd6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            minimumSize: const Size(380, 50),
          ),
          child: BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              if (state is AddNoteLoading) {
                return const CircularProgressIndicator();
              } else {
                return const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}
