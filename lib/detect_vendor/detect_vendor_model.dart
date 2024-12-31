import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'detect_vendor_widget.dart' show DetectVendorWidget;
import 'package:flutter/material.dart';

class DetectVendorModel extends FlutterFlowModel<DetectVendorWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Custom Action - detectTextFromImage] action in Container widget.
  String? detectedText;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<VendorRecord>? vendorsList;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
