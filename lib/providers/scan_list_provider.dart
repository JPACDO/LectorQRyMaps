import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String tipoSelleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id = id;

    if (tipoSelleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  cargaScans() async {
    final scans = await DBProvider.db.getTodosLosScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScanPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans];
    tipoSelleccionado = tipo;
    notifyListeners();
  }

  borrarTodo() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    // cargarScanPorTipo(tipoSelleccionado);
  }
}
