import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

// Rasterizes the existing SVG without changing the brand geometry.
void main() {
  testWidgets('generate platform icons from the original Canguruu SVG', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(512, 512);
    tester.view.devicePixelRatio = 1;
    final key = GlobalKey();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: RepaintBoundary(
          key: key,
          child: Container(
            color: const Color(0xFFF5F4EE),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/brand/canguruu.svg',
              width: 430,
              height: 350,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    Future<Uint8List> png(int size) async {
      final image = await boundary.toImage(pixelRatio: size / 512);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      return data!.buffer.asUint8List();
    }

    final outputs = {
      'web/icons/Icon-192.png': 192,
      'web/icons/Icon-512.png': 512,
      'web/icons/Icon-maskable-192.png': 192,
      'web/icons/Icon-maskable-512.png': 512,
      'web/favicon.png': 32,
      'android/app/src/main/res/mipmap-mdpi/ic_launcher.png': 48,
      'android/app/src/main/res/mipmap-hdpi/ic_launcher.png': 72,
      'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png': 96,
      'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png': 144,
      'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png': 192,
    };
    await tester.runAsync(() async {
      for (final item in outputs.entries) {
        await File(item.key).writeAsBytes(await png(item.value));
      }
      final icon = await png(256);
      final header = ByteData(22)
        ..setUint16(2, 1, Endian.little)
        ..setUint16(4, 1, Endian.little)
        ..setUint16(10, 1, Endian.little)
        ..setUint16(12, 32, Endian.little)
        ..setUint32(14, icon.length, Endian.little)
        ..setUint32(18, 22, Endian.little);
      await File(
        'windows/runner/resources/app_icon.ico',
      ).writeAsBytes([...header.buffer.asUint8List(), ...icon]);
    });
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
