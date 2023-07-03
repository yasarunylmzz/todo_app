import 'package:flutter/material.dart';
import 'package:todo_app/utility/my_buttonwidget.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final text;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.text,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            Card(
              elevation: 5,
              color: Colors.yellow,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: text,
                    prefixIcon: Icon(
                      Icons.article_rounded,
                      size: 20,
                      color: Colors.black,
                    )),
              ),
            ),

            //button -> save +cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //save button
                MyButton(text: 'Save', onPressed: onSave),
                const SizedBox(
                  width: 8,
                ),

                //cancel button
                MyButton(text: 'Cancel', onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
