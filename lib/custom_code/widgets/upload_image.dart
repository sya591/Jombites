// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadImage extends StatefulWidget {
  final double width;
  final double height;

  const UploadImage({
    Key? key,
    this.width = 300,
    this.height = 400,
  }) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _selectedImage;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      await _processImage();
    }
  }

  Future<void> _processImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Initialize the text recognizer
      final textRecognizer = GoogleMlKit.vision.textRecognizer();

      // Create an InputImage from the selected file
      final inputImage = InputImage.fromFile(_selectedImage!);

      // Process the image to extract text
      final recognizedText = await textRecognizer.processImage(inputImage);

      // Extract recognized text
      final extractedText = recognizedText.text.toLowerCase();

      print("Extracted Text: $extractedText");

      // Query Firestore for matching vendors
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Vendor')
          .where('VendorName', isGreaterThanOrEqualTo: extractedText)
          .where('VendorName', isLessThanOrEqualTo: extractedText + '\uf8ff')
          .get();

      // Extract matching vendor data
      final vendors = querySnapshot.docs.map((doc) => doc.data()).toList();

      print("Matching Vendors: $vendors");

      // Navigate to the search page with vendor data
      if (vendors.isNotEmpty) {
        // Check if the page exists before navigation
        Navigator.of(context).pushNamed(
          'SearchPage', // Replace with your route name
          arguments: vendors, // Passing vendor data as arguments

        );
      } else {
        print("No matching vendors found.");

        // Show an error message if no vendors match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No matching vendors found. Please try again.')),
        );
      }


      textRecognizer.close();
    } catch (e) {
      print("Error processing image: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Upload Image'),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          if (_selectedImage != null && !_isLoading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.file(_selectedImage!, height: widget.height / 2),
            ),
        ],
      ),
    );
  }
}
