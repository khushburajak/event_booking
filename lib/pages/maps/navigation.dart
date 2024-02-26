import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  GoogleMapController? _mapController;
  Set<Marker> markers = {};
  LatLng myLocation = const LatLng(27.7047139, 85.3294421);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map in Flutter'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: GoogleMap(
        zoomControlsEnabled: true,
        initialCameraPosition: const CameraPosition(
          target: LatLng(27.7047139, 85.3294421),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId(const LatLng(27.7047139, 85.3294421).toString()),
            position: const LatLng(27.7047139, 85.3294421),
            infoWindow: const InfoWindow(
              title: 'Our Event Location',
              snippet: 'Evento.com',
            ),
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
      ),
    );
  }
}
