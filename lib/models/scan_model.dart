// import 'package:meta/meta.dart'; ///se uda para importar @required esto importa metadatos

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
  ScanModel({
    this.id,
    this.tipo,
    required this.valor,
  }) {
    if (valor.contains('http')) {
      tipo = 'http';
    } else {
      tipo = 'geo';
    }
  }

  int? id;
  String? tipo;
  late String valor;

  LatLng getLatLLng() {
    final separar = valor.split('?');
    final latlng = separar[0].substring(4).split(',');
    final lat = double.parse(latlng[0]);
    final lng = double.parse(latlng[1]);

    return LatLng(lat, lng);
  }

  ScanModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    tipo = json['tipo'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['tipo'] = tipo;
    data['valor'] = valor;
    return data;

    //   var map = <String, dynamic>{
    //   tipo!: tipo,
    //   valor: valor
    // };
    // if (id != null) {
    //   map['id'] = id;
    // }
    // return map;
    //   }
  }

  vacio() {
    return;
  }
}
