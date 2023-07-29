import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes_app/features/home/views/models/notes_model.dart';

import '../../../../cubits/cubit/delete_note_cubit_cubit.dart';
import 'notes_details.dart';

class HomeViewItem extends StatelessWidget {
  const HomeViewItem({super.key, required this.note});
  final NotesModel note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EditNotes(note: note);
        }));
      },
      //.....
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 390,
                  height: 200,
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    color: Color(note.color),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Text(
                              note.Title ?? '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(280, 10, 0, 0),
                                child: IconButton(
                                  color: Colors.black,
                                  icon: const Icon(Icons.delete, size: 30),
                                  onPressed: () async {
                                    //handle delete note
                                    BlocProvider.of<DeleteNoteCubit>(context)
                                        .deleteNote(note);
                                  },
                                )),
                          ]),
                          const SizedBox(height: 15),
                          Text(
                            note.subtitle ?? '',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 68, 68, 68),
                                fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(235, 40, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  note.date,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 68, 68, 68),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                )),
          ])),
    );
  }
}
