import 'package:client_app/socket/lenra_channel.dart';
import 'package:flutter/widgets.dart';

abstract class SocketModel extends ChangeNotifier {
  LenraChannel channel(String channelName, Map<String, dynamic> params);
}
