import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ImageUtils {
  static Future<File> optimizeImage(File imageFile) async {
    // Resim boyutunu optimize et
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) return imageFile;

    // Maksimum boyut 1024x1024
    final resized = img.copyResize(
      image,
      width: 1024,
      height: 1024,
      maintainAspect: true,
    );

    // Optimize edilmiş resmi kaydet
    final optimized = File(imageFile.path.replaceAll('.jpg', '_optimized.jpg'))
      ..writeAsBytesSync(img.encodeJpg(resized, quality: 85));

    return optimized;
  }
}
