import 'package:flutter/material.dart';

import 'list_item_type.dart';

class EvenSimplerWidget extends StatefulWidget {
  final List<ListItemType> items;
  const EvenSimplerWidget({super.key, required this.items});

  @override
  _EvenSimplerWidgetState createState() => _EvenSimplerWidgetState();
}

class _EvenSimplerWidgetState extends State<EvenSimplerWidget> {
  late List<ListItemType> unflattedList;
  late List<ListItemType> flattedList;
  @override
  void initState() {
    super.initState();
    unflattedList = widget.items;
    flattedList = widget.items.flattened().toList();
  }

  void toggleAndRefresh(String groupTitle) {
    setState(() {
      unflattedList = unflattedList.toggleGroup(groupTitle).toList();
      flattedList = unflattedList.flattened().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: flattedList.length,
      itemBuilder: (context, index) {
        final item = flattedList.elementAt(index);
        // Colors.blue[item.level * 100]
        switch (item) {
          case Group():
            final tileColor =
                Colors.deepPurple[item.level * 100] ?? Colors.deepPurple;

            final isToDark = tileColor.computeLuminance() >= 0.179;
            final textAndIconColor = isToDark ? Colors.black : Colors.white;

            return ListTile(
              title: Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textAndIconColor,
                ),
              ),
              trailing: Icon(
                item.isOpen ? Icons.expand_less : Icons.expand_more,
                color: textAndIconColor,
              ),
              onTap: () => toggleAndRefresh(item.title),
              tileColor: tileColor,
            );
          case ListItem():
            return ListTile(title: Text(item.title));
        }
      },
    );
  }
}
