import 'package:client_app/lenra_ui_controller.dart';
import 'package:client_common/test/lenra_page_test_help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LenraUiController simple instantiation', (WidgetTester tester) async {
    await tester.runAsync(
      () => tester.pumpWidget(
        createAppTestWidgets(
          const LenraUiController(
            accessToken: "random-access-token",
            appName: "app-name",
          ),
        ),
      ),
    );

    expect(find.byType(LenraUiController), findsOneWidget);
    // expect(find.byType(LenraErrorPage), findsOneWidget);
    // expect(find.byType(LenraWidget<ApiErrors>), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('LenraUiController with initialized ChannelModel', (WidgetTester tester) async {
    await tester.runAsync(
      () => tester.pumpWidget(
        createAppTestWidgets(
          const LenraUiController(
            accessToken: "random-access-token",
            appName: "app-name",
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 15));

    expect(find.byType(LenraUiController), findsOneWidget);
    // expect(find.byType(LenraErrorPage), findsOneWidget);
    // expect(find.byType(LenraWidget<ApiErrors>), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
