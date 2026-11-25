import 'dart:convert';

ScanModel scanModelFromMap(String str) => ScanModel.fromMap(json.decode(str));

String scanModelToMap(ScanModel data) => json.encode(data.toMap());

class ScanModel {
    final int? id;
    String? tipus;
    final String valor;

    ScanModel({
        this.id,
        this.tipus,
        required this.valor,
    }){
      if(this.valor.contains('http')){
        this.tipus = 'http';
      }else{
        this.tipus = 'geo';
      }
    }

    factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipus: json["tipus"],
        valor: json["valor"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "tipus": tipus,
        "valor": valor,
    };
}