import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uts/signin_helper.dart';

import 'api.dart';
import 'components/card_todo.dart';
import 'components/dialog_tambah.dart';
import 'components/mytext.dart';
import 'models/model_todo.dart';

class PlaceholderWidget extends StatefulWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  _PlaceholderWidgetState createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
  String? userID;
  List<ModelTodo> todolist = [];

  void getUserData() async {
    await GoogleSignInHelper().getUserData().then((value) {
      if (value != null) {
        setState(() {
          userID = value.uid;
        });
      }
    });

    getTodo();
  }

  void getTodo() async {
    List<ModelTodo> list = await API().getTodoList(userID);

    list.sort((a, b) => a.todoDeadline.compareTo(b.todoDeadline));

    setState(() {
      todolist = list;
    });
  }

  void updateTodo({required ModelTodo todo, String? status}) async {
    EasyLoading.show(status: 'Please wait');

    if (status != null) {
      final rsp = await API().todoDone(todo, status);

      var parse = json.decode(rsp.body);
      if (parse['status'] == 201) {
        EasyLoading.showSuccess(parse['message']);
        getTodo();
      } else {
        EasyLoading.showError(parse['message']);
      }
    } else {
      final rsp = await API().updateTodo(todo);

      var parse = json.decode(rsp.body);
      if (parse['status'] == 201) {
        EasyLoading.showSuccess(parse['message']);
        getTodo();
      } else {
        EasyLoading.showError(parse['message']);
      }
    }
  }

  void deleteTodo(String id) async {
    EasyLoading.show(status: 'Please wait');
    final rsp = await API().deleteTodo(id);

    var parse = json.decode(rsp.body);
    if (parse['status'] == 201) {
      EasyLoading.showSuccess(parse['message']);
      getTodo();
    } else {
      EasyLoading.showError(parse['message']);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: todolist.isNotEmpty
          ? ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(2.h),
              itemCount: todolist.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 2.h,
              ),
              itemBuilder: (context, index) => CardTodo(
                data: todolist[index],
                onUpdate: (context) {
                  showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      showDragHandle: true,
                      context: context,
                      builder: (_) => DialogTambah(
                            isEdit: true,
                            uid: userID!,
                            data: todolist[index],
                          )).then((value) {
                    if (value != null) {
                      updateTodo(todo: value);
                    }
                  });
                },
                onDone: (context) {
                  print('DONE');
                  updateTodo(todo: todolist[index], status: '1');
                },
                onDelete: (context) {
                  print('DELETE');
                  deleteTodo(todolist[index].todoId);
                },
              ),
            )
          : Center(
              child: OutlinedButton(
                  onPressed: () {
                    getTodo();
                  },
                  child: MyText('Refresh')),
            ),
    );
  }
  // List<charts.Series<LinearNilai, String>> _createSampleData(
  //     List<LinearNilai> data) {
  //   return [
  //     charts.Series<LinearNilai, String>(
  //       id: 'Nilai',
  //       domainFn: (LinearNilai Nilai, _) => Nilai.hari,
  //       measureFn: (LinearNilai Nilai, _) => Nilai.Nilai,
  //       data: data,
  //     )
  //   ];
  // }

  // List<LinearNilai> _data = [
  //   LinearNilai('Mon', 5),
  //   LinearNilai('Tue', 25),
  //   LinearNilai('Wed', 100),
  //   LinearNilai('Thu', 75),
  // ];

  // TextEditingController _hariController = TextEditingController();
  // TextEditingController _NilaiController = TextEditingController();

  // void _addData() {
  //   setState(() {
  //     _data.add(LinearNilai(
  //         _hariController.text, int.tryParse(_NilaiController.text) ?? 0));
  //     _hariController.clear();
  //     _NilaiController.clear();
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Text(
  //           'Dashboard',
  //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       Container(
  //         height: 200,
  //         child: charts.BarChart(
  //           _createSampleData(_data),
  //           animate: true,
  //         ),
  //       ),
  //       SizedBox(height: 20),
  //       TextField(
  //         controller: _hariController,
  //         decoration: InputDecoration(hintText: 'Hari'),
  //       ),
  //       TextField(
  //         controller: _NilaiController,
  //         decoration: InputDecoration(hintText: 'Nilai'),
  //         keyboardType: TextInputType.number,
  //       ),
  //       ElevatedButton(
  //         onPressed: _addData,
  //         child: Text('Add Data'),
  //       ),
  //       Container(
  //         color: widget.color,
  //       ),
  //     ],
  //   );
  // }
}

class LinearNilai {
  final String hari;
  final int Nilai;

  LinearNilai(this.hari, this.Nilai);
}
