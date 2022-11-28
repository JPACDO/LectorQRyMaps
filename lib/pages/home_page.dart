import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            onPressed: (() {
              final scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false);
              scanListProvider.borrarTodo();
            }),
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    //Obtener el selectedmenu opt
    final uiProvider = Provider.of<UIProvider>(context);

    //Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //Usar el ScanListProvider
    final scanLsitProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanLsitProvider.cargarScanPorTipo('geo');
        return const MapasPage(); //o const ScanTiles( tipo: 'geo', );

      case 1:
        scanLsitProvider.cargarScanPorTipo('http');
        return const DireccionesPage();


      default:
        return const MapasPage();
    }
  }
}
