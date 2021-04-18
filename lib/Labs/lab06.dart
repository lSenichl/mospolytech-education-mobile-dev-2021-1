import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'dart:io';
import 'package:aes_crypt/aes_crypt.dart';

class Lab06 extends StatefulWidget {
  @override
  Lab06State createState() => Lab06State();
}

String encFilepath;
String decFilepath;
String srcFilepath;

class Lab06State extends State<Lab06> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Введите пароль для шифрования: ')),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: myController,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final params = OpenFileDialogParams();
                final filePath =
                    await FlutterFileDialog.pickFile(params: params);
                print(filePath);

                srcFilepath = filePath;

                print('Unencrypted source file: $srcFilepath');
                print('File content: ' +
                    File(srcFilepath).readAsStringSync() +
                    '\n');

                var crypt = AesCrypt();

                crypt.setPassword(myController.text);
                crypt.setOverwriteMode(AesCryptOwMode.warn);

                try {
                  encFilepath = crypt.encryptFileSync(srcFilepath,
                      '/storage/emulated/0/Download/testfile_encrypted.aes');
                  print('The encryption has been completed successfully.');
                  print('Encrypted file: $encFilepath');
                } on AesCryptException catch (e) {
                  if (e.type == AesCryptExceptionType.destFileExists) {
                    print('The encryption has been completed unsuccessfully.');
                    print(e.message);
                  }
                  return;
                }
                print('Encryption Ended');
              },
              icon: Icon(Icons.cloud_download),
              label: Text('Encrypt File'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final params = OpenFileDialogParams();
                final filePath =
                    await FlutterFileDialog.pickFile(params: params);
                print(filePath);

                var crypt = AesCrypt();

                crypt.setPassword(myController.text);
                crypt.setOverwriteMode(AesCryptOwMode.warn);

                try {
                  // Decrypts the file which has been just encrypted and tries to save it under
                  // another name than source file name.
                  decFilepath = crypt.decryptFileSync(filePath,
                      '/storage/emulated/0/Download/testfile_new.txt');
                  print('The decryption has been completed successfully.');
                  print('Decrypted file 2: $decFilepath');
                  print(
                      'File content: ' + File(decFilepath).readAsStringSync());
                } on AesCryptException catch (e) {
                  if (e.type == AesCryptExceptionType.destFileExists) {
                    print('The decryption has been completed unsuccessfully.');
                    print(e.message);
                  }
                }
                print('Decryption Ended');
              },
              icon: Icon(Icons.cloud_download),
              label: Text('Decrypt File'),
            ),
          ],
        ),
      ),
    );
  }
}
