// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// FlutterFlow imports
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

Future<String> detectTextFromImage(String imageUrl) async {
  try {
    // Validate the image URL
    if (imageUrl.isEmpty) {
      return 'Error: Image URL is empty or null.';
    }

    print("Starting text detection...");

    // Step 1: Download the image
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to download image');
    }
    print("Image downloaded successfully.");

    // Step 2: Save the image locally
    final tempDir = Directory.systemTemp;
    final filePath = '${tempDir.path}/temp_image.jpg';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    print("Image saved locally at: $filePath");

    // Step 3: Use ML Kit to recognize text
    final inputImage = InputImage.fromFile(file);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    print("Text detection completed.");

    // Step 4: Clean up and return the result
    textRecognizer.close();
    return recognizedText.text;
  } catch (e) {
    print("Error during text detection: ${e.toString()}");
    return 'Error: ${e.toString()}';
  }
}
