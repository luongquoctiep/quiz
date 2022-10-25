import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  var logger = Logger();

  Future<bool> isExist(String fileName) async {
    var dir = await getApplicationDocumentsDirectory();
    String savePath = '${dir.path}/$fileName';
    return await File(savePath).exists();
  }

  Future<String> read(String fileName) async {
    String text = "";
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName}');
      text = await file.readAsString();
    } catch (e) {
      logger.d("Couldn't read file");
    }
    return text;
  }

  write(String fileName, String text) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(text, flush: true);
  }
}
