import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helpers/database_helper.dart';
import '../models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  final Function updateTaskList;
  final Task? task;

  AddTaskScreen({required this.updateTaskList, this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  late String _priority;
  DateTime _date = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = ['Low', 'Medium', 'High'];

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _title = widget.task!.title;
      _date = widget.task!.date;
      _priority = widget.task!.priority;
      _dateController.text = _dateFormatter.format(_date);
    } else {
      _priority = _priorities[0];
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  _delete() {
    DatabaseHelper.instance.deleteTask(widget.task!.id);
    Navigator.pop(context);
    widget.updateTaskList();
    Fluttertoast.showToast(
      msg: "Task Deleted",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      Task task = Task(
        title: _title,
        date: _date,
        priority: _priority,
        status: widget.task?.status ?? 0,
      );

      if (widget.task == null) {
        DatabaseHelper.instance.insertTask(task);
        Fluttertoast.showToast(
          msg: "New Task Added",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        task.id = widget.task!.id;
        DatabaseHelper.instance.updateTask(task);
        Fluttertoast.showToast(
          msg: "Task Updated",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
      Navigator.pop(context);
      widget.updateTaskList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.task == null ? 'Add Task' : 'Update Task',
          style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: const TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Please enter a task title'
                              : null,
                          onSaved: (input) => _title = input!,
                          initialValue: _title,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          style: const TextStyle(fontSize: 18.0),
                          onTap: _handleDatePicker,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle: const TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: DropdownButtonFormField(
                          isDense: true,
                          icon: const Icon(Icons.arrow_drop_down_circle),
                          iconSize: 22.0,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: _priorities.map((String priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            );
                          }).toList(),
                          style: const TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            labelStyle: const TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) => value == null
                              ? 'Please select a priority level'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _priority = value.toString();
                            });
                          },
                          value: _priority,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextButton(
                          onPressed: _submit,
                          child: Text(
                            widget.task == null ? 'Add' : 'Update',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      widget.task != null
                          ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 0.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextButton(
                          onPressed: _delete,
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
