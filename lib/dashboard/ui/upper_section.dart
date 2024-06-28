import 'package:flutter/material.dart';

class UpperSection extends StatelessWidget {
  const UpperSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
      ],
    );
  }
}
