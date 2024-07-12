import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

const token =
    'sk.eyJ1IjoiYXJ0cml2YXMiLCJhIjoiY2x3bGZtbnVsMGdsczJrcGgwYTl0azBsZiJ9.xiglLuMeeAkfcGwAEWSbiw';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LatLng myPosition = const LatLng(-12.135651, -77.022166);
  final mapController = MapController();
  List<Marker> markers = [];

  void __loadCSV() async {
    final rawData = await rootBundle.loadString("assets/data/Robos_de_hurtos.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    List<Marker> loadedMarkers = [];
    loadedMarkers.add(Marker(
        point: myPosition,
        child: const Icon(
          Icons.person_pin,
          color: Colors.blueAccent,
          size: 40,
        )));
    loadedMarkers.addAll(listData.map((data) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(
            data[1], data[0]), // Assuming the order is latitude, longitude
        child: const Icon(
          Icons.close_outlined,
          color: Colors.red,
          size: 40,
        ),
      );
    }).toList());

    setState(() {
      markers = loadedMarkers;
    });
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Nice to have, Deberia funcionar sin la ubicacion actual
        return Future.error('No se concedio el permiso');
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      // Recreate the first marker with the updated position
      Marker updatedUserMarker = Marker(
        point: myPosition,
        child: const Icon(
          Icons.person_pin,
          color: Colors.blueAccent,
          size: 40,
        ),
      );

      // Replace the old user marker with the updated one
      markers = [updatedUserMarker] + markers.skip(1).toList();
    });
    mapController.move(myPosition, 18.0);
  }

  @override
  void initState() {
    __loadCSV();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: const Text('Vista del mapa'),
      //),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
            initialCenter: myPosition,
            minZoom: 5,
            maxZoom: 25,
            initialZoom: 18),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: const {
              'accessToken': token,
              'id': 'mapbox/streets-v12'
            },
          ),
          MarkerLayer(
            markers: markers,
            /*
            markers: [
              Marker(
                  point: myPosition,
                  child: const Icon(
                    Icons.person_pin,
                    color: Colors.blueAccent,
                    size: 40,
                  ))
            ],*/
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocation();
        },
        child: const Icon(Icons.my_location),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
