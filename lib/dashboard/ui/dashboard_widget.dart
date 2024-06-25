import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  IconData _mode = Icons.dark_mode_outlined;
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
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
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
          Expanded(
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
                      20,
                      (index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              "Task ${index + 1}",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 5),
                          ),
                        );
                      },
                    ),
                  ],
                )),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
