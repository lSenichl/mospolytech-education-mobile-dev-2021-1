import 'package:file_encrypter/file_encrypter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

String key;

class Lab06 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Шифрование по методу: "AES-256 in CBC mode with PKCS5 padding"'),
            ElevatedButton.icon(
              onPressed: () async {
                final params = OpenFileDialogParams();
                final filePath =
                    await FlutterFileDialog.pickFile(params: params);
                print(filePath);

                key = await FileEncrypter.encrypt(
                  inFilename: filePath,
                  outFileName: '/storage/emulated/0/Download/encrypted.dat',
                );
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
                await FileEncrypter.decrypt(
                  key: key,
                  inFilename: filePath,
                  outFileName: '/storage/emulated/0/Download/decrypted.txt',
                );
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
