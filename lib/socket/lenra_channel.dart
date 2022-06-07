library socket;

import 'package:phoenix_wings/phoenix_wings.dart';

class LenraChannel {
  late PhoenixChannel _channel;
  List<dynamic Function(Map<dynamic, dynamic>?)> _errorCallbacks = [];
  LenraChannel(PhoenixSocket socket, String channelName, Map<String, dynamic> params) {
    _channel = socket.channel(channelName, params);
    _channel.join()?.receive("error", (Map<dynamic, dynamic>? response) {
      _errorCallbacks.forEach((c) {
        c(response);
      });
    });
  }

  void close() {
    this._channel.off("ui");
    this._channel.off("patchUi");
    this._channel.off("error");
    _channel.leave();
  }

  void onUi(void Function(Map<dynamic, dynamic>) callback) {
    this._channel.on("ui", (payload, ref, joinRef) {
      if (payload == null) return;
      callback(payload);
    });
  }

  void onPatchUi(void Function(Map<dynamic, dynamic>) callback) {
    this._channel.on("patchUi", (payload, ref, joinRef) {
      if (payload == null) return;
      callback(payload);
    });
  }

  void onAppError(void Function(Map<dynamic, dynamic>) callback) {
    this._channel.on("error", (payload, ref, joinRef) {
      if (payload == null) return;
      callback(payload);
    });
  }

  void onError(dynamic Function(Map<dynamic, dynamic>?) callback) {
    this._errorCallbacks.add(callback);
  }

  void send(String event, dynamic data) {
    this._channel.push(event: event, payload: data as Map<dynamic, dynamic>);
  }
}
