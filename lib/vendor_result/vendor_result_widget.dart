import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fuzzy/fuzzy.dart';

class VendorResultWidget extends StatefulWidget {
  const VendorResultWidget({
    super.key,
    this.detectedText, // Detected text passed as parameter
  });

  final String? detectedText; // Passed query parameter

  @override
  State<VendorResultWidget> createState() => _VendorResultWidgetState();
}

class _VendorResultWidgetState extends State<VendorResultWidget> {
  // Clean detected text by removing special characters and line breaks
  String cleanDetectedText(String text) {
    return text
        .replaceAll(RegExp(r'[^\w\s]'), '') // Remove special characters
        .replaceAll(RegExp(r'\s+'), ' ')  // Replace multiple spaces
        .trim().toLowerCase(); // Convert to lowercase
  }


  @override
  Widget build(BuildContext context) {

    // Decode and clean detected text
    final String detectedText = Uri.decodeComponent(widget.detectedText ?? ''); // Decode text
    final String cleanedText = cleanDetectedText(detectedText); // Clean text
    print('Cleaned Text: $cleanedText'); // Debug Log

    return StreamBuilder<List<VendorRecord>>(
      stream: queryVendorRecord(
        queryBuilder: (vendorRecord) =>
            vendorRecord.orderBy('VendorName').limit(50),
      ),
      builder: (context, snapshot) {
        // Check if data is still loading
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: SpinKitFadingCircle(
                color: FlutterFlowTheme.of(context).tertiary,
                size: 50.0,
              ),
            ),
          );
        }

        // Extract vendor data
        final vendorList = snapshot.data!;
        print('Performing fuzzy matching...'); // LOG

        // Initialize Fuzzy for searching
        final fuse = Fuzzy<Map<String, dynamic>>(
          vendorList.map((vendor) {
            return {'VendorName': vendor.vendorName, 'data': vendor}; // Map each vendor
          }).toList(),
          options: FuzzyOptions(
            keys: [
              WeightedKey(
                name: 'VendorName', // Match based on vendor name
                getter: (item) =>
                (item as Map<String, dynamic>)['VendorName'], // Extract VendorName
                weight: 1.0, // Prioritize vendor name
              ),
            ],
            threshold: 0.4, // Tolerance level
            distance: 100, // Max similarity distance
          ),
        );

        // Perform fuzzy search
        final results = fuse.search(cleanedText); // Match cleaned text
        print('Fuzzy Results Found: ${results.length}'); // LOG

        // Extract matched vendor data
        final vendorResults = results
            .map((result) =>
        (result.item['data'] as VendorRecord)) // Extract matched vendors
            .toList();

        // Show alert dialog if no results found
        if (vendorResults.isEmpty) {
          Future.delayed(Duration.zero, () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('No Results'),
                content: const Text('No matching vendors found.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); // Go back
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          });
          return Container();
        }

        // Display matched vendors in a ListView
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search Results'),
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
          ),
          body: ListView.builder(
            itemCount: vendorResults.length,
            itemBuilder: (context, index) {
              final vendor = vendorResults[index];
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 12.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    context.pushNamed(
                      'CafeDetails',
                      queryParameters: {
                        'receiveCafe': serializeParam(
                          vendor.reference,
                          ParamType.DocumentReference,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x411D2429),
                          offset: Offset(
                            0.0,
                            1.0,
                          ),
                        )
                      ],
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFED6194),
                          Color(0xFFFFA96A)
                        ],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(1.0, 0.0),
                        end: AlignmentDirectional(-1.0, 0),
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiary,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primaryBackground,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  valueOrDefault<String>(
                                    vendor.imageSlide1,
                                    'https://example.com/default_image.jpg',
                                  ),
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vendor.vendorName,
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context).info,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                    child: Text(
                                      vendor.place,
                                      style: FlutterFlowTheme.of(context).labelSmall.override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context).accent4,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 4.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
