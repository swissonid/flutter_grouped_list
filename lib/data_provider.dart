import 'package:flutter/material.dart';
import 'package:flutter_grouped_list_items/list_item_type.dart';

final onlyItems = [
  ListItem(title: 'Item 1', icon: Icon(Icons.abc_rounded)),
  ListItem(title: 'Item 2', icon: Icon(Icons.abc_rounded)),
  ListItem(title: 'Item 3', icon: Icon(Icons.abc_rounded)),
];

final leve5Items = <ListItemType>[
  Group(
    icon: Icon(Icons.abc),
    title: "Level 5 - Header 1 only with items",
    isOpen: false,
    children: onlyItems,
  ),
  Group(
    icon: Icon(Icons.abc),
    title: "Level 5 - Header 2 only with items",
    isOpen: false,
    children: onlyItems,
  ),
  Group(
    icon: Icon(Icons.abc),
    title: "Level 5 - Header 3 only with items",
    isOpen: false,
    children: onlyItems,
  ),
];

final level4 = <ListItemType>[
  Group(title: 'Level 4 - Header 1', children: [...leve5Items, ...onlyItems]),
  Group(title: 'Level 4 - Header 1', children: [...leve5Items, ...onlyItems]),
  Group(title: 'Level 4 - Header 1', children: [...leve5Items, ...onlyItems]),
];

final level3 = <ListItemType>[
  Group(title: 'Level 3 - Header 1', children: [...level4, ...onlyItems]),
  Group(title: 'Level 3 - Header 1', children: [...level4, ...onlyItems]),
  Group(title: 'Level 3 - Header 1', children: [...level4, ...onlyItems]),
];

final level2 = <ListItemType>[
  Group(title: 'Level 2 - Header 1', children: [...level3, ...onlyItems]),
  Group(title: 'Level 2 - Header 1', children: [...level3, ...onlyItems]),
  Group(title: 'Level 2 - Header 1', children: [...level3, ...onlyItems]),
];

final level1 = <ListItemType>[
  Group(title: 'Level 1 - Header 1', children: [...level2, ...onlyItems]),
  Group(title: 'Level 1 - Header 1', children: [...level2, ...onlyItems]),
  Group(title: 'Level 1 - Header 1', children: [...level2, ...onlyItems]),
];

final itemList = level1;
