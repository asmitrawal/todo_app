import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/common/common_state.dart';
import 'package:todo_app/common/custom_dialog.dart';
import 'package:todo_app/dashboard/cubit/create_todo_cubit.dart';
import 'package:todo_app/dashboard/cubit/delete_todo_cubit.dart';
import 'package:todo_app/dashboard/cubit/fetch_todos_cubit.dart';
import 'package:todo_app/dashboard/cubit/update_todo_cubit.dart';
import 'package:todo_app/dashboard/model/todo.dart';
import 'package:todo_app/dashboard/ui/custom_app_bar.dart';
import 'package:todo_app/dashboard/ui/upper_section.dart';
import 'package:todo_app/login/cubit/sign_out_cubit.dart';
import 'package:todo_app/login/repository/login_repository.dart';
import 'package:todo_app/login/ui/login_screen.dart';

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
    //fetch current user to perfrom personalised CRUD
    User? user = FirebaseAuth.instance.currentUser;

    //flag to prevent two loading indicators showing
    bool _isInitialLoad = true;

    //for creating and updating todo
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
        context.read<UpdateTodoCubit>().updateTodo(
              docId: todo[index].docId,
              title: todoText,
              userId: user!.displayName!.split(" ").join("_").toLowerCase(),
            );
      }
    }

    return BlocListener<SignOutCubit, CommonState>(
  
      listener: (context, state) {
        if (state is CommonSuccessState) {
          Navigator.of(context).push(
            PageTransition(
              child: LoginScreen(),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 300),
            ),
          );
        }
      },
      child: Scaffold(
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
          child: RefreshIndicator(
            onRefresh: () async {
              _isInitialLoad = false; // to get rid of builder loading indicator

              await context.read<FetchTodosCubit>().fetchTodos(
                    userId:
                        user!.displayName!.split(" ").join("_").toLowerCase(),
                  );
            },
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
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Scrollbar(
                            //scroll bar for thumb visibility, track visibilty
                            thumbVisibility: true,
                            thickness: 5,
                            interactive: true,
                            trackVisibility: true,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics()
                                  .applyTo(AlwaysScrollableScrollPhysics()),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...List<Widget>.generate(
                                    state.item!.length,
                                    (index) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 12),
                                        color: Colors.white,
                                        child: Slidable(
                                          endActionPane: ActionPane(
                                            // dismissible: DismissiblePane(
                                            //   onDismissed: () {},
                                            // ),
                                            motion: DrawerMotion(),
                                            children: [
                                              SlidableAction(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    Colors.blueAccent,
                                                icon: Icons.edit,
                                                onPressed: (context) {
                                                  _updateTodoHandler(
                                                      todo: state.item!,
                                                      index: index);
                                                },
                                              ),
                                              SlidableAction(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    Colors.redAccent,
                                                icon: Icons.delete_forever,
                                                onPressed: (context) {
                                                  context
                                                      .read<DeleteTodoCubit>()
                                                      .deleteTodo(
                                                        docId: state
                                                            .item![index].docId,
                                                        userId: user!
                                                            .displayName!
                                                            .split(" ")
                                                            .join("_")
                                                            .toLowerCase(),
                                                      );
                                                },
                                              ),
                                            ],
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              "Task ${state.item![index].title}",
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
                      if (_isInitialLoad) {
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      } else {
                        //this case will NEVER be reached, so chilling
                        return Center();
                      }
                    }
                  },
                )
              ],
            ),
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
              context.read<CreateTodoCubit>().createTodo(
                    title: todoText,
                    userId:
                        user!.displayName!.split(" ").join("_").toLowerCase(),
                  );
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
