import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/features/home/views/models/notes_model.dart';
import 'package:notes_app/utils/custom_bloc_observer.dart';

import 'cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import 'features/home/views/home_view.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchNotesCubit()
        ..fetchNotes(), //cascadeOperator two dotes >>trigger fetchNotes
      child: MaterialApp(
        title: "NotesApp",
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff303030),
        ),
        routes: {
          HomeView.id: (context) => const HomeView(),
        },
        initialRoute: HomeView.id,
      ),
    );
  }
}
