import '/flutter_flow/flutter_flow_util.dart';
import 'vendor_sign_widget.dart' show VendorSignWidget;
import 'package:flutter/material.dart';

class VendorSignModel extends FlutterFlowModel<VendorSignWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for vendorName widget.
  FocusNode? vendorNameFocusNode;
  TextEditingController? vendorNameTextController;
  String? Function(BuildContext, String?)? vendorNameTextControllerValidator;
  // State field(s) for contactNo widget.
  FocusNode? contactNoFocusNode;
  TextEditingController? contactNoTextController;
  String? Function(BuildContext, String?)? contactNoTextControllerValidator;
  // State field(s) for socMed widget.
  FocusNode? socMedFocusNode;
  TextEditingController? socMedTextController;
  String? Function(BuildContext, String?)? socMedTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    vendorNameFocusNode?.dispose();
    vendorNameTextController?.dispose();

    contactNoFocusNode?.dispose();
    contactNoTextController?.dispose();

    socMedFocusNode?.dispose();
    socMedTextController?.dispose();
  }
}
