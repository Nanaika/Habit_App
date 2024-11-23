import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/bottom_bar_index_bloc.dart';
import 'package:habit_app/bloc/completed_daily_tasks_bloc.dart';
import 'package:habit_app/bloc/task_bloc.dart';
import 'package:habit_app/domain/models/task.dart';
import 'package:habit_app/pages/root_page.dart';
import 'package:habit_app/theme.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  setLightSystemBars();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [TaskSchema],
    directory: dir.path,
  );

  runApp(MyApp(
    db: isar,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.db});

  final Isar db;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => BottomBarIndexBloc()),
        BlocProvider(create: (ctx) => TaskBloc(db)),
        BlocProvider(create: (ctx) => CompletedDailyTasksBloc(db)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        home: const RootPage(),
      ),
    );
  }
}
