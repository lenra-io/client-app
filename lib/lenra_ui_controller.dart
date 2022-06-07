import 'package:client_app/models/app_socket_model.dart';
import 'package:client_app/models/channel_model.dart';
import 'package:client_app/models/client_widget_model.dart';
import 'package:client_app/models/socket_model.dart';
import 'package:client_common/api/response_models/api_errors.dart';
import 'package:client_common/lenra_application/api_error_snack_bar.dart';
import 'package:client_common/lenra_application/app_error_page.dart';
import 'package:client_common/lenra_application/lenra_error_page.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/components/events/event.dart';
import 'package:lenra_ui_runner/lenra_ui_runner.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

class LenraUiController extends StatefulWidget {
  final String accessToken;

  const LenraUiController({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<LenraUiController> createState() {
    return _LenraUiControllerState();
  }
}

class _LenraUiControllerState extends State<LenraUiController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SocketModel>(
          create: (context) => AppSocketModel(widget.accessToken),
        ),
        ChangeNotifierProxyProvider<SocketModel, ChannelModel>(
          create: (context) => ChannelModel(socketModel: context.read<SocketModel>()),
          update: (_, socketModel, channelModel) {
            if (channelModel == null) {
              return ChannelModel(socketModel: socketModel);
            }
            return channelModel.update(socketModel);
          },
        ),
        ChangeNotifierProxyProvider<ChannelModel, WidgetModel>(
          create: (context) => ClientWidgetModel(channelModel: context.read<ChannelModel>()),
          update: (_, channelModel, clientWidgetModel) => clientWidgetModel!,
        ),
      ],
      builder: (BuildContext context, _) {
        ChannelModel channelModel = context.watch<ChannelModel>();
        Widget res;
        if (channelModel.hasError) {
          res = LenraErrorPage(apiErrors: channelModel.errors!);
        } else if (!channelModel.isInitialized) {
          res = const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          res = LenraWidget<ApiErrors>(
            buildErrorPage: (BuildContext context, ApiErrors errors) => AppErrorPage(apiErrors: errors),
            showSnackBar: (BuildContext context, ApiErrors errors) => {
              ScaffoldMessenger.of(context).showSnackBar(ApiErrorSnackBar(
                errors: errors,
                onPressAction: () => ScaffoldMessenger.of(context).clearSnackBars(),
                actionLabel: "Ok",
              )),
            },
          );
        }

        return NotificationListener(
          onNotification: (Event event) => context.read<ChannelModel>().handleNotifications(event),
          child: Scaffold(body: res),
        );
      },
    );
  }
}
