import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:accounting_app/app/networks/dio_client.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  // Singleton instance
  static final FileManager _instance = FileManager._internal();

  // DioClient instance
  DioClient _dioClient;

  // Factory constructor to return the singleton instance
  factory FileManager({DioClient? dioClient}) {
    _instance._dioClient = dioClient ?? DioClient();
    return _instance;
  }

  // Private constructor
  FileManager._internal() : _dioClient = DioClient();

  // Gets the app's documents directory
  Future<String> _getAppDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Generates the file path for the given filename, ensuring .json extension
  String _getFilePath(String appDir, String fileName) {
    final baseName = fileName.split('/').last;
    final jsonName = baseName.endsWith('.json') ? baseName : '$baseName.json';
    return '$appDir/$jsonName';
  }

  // Checks if the file exists in the app's directory
  Future<bool> doesFileExist(String fileUrl) async {
    try {
      final appDir = await _getAppDirectory();
      final fileName = fileUrl.split('/').last;
      final filePath = _getFilePath(appDir, fileName);
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      debugPrint('Error checking file existence: $e');
      return false;
    }
  }

  // Downloads and saves the file as .json, or returns existing file
  // Downloads and saves the file as .json using DioClient, or returns existing file
  // Downloads and saves the file as .json using DioClient's download, or returns existing file
  Future<File> getFile(String fileUrl) async {
    try {
      final appDir = await _getAppDirectory();
      final fileName = fileUrl.split('/').last;
      final filePath = _getFilePath(appDir, fileName);
      final file = File(filePath);

      // Check if file already exists
      if (await file.exists()) {
        return file;
      }

      // Download the file using DioClient's download method
      await _dioClient.download(fileUrl, filePath);
      return file;
    } catch (e) {
      debugPrint('Error downloading/saving file: $e');
      rethrow;
    }
  }

  // Reads the file and returns its contents as a JSON object
  Future<dynamic> readJsonFile(String fileUrl) async {
    try {
      final file = await getFile(fileUrl);
      final contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      debugPrint('Error reading JSON file: $e');
      rethrow;
    }
  }
}
