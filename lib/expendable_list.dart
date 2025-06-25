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
        return ListHeader(title: Text(item.title));
      }
      return ListHeader(title: Text(item.title));

    case ListItem():
      return ListTile(title: Text(item.title));
  }
}

class ListHeader extends StatefulWidget {
  const ListHeader({super.key, required this.title});
  final Widget title;

  @override
  State<ListHeader> createState() => _ListHeaderState();
}

class _ListHeaderState extends State<ListHeader> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right)),
    );
  }
}

extension OptionalFlattend<T> on Iterable<List<T>?> {
  Iterable<T> flattened() => expand((e) => e ?? []);
}

extension Flattend<T> on Iterable<List<T>> {
  Iterable<T> flattened() => expand((e) => e);
}
