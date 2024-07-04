import 'package:flutter/material.dart';

import '../controllers/mrz_controller.dart';
import '../helpers/mrz_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final MRZController controller = MRZController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return MRZScanner(
          controller: controller,
          onSuccess: (mrzResult, lines) async {
            ///[lines] is a list of String that contains the scanned MRZ (separated by \n)
            final mrzText = lines.join('\n');
            await showDialog(
              context: context,
              builder: (context) => Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          controller.currentState?.resetScanning();
                        },
                        child: const Text('Tap to Reset Scanning'),
                      ),
                      //Parsed MRZ data
                      Text('Name : ${mrzResult.givenNames}'),
                      Text('Gender : ${mrzResult.sex.name}'),
                      Text('CountryCode : ${mrzResult.countryCode}'),
                      Text('Date of Birth : ${mrzResult.birthDate}'),
                      Text('Expiry Date : ${mrzResult.expiryDate}'),
                      Text('DocNum : ${mrzResult.documentNumber}'),

                      //RAW MRZ data
                      Text('MRZ : $mrzText'),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
