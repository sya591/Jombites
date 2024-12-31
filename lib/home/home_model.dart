import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  List<VendorRecord>? listViewPreviousSnapshot;
  // State field(s) for ChoiceChip widget.
  FormFieldController<List<String>>? choiceChipValueController;
  String? get choiceChipValue => choiceChipValueController?.value?.firstOrNull;
  set choiceChipValue(String? val) =>
      choiceChipValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
