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
  Group(title: 'Level 4 - Header 2', children: [...leve5Items, ...onlyItems]),
  Group(title: 'Level 4 - Header 3', children: [...leve5Items, ...onlyItems]),
];

final level3 = <ListItemType>[
  Group(title: 'Level 3 - Header 1', children: [...level4, ...onlyItems]),
  Group(title: 'Level 3 - Header 2', children: [...level4, ...onlyItems]),
  Group(title: 'Level 3 - Header 3', children: [...level4, ...onlyItems]),
];

final level2 = <ListItemType>[
  Group(title: 'Level 2 - Header 1', children: [...level3, ...onlyItems]),
  Group(title: 'Level 2 - Header 2', children: [...level3, ...onlyItems]),
  Group(title: 'Level 2 - Header 3', children: [...level3, ...onlyItems]),
];

final level1 = <ListItemType>[
  Group(title: 'Level 1 - Header 1', children: [...level2, ...onlyItems]),
  Group(title: 'Level 1 - Header 2', children: [...level2, ...onlyItems]),
  Group(title: 'Level 1 - Header 3', children: [...level2, ...onlyItems]),
];

Group createGroupWith({
  int numberOfChildren = 3,
  int level = 0,
  List<ListItemType> postChildren = const [],
}) {
  final title = "Level - $level";
  final children = List<ListItemType>.generate(
    numberOfChildren,
    (index) => ListItem(title: '$index Item of group $title (${UniqueKey()})'),
  );
  return Group(
    title: '$title (${UniqueKey()})',
    level: level,
    children: [...children, ...postChildren],
  );
}

Group createGroupWith5Level() {
  final level5 = createGroupWith(level: 5);
  final level4 = createGroupWith(level: 4, postChildren: [level5]);
  final level3 = createGroupWith(level: 3, postChildren: [level4]);
  final level2 = createGroupWith(level: 2, postChildren: [level3]);
  final level1 = createGroupWith(level: 1, postChildren: [level2]);
  return level1;
}

final itemList = List<ListItemType>.generate(
  1000,
  (_) => createGroupWith5Level(),
);
/*final itemList = [
  Group(
    title: 'Level 1 - Header 1',
    children: [
      Group(
        title: 'Level 2 - Header 1',
        children: [
          Group(
            title: 'Level 3 - Header 1',
            children: [
              Group(
                title: 'Level 4 - Header 1',
                children: [
                  Group(
                    icon: Icon(Icons.abc),
                    title: "Level 5 - Header 1 only with items",
                    isOpen: false,
                    children: onlyItems,
                  ),
                  ...onlyItems,
                ],
              ),
              ...onlyItems,
            ],
          ),
          ...onlyItems,
        ],
      ),
      ...onlyItems,
    ],
  ),
];*/
