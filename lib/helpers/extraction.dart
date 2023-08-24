import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:unrar_file/unrar_file.dart';

class ExtHelper {
  Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> copyArchive(name) async {
    print("Copy Archive File");
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, name);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      print("File create failed: $e");
    }

    ByteData data = await rootBundle.load(join("assets", name));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(path).writeAsBytes(bytes, flush: true);
    print("Copy Complete");
  }

  /*
  Future<void> extractRar() async {
    print("Extracting Rar");
    const name = "clients.rar";
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, name);

    // Check Archive Exists
    bool exist = await File(path).exists();

    if (!exist) {
      await copyArchive(name);
    }

    // Extraction
    try {
      await UnrarFile.extract_rar(path, dbPath);
    } catch (e) {
      print("Extract Rar failed: $e");
    }

    // Delete Archive
    await deleteFile(path);
    print("Extracting Rar Complete");
  }
  */
  Future<void> extractZip() async {
    print("Extracting Zip");
    const String name = "clients.zip";
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, name);
    //final out = join(dbPath, 'clients.db');

    // Check Archive Exists
    bool exist = await File(path).exists();

    if (!exist) {
      await copyArchive(name);
    }

    // Extraction
    // flutter_archive.dart
    final zipFile = File(path);
    final destinationDir = Directory(dbPath);
    try {
      await ZipFile.extractToDirectory(
          zipFile: zipFile,
          destinationDir: destinationDir,
          onExtracting: (zipEntry, progress) {
            print('progress: ${progress.toStringAsFixed(1)}%');
            print('name: ${zipEntry.name}');
            print('isDirectory: ${zipEntry.isDirectory}');
            print(
                'modificationDate: ${zipEntry.modificationDate?.toLocal().toIso8601String()}');
            print('uncompressedSize: ${zipEntry.uncompressedSize}');
            print('compressedSize: ${zipEntry.compressedSize}');
            print('compressionMethod: ${zipEntry.compressionMethod}');
            print('crc: ${zipEntry.crc}');
            return ZipFileOperation.includeItem;
          });
    } catch (e) {
      print("Extract Zip failed: $e");
    }
    // archive.dart
    /*
    try {
      final inputStream = InputFileStream(path);
      final archive = ZipDecoder().decodeBuffer(inputStream);
      for (var file in archive.files) {
        if (file.isFile) {
          final outputStream = OutputFileStream(out);
          file.writeContent(outputStream);
          outputStream.close();
        }
      }
    } catch (e) {
      print("Extract Zip failed: $e");
    }
    */
    // Delete Archive
    print("Extracting Zip Complete");

    await deleteFile(path);
    print("Unnecessary Zip Deleted");
  }
}
