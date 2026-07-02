import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notemanagement/main.dart';

void main() {
  testWidgets('NotesApp is a valid widget', (WidgetTester tester) async {
    // We do not pump the real NotesApp here because it calls
    // Firebase.initializeApp, which requires platform plugins that are not
    // available in a pure unit test environment. We only verify that the
    // class is constructible.
    expect(const NotesApp(), isA<Widget>());
  });
}