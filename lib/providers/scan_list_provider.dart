import 'package:flutter/widgets.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scans = []; 
  String tipusSeleccionat = 'http'; 

  Future<ScanModel> nouScan(String valor) async{
    final nouScan = ScanModel(valor: valor);
    final id = await DbProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if(nouScan.tipus == tipusSeleccionat){
      this.scans.add(nouScan); 
      notifyListeners(); 
    }
    return nouScan; 
  }

  carregarScans() async {
    final scans = await DbProvider.db.getAllScans(); 
    this.scans = [...scans]; 
    notifyListeners(); 
  }

  carregarScansPerTipus(String tipus) async {
    final scans = await DbProvider.db.getScanPerTipus(tipus); 
    this.scans = [...scans];
    notifyListeners(); 
  }

  esborrarTots() async{
    final scans = await DbProvider.db.deleteAllScans(); 
    this.scans = [];
    notifyListeners();    
  }

  esborrarPerId(int id) async {
    await DbProvider.db.deleteScan(id); 
    this.carregarScansPerTipus(this.tipusSeleccionat);
    notifyListeners();
  }
}