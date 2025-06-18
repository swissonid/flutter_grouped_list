// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_grouped_list_items/list_item_type.dart';

class ExpendableList extends StatelessWidget {
  final List<ListItemType> items;

  const ExpendableList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return createListItem(context, items[index]);
      },
    );
  }
}

Widget createListItem(BuildContext context, ListItemType item) {
  switch (item) {
    case Group():
      if (item.isOpen) {
        final children =
            item.children
                ?.map((item) => createListItem(context, item))
                .toList() ??
            [];
        return ExpansionTile(
          title: Text(item.title),
          maintainState: true,
          children: children,
        );
      }
      return ExpansionTile(title: Text(item.title), maintainState: true);

    case ListItem():
      return ListTile(title: Text(item.title));
  }
}

extension OptionalFlattend<T> on Iterable<List<T>?> {
  Iterable<T> flattened() => expand((e) => e ?? []);
}

extension Flattend<T> on Iterable<List<T>> {
  Iterable<T> flattened() => expand((e) => e);
}
