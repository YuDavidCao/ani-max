import '/flutter_flow/flutter_flow_util.dart';
import 'health_metrics_widget.dart' show HealthMetricsWidget;
import 'package:flutter/material.dart';

class HealthMetricsModel extends FlutterFlowModel<HealthMetricsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for VOC TextField widget.
  FocusNode? vocFocusNode;
  TextEditingController? vocTextController;
  String? Function(BuildContext, String?)? vocTextControllerValidator;
  // State field(s) for HeartRate TextField widget.
  FocusNode? heartRateFocusNode;
  TextEditingController? heartRateTextController;
  String? Function(BuildContext, String?)? heartRateTextControllerValidator;
  // State field(s) for Speed TextField widget.
  FocusNode? speedFocusNode;
  TextEditingController? speedTextController;
  String? Function(BuildContext, String?)? speedTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    vocFocusNode?.dispose();
    vocTextController?.dispose();
    heartRateFocusNode?.dispose();
    heartRateTextController?.dispose();
    speedFocusNode?.dispose();
    speedTextController?.dispose();
  }
}
