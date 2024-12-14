import 'package:flutter/material.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';
import 'main.dart';
import 'list_item.dart';

class Kanban extends StatefulWidget {
  const Kanban({super.key});

  @override
  State<Kanban> createState() => _Kanban();
}

class _Kanban extends State<Kanban> {
  Widget task(String description) {
    return Text(description, style: const TextStyle(color: Colors.amber, fontSize: 16),);
  }
  List<BoardListsData> boards = [];
  BoardListsData todo = BoardListsData(items: []);
  List<Widget> tasks = [];

  @override
  initState() {
    super.initState();
    Widget firstTask = task("This is my first task");
    tasks.add(firstTask);
    todo = BoardListsData(
        title: "ToDo",
        items: tasks);
    boards.add(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Kanban",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: KanbanBoard(
                backgroundColor: Colors.white,
                boardDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                listDecoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                boards,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
