import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/dashboard/cubit/create_todo_cubit.dart';
import 'package:todo_app/dashboard/cubit/fetch_todos_cubit.dart';
import 'package:todo_app/dashboard/repository/dashboard_repository.dart';
import 'package:todo_app/dashboard/ui/dashboard_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FetchTodosCubit(repository: context.read<DashboardRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              CreateTodoCubit(repository: context.read<DashboardRepository>()),
        ),
      ],
      child: DashboardWidget(),
    );
  }
}
