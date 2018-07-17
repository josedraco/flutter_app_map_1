import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

var api_key = "AIzaSyCDARQVpwfBOPpqWMhxQS6K-2TG68992V4";
void main() {
  MapView.setApiKey(api_key);
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MapPage(),
  ));
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapView mapView = new MapView();
  CameraPosition cameraPosition;
  var staticMapProvider = new StaticMapProvider(api_key);
  Uri staticMapUri;

  List<Marker> markers = <Marker>[
    new Marker("1", "Palacio de Valdecarzana", 43.556369, -5.921637, color: Colors.amber),
    new Marker("2", "Palacio de Ferrera", 43.5553927, -5.9226939, color: Colors.purple),
    new Marker("3", "Palacio de Balsera", 43.555030, -5.924086, color: Colors.blue),
  ];

  showMap() {
    mapView.show(new MapOptions(
        mapViewType: MapViewType.normal,
        initialCameraPosition:
        new CameraPosition(new Location(43.5553927, -5.9226939), 15.0),
        showUserLocation: true,
        title: "Recent Location"));
   // mapView.setMarkers(markers);
    mapView.zoomToFit(padding: 100);
    mapView.setMarkers(markers);
    mapView.onMapTapped.listen((_) {
      setState(() {
        mapView.setMarkers(markers);
        mapView.zoomToFit(padding: 100);
      });
    });
  }

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    cameraPosition =
    new CameraPosition(new Location(43.5553927, -5.9226939), 2.0);
    staticMapUri = staticMapProvider.getStaticUri(
        new Location(43.5553927, -5.9226939), 15, mapType: StaticMapViewType.roadmap);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Flutter Google maps"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            //height: 300.0,
            child: new Stack(
              children: <Widget>[
                showMap(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}