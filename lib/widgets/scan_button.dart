import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatefulWidget {
  const ScanButton({super.key});

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0.0,
      onPressed: (() async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'cancelar', false, ScanMode.QR);
        // const barcodeScanRes = "geo:-6.789016,-79.848893";
        // const barcodeScanRes = "https:/google.com";

        if (barcodeScanRes == '-1') {
          return;
        }
        if (!mounted) return;
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
        if (!mounted) return;
        launchUrlFunc(context, nuevoScan);
      }),
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
