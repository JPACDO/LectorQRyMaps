import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:qr_reader/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLLng(),
      zoom: 17.5,
      tilt: 50,
    );

    //MArcadores
    Set<Marker> markers = <Marker>{};

    markers.add(Marker(
        markerId: const MarkerId('geo-loation'), position: scan.getLatLLng()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('MAPA'),
        actions: [
          IconButton(
              onPressed: (() async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: scan.getLatLLng(),
                  zoom: 17.5,
                  tilt: 50,
                )));
              }),
              icon: const Icon(Icons.my_location_outlined))
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          setState(() {
            mapType =
                mapType == MapType.normal ? MapType.satellite : MapType.normal;
          });
        }),
        child: const Icon(Icons.layers),
      ),
    );
  }
}
