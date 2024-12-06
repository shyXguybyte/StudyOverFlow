import 'package:flutter/material.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';
import 'list_item.dart';
class Kanban extends StatefulWidget {
  const Kanban({super.key});

  @override
  State<Kanban> createState() => _Kanban();
}

class _Kanban extends State<Kanban> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Kanban",
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
                 borderRadius: BorderRadius.circular(20)
               ),
              listDecoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              List.generate(
                3,
                  (index) => BoardListsData(
                    title: "ToDo",
                    backgroundColor: Colors.black,
                    header: const Row(
                      children: [
                        Text('data'),
                      ],
                    ),
                      items: List.generate(
                        5,
                          (index) => Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Lorem ipsum dolor sit amet, sunt in culpa qui officia deserunt mollit anim id est laborum. $index",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                      ),
                  ),
              ),
            ),
           ),
          ],
        ),
      ),

    );
  }
}