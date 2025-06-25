// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

sealed class ListItemType {}

class ListItem extends ListItemType {
  final String title;
  final Icon? icon;

  ListItem({required this.title, this.icon});

  ListItem copyWith({String? title, Icon? icon}) {
    return ListItem(title: title ?? this.title, icon: icon ?? this.icon);
  }

  @override
  String toString() {
    return title;
  }
}

class Group extends ListItemType {
  final String title;
  final int level;
  final bool isOpen;
  final Icon icon;
  final List<ListItemType>? children;

  Group({
    required this.title,
    this.level = 0,
    this.isOpen = true,
    this.icon = const Icon(Icons.headset),
    this.children,
  });

  Group toggle() {
    return copyWith(isOpen: !isOpen);
  }

  Group copyWith({
    String? title,
    bool? isOpen,
    Icon? icon,
    List<ListItemType>? children,
  }) {
    return Group(
      title: title ?? this.title,
      isOpen: isOpen ?? this.isOpen,
      icon: icon ?? this.icon,
      children: children ?? this.children,
    );
  }

  Group toEmptyGroup() => copyWith(children: []);

  @override
  bool operator ==(covariant Group other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.level == level &&
        other.isOpen == isOpen &&
        other.icon == icon &&
        listEquals(other.children, children);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        level.hashCode ^
        isOpen.hashCode ^
        icon.hashCode ^
        children.hashCode;
  }

  @override
  String toString() {
    return title;
  }
}

extension ListItemTypFlattend on Iterable<ListItemType> {
  Iterable<ListItemType> flattened({bool skipClosedSection = true}) {
    bool shouldSkip(Group group, Iterable<ListItemType>? children) {
      if (children == null) return true;
      if (!group.isOpen && skipClosedSection) return true;
      return false;
    }

    final flattenedList = <ListItemType>[];

    for (var listItemType in this) {
      switch (listItemType) {
        case Group():
          final children = listItemType.children;
          flattenedList.add(listItemType.toEmptyGroup());

          if (shouldSkip(listItemType, children)) break;

          // Separate direct children into groups and items
          final directGroups = <Group>[];
          final directItems = <ListItem>[];

          for (var child in children!) {
            switch (child) {
              case Group():
                directGroups.add(child);
                break;
              case ListItem():
                directItems.add(child);
                break;
            }
          }

          // Add direct items first
          flattenedList.addAll(directItems);

          // Then recursively flatten direct groups
          flattenedList.addAll(
            directGroups.flattened(skipClosedSection: skipClosedSection),
          );

          break;

        case ListItem():
          flattenedList.add(listItemType);
          break;
      }
    }
    return flattenedList;
  }
}
