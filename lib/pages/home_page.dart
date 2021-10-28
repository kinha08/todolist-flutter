import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:todolist/pages/add_items_page.dart';
import 'package:todolist/pages/do_list_page.dart';
import 'package:todolist/pages/done_list_page.dart';
import 'package:todolist/pages/todo_list_page.dart';
import 'package:todolist/pages/widgets/list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoItem> _items = [];
  final db = Localstore.instance;

  @override
  void initState() {
    super.initState();
    _getItems().then((value) {
      setState(() {
        _items = value;
      });
    });
  }

  void _addItem(String text) {
    final id = db.collection('todos').doc().id;
    db.collection('todos').doc(id).set({
      'text': text,
      'done': false,
      'id': id,
    });
    _getItems();
    setState(() {
      _getItems().then((value) => _items = value);
    });
  }

  void _removeItem(String id) {
    db.collection('todos').doc(id).delete();
    setState(() {
      _getItems().then((value) => _items = value);
    });
  }

  Future<List<TodoItem>> _getItems() async {
    final data = await db.collection('todos').get();
    final List<TodoItem> list = <TodoItem>[];
    data?.forEach((key, value) {
      list.add(TodoItem(value['text'], value['done'], value['id']));
    });
    return list;
  }

  Future<void> showRemoveConfirmationDialog(String id) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deletar tarefa'),
          content: const Text('Deseja remover esta tarefa?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _removeItem(id);
                Navigator.of(context).pop();
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAddTask(BuildContext context) async {
    final result =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const AddItemPage();
    }));

    if (result != null) {
      _addItem(result.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                _navigateToAddTask(context);
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
          title: const Text('Lista de tarefas'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tarefas'),
              Tab(text: 'Fazer'),
              Tab(text: 'Feito'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TodoListPage(
              items: _items,
              onRemove: (id) {
                showRemoveConfirmationDialog(id);
              },
            ),
            DoListPage(
              items: _items,
              onRemove: (id) {
                showRemoveConfirmationDialog(id);
              },
            ),
            DoneListPage(
              items: _items,
              onRemove: (id) {
                showRemoveConfirmationDialog(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
