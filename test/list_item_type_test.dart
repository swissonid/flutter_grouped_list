import 'package:flutter/material.dart';
import 'package:flutter_grouped_list_items/list_item_type.dart';
import 'package:flutter_test/flutter_test.dart';

final onlyItems = [
  ListItem(title: 'Item 1', icon: Icon(Icons.abc_rounded)),
  ListItem(title: 'Item 2', icon: Icon(Icons.abc_rounded)),
  ListItem(title: 'Item 3', icon: Icon(Icons.abc_rounded)),
];

final oneGroup = Group(title: 'One group', children: onlyItems);
final anOtherOneGroup = Group(title: 'Other OneGroup', children: onlyItems);
final nestedGroup = Group(
  title: 'TestGroup - Level 0',
  children: [
    Group(
      title: 'TestGroup - Level 1',
      children: [Group(title: 'TestGroup - Level 2')],
    ),
  ],
);

final nestedGroupWithItems = Group(
  title: 'TestGroup - Level 0',
  children: [
    Group(
      title: 'TestGroup - Level 1',
      children: [
        Group(title: 'TestGroup - Level 2', children: onlyItems),
        ...onlyItems,
      ],
    ),
    ...onlyItems,
  ],
);
void main() {
  group('flattened tests', () {
    test('should flatten 3 layer into one', () {
      expect(onlyItems.flattened(), containsAll(onlyItems));
    });

    test(
      'One group should create a list with first item group rest its children',
      () {
        expect(
          [oneGroup].flattened(),
          containsAll([oneGroup.toEmptyGroup(), ...oneGroup.children!]),
        );
      },
    );
    test('Two group in one list', () {
      expect(
        [oneGroup, anOtherOneGroup].flattened(),
        containsAll([
          oneGroup.toEmptyGroup(),
          ...oneGroup.children!,
          anOtherOneGroup.toEmptyGroup(),
          ...anOtherOneGroup.children!,
        ]),
      );
    });

    test('Nested group should end up in flatt list', () {
      expect(
        [nestedGroup].flattened(),
        containsAll([
          Group(title: 'TestGroup - Level 0').toEmptyGroup(),
          Group(title: 'TestGroup - Level 1').toEmptyGroup(),
          Group(title: 'TestGroup - Level 2').toEmptyGroup(),
        ]),
      );
    });

    test('Nested group with itmes should end up in flatt list', () {
      expect(
        [nestedGroupWithItems].flattened(),
        containsAll([
          Group(title: 'TestGroup - Level 0').toEmptyGroup(),
          ...onlyItems,
          Group(title: 'TestGroup - Level 1').toEmptyGroup(),
          ...onlyItems,
          Group(title: 'TestGroup - Level 2').toEmptyGroup(),
          ...onlyItems,
        ]),
      );
    });
  });
}
