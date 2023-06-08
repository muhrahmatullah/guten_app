import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guten_app/screens/list/book_list_screen.dart';
import 'package:guten_app/screens/list/book_list_vm.dart';
import 'package:provider/provider.dart';

import 'mock.dart';

void main() {
  group('list screen test', () {
    late GutenBookListScreen view;
    late BookListViewModel vm;

    setUp(() {
      vm = MockBookListViewModel();
      view = const GutenBookListScreen();
    });

    Widget _buildApp(Widget app) {
      return MaterialApp(
        home: MultiProvider(
          child: app,
          providers: [ChangeNotifierProvider<BookListViewModel>.value(value: vm)],
        ),
      );
    }

    testWidgets('init view', (widgetTester) async {
      final widget = _buildApp(view);
      await widgetTester.pumpWidget(widget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    }, skip: true);
  });
}
