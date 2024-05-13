import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:airpollution/models/entities/location_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:airpollution/models/enums/aqi_level.dart';

class MapWidget extends StatefulWidget {
  final CameraPosition? initialCameraPosition;
  final List<LocationEntity>? locations;
  final Function? onTapMarker;
  final Function? onTapBackgroundMap;
  final MapCreatedCallback? onMapCreated;

  const MapWidget({
    super.key,
    this.initialCameraPosition,
    this.locations,
    this.onTapMarker,
    this.onTapBackgroundMap,
    this.onMapCreated,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    final locations = widget.locations ?? [];
    for (int i = 0; i < locations.length; i++) {
      final String markerIdVal = '$i';
      final MarkerId markerId = MarkerId(markerIdVal);

      final circleColor = locations[i].getAqiLevel.getInfo.backgroundColor;

      final icon = await _createMarkerIcon(
        airQuality: "${locations[i].airQuality ?? 0}",
        backgroundColor: circleColor,
      );
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          locations[i].lat ?? 0.0,
          locations[i].long ?? 0.0,
        ),
        infoWindow: InfoWindow(
          title: locations[i].addressName,
        ),
        icon: BitmapDescriptor.fromBytes(icon),
        onTap: () => _onMarkerTapped(markerId),
      );

      setState(() {
        markers[markerId] = marker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: widget.initialCameraPosition ??
          const CameraPosition(
            target: LatLng(
              21.0278,
              105.8342,
            ),
            zoom: 11,
          ),
      onTap: (location) {
        widget.onTapBackgroundMap?.call();
      },
      onMapCreated: (GoogleMapController controller) {
        widget.onMapCreated?.call(controller);
      },
      onCameraMove: (position) {},
      onCameraIdle: () {},
      markers: Set<Marker>.of(markers.values),
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
          Factory<EagerGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        ),
    );
  }

  void _onMarkerTapped(MarkerId markerId) {
    debugPrint("$markerId");
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      int index = int.parse(markerId.value);
      widget.onTapMarker?.call(index);
    }
  }

  Future<Uint8List> _createMarkerIcon({
    required String airQuality,
    Color backgroundColor = Colors.blue,
  }) async {
    double radius = 40.0;
    double arrowWidth = 30.0;
    double arrowHeight = 15.0;
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    Canvas canvas = Canvas(pictureRecorder);
    Paint backgroundPaint = Paint()..color = backgroundColor;

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final Paint arrowFillPaint = Paint()..color = backgroundColor;
    final Paint arrowBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(Offset(radius, radius), radius, backgroundPaint);
    canvas.drawCircle(Offset(radius, radius), radius, borderPaint);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: airQuality,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final double textWidth = textPainter.width;
    final double textHeight = textPainter.height;
    textPainter.paint(
      canvas,
      Offset(radius - textWidth / 2, radius - textHeight / 2),
    );

    final Path path = Path()
      ..moveTo(radius - arrowWidth / 2, 2 * radius)
      ..lineTo(radius, 2 * radius + arrowHeight)
      ..lineTo(radius + arrowWidth / 2, 2 * radius)
      ..close();
    canvas.drawPath(path, arrowFillPaint);
    canvas.drawPath(path, arrowBorderPaint);

    final ui.Picture picture = pictureRecorder.endRecording();
    final ui.Image image = await picture.toImage(
      (radius * 2).toInt(),
      (radius * 2 + arrowHeight).toInt(),
    );

    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return byteData!.buffer.asUint8List();
  }
}
