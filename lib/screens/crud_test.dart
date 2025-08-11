import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todos = [];
  // final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  void addToDO() {
    if (_controller.text.isEmpty) {
      return;
    } else {
      setState(() {
        todos.add(_controller.text);
      });
    }
    _controller.clear();
  }

  void removeToDo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void editTodo(int index) {
    final editController = TextEditingController(text: todos[index]);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("edit to do"),
          content: TextField(controller: editController),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancle"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  todos[index] = editController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 150),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter todo'),
                  ),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: addToDO),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index]),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => editTodo(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => removeToDo(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 13),
        ],
      ),
    );
  }
}
