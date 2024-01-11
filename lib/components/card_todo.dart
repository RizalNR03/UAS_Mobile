import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/model_todo.dart';
import 'mytext.dart';

class CardTodo extends StatefulWidget {
  const CardTodo(
      {super.key,
      required this.data,
      required this.onDone,
      required this.onDelete, required this.onUpdate});
  final ModelTodo data;
  final Function(BuildContext context) onUpdate;
  final Function(BuildContext context) onDone;
  final Function(BuildContext context) onDelete;

  @override
  State<CardTodo> createState() => _CardTodoState();
}

class _CardTodoState extends State<CardTodo> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: widget.data.todoStatus == '1'
          ? null
          : ActionPane(motion: BehindMotion(), children: [
              SlidableAction(
                onPressed: widget.onDone,
                icon: Icons.done,
                label: 'Done',
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              )
            ]),
      endActionPane: ActionPane(motion: BehindMotion(), children: [
        SlidableAction(
          onPressed: widget.onUpdate,
          icon: Icons.edit,
          label: 'Update',
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        SlidableAction(
          onPressed: widget.onDelete,
          icon: Icons.delete,
          label: 'Delete',
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        )
      ]),
      child: Card(
          child: ExpansionTile(
        childrenPadding: EdgeInsets.fromLTRB(4.h, 2.h, 2.h, 2.h),
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        leading: widget.data.todoStatus == '1'
            ? Image.asset(
                'assets/done.png',
                width: 3.h,
                height: 3.h,
              )
            : null,
        title: MyText(
          widget.data.todoTitle,
          maxLines: 2,
          weight: FontWeight.w600,
          size: 16,
        ),
        children: [
          MyText(
            widget.data.todoDesc,
            maxLines: 5,
          ),
          SizedBox(
            height: 1.h,
          ),
          MyText(
            'Due date: ${DateFormat('dd MMM yyyy').format(widget.data.todoDeadline)}',
            maxLines: 2,
            isItalic: true,
            color: Colors.grey,
          ),
        ],
      )),
    );
  }
}
