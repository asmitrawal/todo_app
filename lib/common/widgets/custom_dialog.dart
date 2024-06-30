// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? taskAtHand;
  CustomDialog({
    Key? key,
    required this.taskAtHand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? _controller = TextEditingController();
    String? todoText;
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${taskAtHand} Todo",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Write your todo here",
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    todoText = _controller.text;
                    Navigator.of(context).pop(todoText);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Done",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
