import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;
  LocationInput(this.onSelectPosition);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
    final locData = await Location().getLocation();

    _showPreview(locData.latitude!, locData.longitude!);
    widget.onSelectPosition(locData.latitude!, locData.longitude!);
    } catch (e) {
      return;
    }

  }

  Future<void> _selectOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(),),
    );
    
    if (selectedPosition == null) return;

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);
    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child:
          _previewImageUrl == null
              ? Text('Localização não informada!')
              : Image.network(
            _previewImageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Localização Atual'),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Theme
                      .of(context)
                      .primaryColor,
                  backgroundColor: Colors.white
              ),
            ),
            ElevatedButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Selecione no Mapa'),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Theme
                      .of(context)
                      .primaryColor,
                  backgroundColor: Colors.white
              ),
            ),
          ],
        ),
      ],
    );
  }
}
