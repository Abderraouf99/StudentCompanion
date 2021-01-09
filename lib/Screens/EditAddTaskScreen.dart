import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/models/DataTask.dart';
import 'package:to_do_app/models/Tasks.dart';

class EditAddTaskScreen extends StatelessWidget {
  final String type;
  final Function functionnality;
  EditAddTaskScreen({@required this.type, @required this.functionnality});
  @override
  Widget build(BuildContext context) {
    return Consumer<ControllerTask>(
      builder: (context, task, child) {
        return Container(
          color: Color(0xff757575),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: kRoundedContainerDecorator.copyWith(
                color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add a task',
                      style: TextStyle(
                        color: Color(0xffffbd69),
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Task taskToadd = Task(
                          task: task.task,
                          status: false,
                          index: task.getTasks().length,
                        );
                        functionnality(taskToadd);
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        backgroundColor: Color(0xffffbd69),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  autofocus: true,
                  onChanged: (value) {
                    task.setTask(value);
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Task',
                    focusColor: Color(0xffffbd69),
                    hintStyle: TextStyle(
                      color: Color(0xffEEEEEE),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
