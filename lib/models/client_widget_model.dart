import 'package:client_app/models/channel_model.dart';
import 'package:client_common/api/response_models/api_error.dart';
import 'package:lenra_ui_runner/widget_model.dart';

class ClientWidgetModel extends WidgetModel<ApiError> {
  late ChannelModel channelModel;

  ClientWidgetModel({required this.channelModel});

  void setupListeners() {
    channelModel.channel!.onUi((Map<dynamic, dynamic>? ui) {
      if (ui == null) return;

      if (!channelModel.isInitialized) {
        channelModel.isInitialized = true;
      }

      replaceUi(ui as Map<String, dynamic>);
    });

    channelModel.channel!.onPatchUi((Map<dynamic, dynamic>? json) {
      Iterable<Map<String, dynamic>> patches = (json?["patch"] as Iterable).map((e) => e as Map<String, dynamic>);
      patchUi(patches);
    });

    channelModel.channel!.onAppError((Map<dynamic, dynamic> json) {
      if (!channelModel.isInitialized) {
        channelModel.isInitialized = true;
      }

      setErrors(ApiError.fromJson(json as Map<String, dynamic>));
    });
  }
}
