import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/model_todo.dart';
import 'fill_button.dart';
import 'mytext.dart';

class DialogTambah extends StatefulWidget {
  const DialogTambah(
      {super.key, required this.isEdit, required this.uid, this.data});
  final bool isEdit;
  final String uid;
  final ModelTodo? data;

  @override
  State<DialogTambah> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DialogTambah> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  DateTime? deadline;
  var isDone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      titleController.text = widget.data!.todoTitle;
      descController.text = widget.data!.todoDesc;
      deadline = widget.data!.todoDeadline;
      isDone = widget.data!.todoStatus == '1';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      padding: EdgeInsets.all(2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: MyText(
              widget.isEdit ? 'Update Activity' : 'New Activity',
              weight: FontWeight.w600,
              size: 18,
            ),
          ),
          Divider(),
          const MyText(
            'Title',
            weight: FontWeight.w600,
          ),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                filled: false,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.h)),
                hintText: 'Enter title'),
          ),
          SizedBox(
            height: 2.h,
          ),
          const MyText(
            'Description',
            weight: FontWeight.w600,
          ),
          TextField(
            controller: descController,
            minLines: 3,
            maxLines: 3,
            decoration: InputDecoration(
                filled: false,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.h)),
                hintText: 'Enter description'),
          ),
          SizedBox(
            height: 2.h,
          ),
          const MyText(
            'Due date',
            weight: FontWeight.w600,
          ),
          InkWell(
            onTap: () async {
              showDatePicker(
                      context: context,
                      initialDate: deadline ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100, 12, 12))
                  .then((value) {
                if (value != null) {
                  setState(() {
                    deadline = value;
                  });
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(2.h)),
              padding: EdgeInsets.all(2.h),
              child: Row(children: [
                Expanded(
                  child: MyText(deadline != null
                      ? DateFormat('EEEE, dd MMMM yyyy').format(deadline!)
                      : 'Pick due date'),
                ),
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.grey,
                )
              ]),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Expanded(
                child: const MyText(
                  'Status',
                  weight: FontWeight.w600,
                ),
              ),
              Switch(
                value: isDone,
                onChanged: (value) {
                  setState(() {
                    isDone = value;
                  });
                },
              )
            ],
          ),
          Spacer(),
          FillButton(
            onClick: () {
              if (titleController.text.isEmpty) {
                Fluttertoast.showToast(msg: 'Please fill the title');
                return;
              }
              if (descController.text.isEmpty) {
                Fluttertoast.showToast(msg: 'Please fill the description');
                return;
              }
              if (deadline == null) {
                Fluttertoast.showToast(msg: 'Pick a due date');
                return;
              }

              var data = ModelTodo(
                  todoId: widget.isEdit ? widget.data!.todoId : '-',
                  todoTitle: titleController.text,
                  todoDesc: descController.text,
                  todoDeadline: deadline ?? DateTime.now(),
                  todoStatus: isDone ? '1' : '0',
                  userId: widget.uid,
                  timestamp: DateTime.now());
              Navigator.pop(context, data);
            },
            label: widget.isEdit ? 'Update activity' : 'Add new activity',
          )
        ],
      ),
    );
  }
}
