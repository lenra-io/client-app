import 'dart:convert';

import 'package:client_app/lenra_ui_controller.dart';
import 'package:client_app/models/channel_model.dart';
import 'package:client_common/test/lenra_page_test_help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_ui_runner/components/events/data/empty_data.dart';
import 'package:lenra_ui_runner/components/events/data/value_data.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('LenraUiController simple instantiation',
      (WidgetTester tester) async {
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

  testWidgets('LenraUiController with initialized ChannelModel',
      (WidgetTester tester) async {
    final GlobalKey key = GlobalKey();

    await tester.runAsync(
      () => tester.pumpWidget(
        createAppTestWidgets(
          LenraUiController(
            key: key,
            accessToken: "random-access-token",
            appName: "app-name",
          ),
        ),
      ),
    );

    await tester.pump();

    final context = tester.element(find.byType(Scaffold));
    context.read<ChannelModel>().channel!.send("ui", {"data": "data"});

    await tester.pump();

    expect(find.byType(LenraUiController), findsOneWidget);
    // expect(find.byType(LenraErrorPage), findsOneWidget);
    // expect(find.byType(LenraWidget<ApiErrors>), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
