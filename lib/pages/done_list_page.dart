import 'package:flutter/material.dart';
import 'package:todolist/pages/widgets/list_widget.dart';

class DoneListPage extends StatelessWidget {
  final List<TodoItem> items;
  final void Function(String)? onRemove;
  const DoneListPage({Key? key, required this.items, this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TodoItem> _itemsFiltered =
        items.where((item) => item.done == true).toList();
    return ListWidget(
      items: _itemsFiltered,
      onRemove: (id) {
        if (onRemove != null) {
          onRemove!(id);
        }
      },
    );
  }
}
