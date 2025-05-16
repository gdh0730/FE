import 'package:flutter_sound/flutter_sound.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

final recorder = FlutterSoundRecorder();
await recorder.openRecorder();
await recorder.startRecorder(toFile: 'record.aac');

// 👉 사용자가 버튼을 눌러 녹음 종료할 때
final path = await recorder.stopRecorder();
final file = File(path!);

final ref = FirebaseStorage.instance
    .ref('users/$uid/audio/${DateTime.now().millisecondsSinceEpoch}.aac');

await ref.putFile(file);
