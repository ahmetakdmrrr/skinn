import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

class ModelService {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    try {
      final modelFile = await rootBundle.load('assets/models/model.tflite');
      final modelData = modelFile.buffer.asUint8List();
      _interpreter = Interpreter.fromBuffer(modelData);
      print('Model başarıyla yüklendi.');
    } catch (e) {
      print('Model yüklenirken hata oluştu: $e');
      rethrow; // Hata varsa dışarı fırlat
    }
  }

  Future<Uint8List?> pickAndProcessImageFromFile(String path) async {
    final file = File(path);
    final image = img.decodeImage(file.readAsBytesSync())!;
    final resizedImage = img.copyResize(image, width: 224, height: 224);
    return _preprocessImage(resizedImage);
  }

  Uint8List _preprocessImage(img.Image image) {
    final input = Float32List(1 * 224 * 224 * 3);
    int pixelIndex = 0;
    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        final pixel = image.getPixel(x, y);
        input[pixelIndex++] = pixel.r / 255.0;
        input[pixelIndex++] = pixel.g / 255.0;
        input[pixelIndex++] = pixel.b / 255.0;
      }
    }
    return input.buffer.asUint8List();
  }

  Future<List<double>?> runModel(Uint8List inputImage) async {
    try {
      var input = inputImage.buffer.asFloat32List().reshape([1, 224, 224, 3]);
      var output = List<double>.filled(5, 0).reshape([1, 5]);
      _interpreter.run(input, output);
      print('Tahmin sonucu: ${output[0]}');
      return output[0];
    } catch (e) {
      print('Model çalıştırılırken hata oluştu: $e');
      return null;
    }
  }

  void dispose() {
    _interpreter.close();
  }
}