import 'package:flutter/material.dart';

abstract class ListItem {

  Widget buildTask(BuildContext context);

}

class Tasks implements ListItem {

  final String task_name;

  Tasks(this.task_name);
  @override
  Widget buildTask(BuildContext context) {
    return Text(task_name,
      style: Theme.of(context).textTheme.headlineSmall,);
  }
}

class Button implements ListItem {

  @override
  Widget buildTask(BuildContext context) {

    return ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(20, 20)
        ),
        child: const Text('data'));
  }
}
