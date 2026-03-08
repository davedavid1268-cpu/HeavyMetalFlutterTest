import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';

void main() {
  testWidgets('App loads and shows showcase list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('HeavyMetal Screen Showcase'), findsOneWidget);
    expect(find.text('1. Home / Discovery'), findsOneWidget);
  });
}
