import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/common/common_state.dart';
import 'package:todo_app/dashboard/cubit/create_todo_cubit.dart';
import 'package:todo_app/dashboard/cubit/fetch_todos_cubit.dart';
import 'package:todo_app/dashboard/model/todo.dart';
import 'package:todo_app/login/ui/login_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  IconData _mode = Icons.dark_mode_outlined;

  @override
  void initState() {
    super.initState();

    context.read<FetchTodosCubit>().fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Icon(FontAwesomeIcons.user),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (_mode == Icons.dark_mode_outlined) {
                    _mode = Icons.dark_mode;
                  } else {
                    _mode = Icons.dark_mode_outlined;
                  }
                });
              },
              icon: Icon(_mode)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(PageTransition(
                  child: LoginScreen(),
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 300),
                ));
              },
              icon: Icon(Icons.logout)),
        ],
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "What's up, Aayush!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "CATEGORIES",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 4,
                  child: Container(
                    height: 80,
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "40 tasks",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Due Tasks",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 6,
                  fit: FlexFit.tight,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "18 tasks",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Completed Tasks",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
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
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                  endActionPane: ActionPane(
                                    dismissible: DismissiblePane(
                                      onDismissed: () {},
                                    ),
                                    motion: DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        icon: Icons.edit,
                                        onPressed: (context) {},
                                      ),
                                      SlidableAction(
                                        icon: Icons.delete_forever,
                                        onPressed: (context) {},
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
                                    contentPadding: EdgeInsets.only(left: 5),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        onPressed: () {
          context.read<CreateTodoCubit>().createTodo(title: "hello testing");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
