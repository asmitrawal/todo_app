import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app/common/common_state.dart';
import 'package:todo_app/common/custom_dialog.dart';
import 'package:todo_app/dashboard/cubit/create_todo_cubit.dart';
import 'package:todo_app/dashboard/cubit/delete_todo_cubit.dart';
import 'package:todo_app/dashboard/cubit/fetch_todos_cubit.dart';
import 'package:todo_app/dashboard/cubit/update_todo_cubit.dart';
import 'package:todo_app/dashboard/model/todo.dart';
import 'package:todo_app/dashboard/ui/custom_app_bar.dart';
import 'package:todo_app/dashboard/ui/upper_section.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? todoText;

    //update module is moved here because the onPressed cannot handle async function
    _updateTodoHandler({required List<Todo> todo, required int index}) async {
      todoText = await showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            taskAtHand: "Update your",
          );
        },
      );
      if (todoText != null) {
        print(todoText);
        context
            .read<UpdateTodoCubit>()
            .updateTodo(docId: todo[index].docId, title: todoText);
      }
    }

    return Scaffold(
      //moved appBar to seperate file for clean code
      appBar: CustomAppBar(),

      body: MultiBlocListener(
        listeners: [
          BlocListener<CreateTodoCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoadingState) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }

              if (state is CommonSuccessState) {
                context.read<FetchTodosCubit>().refreshTodos();
              }
            },
          ),
          BlocListener<DeleteTodoCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoadingState) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }

              if (state is CommonSuccessState) {
                context.read<FetchTodosCubit>().refreshTodos();
              }
            },
          ),
          BlocListener<UpdateTodoCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoadingState) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }

              if (state is CommonSuccessState) {
                context.read<FetchTodosCubit>().refreshTodos();
              }
            },
          ),
          BlocListener<FetchTodosCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoadingState) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UpperSection(),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                "Today's Tasks",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            BlocBuilder<FetchTodosCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonSuccessState<List<Todo>>) {
                  return Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Scrollbar(
                        thumbVisibility: true,
                        thickness: 10,
                        interactive: true,
                        trackVisibility: true,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...List<Widget>.generate(
                                state.item.length,
                                (index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    color: Colors.white,
                                    child: Slidable(
                                      startActionPane: ActionPane(
                                        // dismissible: DismissiblePane(
                                        //   onDismissed: () {},
                                        // ),
                                        motion: DrawerMotion(),
                                        children: [
                                          SlidableAction(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.blueAccent,
                                            icon: Icons.edit,
                                            onPressed: (context) {
                                              _updateTodoHandler(
                                                  todo: state.item,
                                                  index: index);
                                            },
                                          ),
                                          SlidableAction(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.redAccent,
                                            icon: Icons.delete_forever,
                                            onPressed: (context) {
                                              context
                                                  .read<DeleteTodoCubit>()
                                                  .deleteTodo(
                                                    docId:
                                                        state.item[index].docId,
                                                  );
                                            },
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          "Task ${state.item[index].title}",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(left: 5),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        onPressed: () async {
          todoText = await showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                taskAtHand: "Create a new",
              );
            },
          );
          if (todoText != null) {
            context.read<CreateTodoCubit>().createTodo(title: todoText);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
