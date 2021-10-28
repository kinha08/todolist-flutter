import 'package:flutter/material.dart';
import 'package:todolist/pages/widgets/list_widget.dart';

class TodoListPage extends StatelessWidget {
  final List<TodoItem> items;
  final void Function(String)? onRemove;
  const TodoListPage({Key? key, required this.items, this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListWidget(
      items: items,
      onRemove: (id) {
        if (onRemove != null) {
          onRemove!(id);
        }
      },
    );
  }
}
