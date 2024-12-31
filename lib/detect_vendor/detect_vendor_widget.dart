import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detect_vendor_model.dart';
import 'package:fuzzy/fuzzy.dart';
export 'detect_vendor_model.dart';

class DetectVendorWidget extends StatefulWidget {
  const DetectVendorWidget({super.key});

  @override
  State<DetectVendorWidget> createState() => _DetectVendorWidgetState();
}

class _DetectVendorWidgetState extends State<DetectVendorWidget> {
  late DetectVendorModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DocumentSnapshot? lastDocument; // To store the last document

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetectVendorModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'DetectVendor'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 30.0,
            ),
            onPressed: () async {
              logFirebaseEvent('DETECT_VENDOR_arrow_back_rounded_ICN_ON_');
              logFirebaseEvent('IconButton_navigate_back');
              context.pop();
            },
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  Locate Vendor',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Poppins',
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 4.0, 10.0, 4.0),
                    child: Text(
                      'Upload a photo below in order for us to detect the vendor',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 344.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Hero(
                                    tag: 'detectVendorImage',
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: Image.asset(
                                        'assets/images/Upload.jpg',
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                2.5,
                                        height: 100.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Hero(
                                    tag: 'italyImage',
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                      ),
                                      child: Image.asset(
                                        'assets/images/Upload.jpg',
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                2.5,
                                        height: 100.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'DETECT_VENDOR_Container_kcli3t7a_ON_TAP');
                            logFirebaseEvent(
                                'Container_upload_media_to_firebase');
                            final selectedMedia = await selectMedia(
                              mediaSource: MediaSource.photoGallery,
                              multiImage: false,
                            );
                            if (selectedMedia != null &&
                                selectedMedia.every((m) => validateFileFormat(
                                    m.storagePath, context))) {
                              safeSetState(() => _model.isDataUploading = true);
                              var selectedUploadedFiles = <FFUploadedFile>[];

                              var downloadUrls = <String>[];
                              try {
                                selectedUploadedFiles = selectedMedia
                                    .map((m) => FFUploadedFile(
                                          name: m.storagePath.split('/').last,
                                          bytes: m.bytes,
                                          height: m.dimensions?.height,
                                          width: m.dimensions?.width,
                                          blurHash: m.blurHash,
                                        ))
                                    .toList();

                                downloadUrls = (await Future.wait(
                                  selectedMedia.map(
                                    (m) async => await uploadData(
                                        m.storagePath, m.bytes),
                                  ),
                                ))
                                    .where((u) => u != null)
                                    .map((u) => u!)
                                    .toList();
                              } finally {
                                _model.isDataUploading = false;
                              }
                              if (selectedUploadedFiles.length ==
                                      selectedMedia.length &&
                                  downloadUrls.length == selectedMedia.length) {
                                safeSetState(() {
                                  _model.uploadedLocalFile =
                                      selectedUploadedFiles.first;
                                  _model.uploadedFileUrl = downloadUrls.first;
                                });
                              } else {
                                safeSetState(() {});
                                return;
                              }
                            }

                            if (_model.uploadedFileUrl != '') {
                              logFirebaseEvent('Container_custom_action');
                              _model.detectedText =
                                  await actions.detectTextFromImage(
                                _model.uploadedFileUrl,
                              );

                              // Debug log for detected text
                              print('Detected Text: ${_model.detectedText}'); // LOG 1

// Check if no text is detected
                              if (_model.detectedText == null || _model.detectedText!.trim().isEmpty) {
                                print('No text detected. Aborting vendor query.'); // Debug log

                                // Show dialog for no text detected
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('No Text Detected'),
                                      content: const Text(
                                          'No text was detected in the uploaded image. Please upload another image.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(alertDialogContext),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                return; // **Stop further processing**
                              }

// Proceed with vendor query and fuzzy matching if text is detected
                              logFirebaseEvent('Container_firestore_query');
                              print('Querying vendors...');
                              _model.vendorsList = await queryVendorRecordOnce(
                                queryBuilder: (vendorRecord) {
                                  return vendorRecord.orderBy('VendorName').limit(50);
                                },
                              );

                              logFirebaseEvent('Container_firestore_query');
                              print('Querying vendors...'); // LOG 2
                              _model.vendorsList = await queryVendorRecordOnce(
                                queryBuilder: (vendorRecord) {
                                  return vendorRecord
                                      .orderBy('VendorName') // Order by name
                                      .limit(50);            // Limit results for pagination
                                },
                              );
                              print('Vendors Found: ${_model.vendorsList?.length ?? 0}'); // LOG 3

                              if (_model.vendorsList == null || _model.vendorsList!.isEmpty) {
                                // Log or Print for Debugging
                                print('No matching vendors found.'); // Debug log for empty list

                                // Show an Alert Dialog
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('No Vendors Found'),
                                      content: const Text(
                                          'No matching vendors were found for the uploaded image. Please try another image.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(alertDialogContext),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // Navigate to VendorResult Page
                                Future.delayed(const Duration(milliseconds: 500), () {
                                  context.pushNamed(
                                    'VendorResult',
                                    queryParameters: {
                                      'detectedText':
                                      Uri.encodeComponent(_model.detectedText ?? ''), // Encode text
                                    }.withoutNulls,
                                  );
                                });
                              }

                            } else {
                              logFirebaseEvent('Container_alert_dialog');
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    content: const Text(
                                        'Please upload an image before confirming.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }

                            safeSetState(() {});
                          },
                          child: Container(
                            width: 150.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiary,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 10.0, 0.0),
                              child: Text(
                                'Upload',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'DETECT_VENDOR_Container_46gls8ys_ON_TAP');
                            logFirebaseEvent('Container_navigate_back');
                            context.safePop();
                          },
                          child: Container(
                            width: 150.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiary,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 10.0, 0.0),
                              child: Text(
                                'Cancel',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
