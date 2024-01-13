import 'package:flutter/services.dart';
import 'package:hackathon_app/app.dart';
import 'package:hackathon_app/bootstrap.dart';
import 'package:hackathon_app/repositories/di.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
  await setup();
  await bootstrap(() => const App());
}
