import 'package:client_app/lenra_ui_controller.dart';
import 'package:client_app/models/channel_model.dart';
import 'package:client_app/models/client_widget_model.dart';
import 'package:client_app/models/context_model.dart';
import 'package:client_app/models/socket_model.dart';
import 'package:flutter/material.dart';
import 'package:lenra_ui_runner/widget_model.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  final String appName;

  const App({Key? key, required this.appName}) : super(key: key);

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContextModel>(create: (context) => ContextModel()),
        ChangeNotifierProxyProvider2<SocketModel, ContextModel, ChannelModel>(
          create: (context) =>
              ChannelModel(socketModel: context.read<SocketModel>(), contextModel: context.read<ContextModel>()),
          update: (_, socketModel, contextModel, channelModel) {
            if (channelModel == null) {
              return ChannelModel(socketModel: socketModel, contextModel: contextModel);
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
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.read<ContextModel>().mediaQueryData = MediaQuery.of(context);
          //The model calls are in the postframe callback because the mediaquerydata is not set until the first frame
          context.read<ChannelModel>().createChannel(widget.appName);
          (context.read<WidgetModel>() as ClientWidgetModel).setupListeners();
        });
        return const LenraUiController();
      },
    );
  }
}
