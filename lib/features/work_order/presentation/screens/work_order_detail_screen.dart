import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:work_order_app/core/consts_and_enums/enums/work_order_enums.dart';
import 'package:work_order_app/core/injection/injection.dart';
import 'package:work_order_app/features/work_order/domain/entities/work_order_entity.dart';
import 'package:work_order_app/features/work_order/presentation/bloc/work_order_bloc.dart';
import 'package:work_order_app/widgets/appbar/custom_app_bar.dart';

import '../../../../core/themes/text_styles.dart';
import '../../../../widgets/text/title_text.dart';

@RoutePage()
class WorkOrderDetailScreen extends StatefulWidget {
  const WorkOrderDetailScreen({required this.workOrder, super.key});
  final WorkOrderEntity workOrder;
  @override
  State<WorkOrderDetailScreen> createState() => _WorkOrderDetailScreenState();

}

class _WorkOrderDetailScreenState extends State<WorkOrderDetailScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int _markerIdCounter = 1;
  MarkerId? selectedMarker;
  LatLng? markerPosition;

  @override
  void initState() {
    super.initState();
    _addOrMoveMarkerAtCoordinate(widget.workOrder.latitude ?? 0,
        widget.workOrder.longitude ?? 0);
    _currentLocation(widget.workOrder.latitude ?? 0,
        widget.workOrder.longitude ?? 0);
  }

  _currentLocation(double latitude, double longitude) async {
    final GoogleMapController controller = await _controller.future;
    // callbackGetCurrentPosition();
    // LocationData? currentLocation;
    // var location = Location();
    // try {
    //   currentLocation = await location.getLocation();
    // } on Exception {
    //   currentLocation = null;
    // }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(latitude, longitude),
        zoom: 17.0,
      ),
    ));
  }
  _addOrMoveMarkerAtCoordinate(double latitude, double longitude) async {
    final int markerCount = markers.length;

    if (markerCount == 1) {
      _changePosition(selectedMarker!, latitude, longitude);
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      // draggable: true,
      position: LatLng(
          latitude,
          // + sin(_markerIdCounter * pi / 6.0) / 20.0,
          longitude
        // + cos(_markerIdCounter * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
    );

    setState(() {
      selectedMarker = markerId;
      markers[markerId] = marker;
      markerPosition = LatLng(latitude, longitude);
    });
  }

  void _changePosition(MarkerId markerId, double latitude, double longitude) {
    final Marker marker = markers[markerId]!;
    final LatLng current = marker.position;
    // final Offset offset = Offset(
    //   latitude - current.latitude,
    //   longitude - current.longitude,
    // );
    setState(() {
      markers[markerId] = marker.copyWith(
        positionParam: LatLng(
          latitude,
          // + offset.dy,
          longitude,
          // + offset.dx,
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.workOrder.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _section("Location Map",
              children: [
                Container(
                  height: 200,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: markers.values.toSet(),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.workOrder.latitude, widget.workOrder.longitude),
                      zoom: 17,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                SizedBox(height: 16,),

                Text(widget.workOrder.address),
                Text("Lat: ${widget.workOrder.latitude}"),
                Text("Lng: ${widget.workOrder.longitude}"),
              ]),
              _section("Details", children: [
                _detailRow((
                  title: Text("Work Order ID", style: MyTextStyles.textGreyDetail,),
                  content: Text("WO-2023-0452"),
                )),
                _detailRow((
                  title: Text("Status", style: MyTextStyles.textGreyDetail,),
                  content: Text(WorkOrderStatus.values.firstWhere((el) => el.value == widget.workOrder.status).string),
                )),
                _detailRow((
                  // FIXME, ini perbaiki gimana bagusnya
                  title: Text("Assigned To", style: MyTextStyles.textGreyDetail,),
                  content: Text("You"),
                )),
                _detailRow((
                  title: Text("Created", style: MyTextStyles.textGreyDetail,),
                  // content: Text("Today, 8:15 AM"),
                  content: Text("Today, 8:15 AM"),
                )),
                _detailRow((
                  title: Text("Scheduled", style: MyTextStyles.textGreyDetail,),
                  content: Text("Today, 1:30 PM"),
                )),
                _detailRow((
                  title: Text("Location", style: MyTextStyles.textGreyDetail,),
                  content: Text(widget.workOrder.location),
                )),
                _detailRow((
                  title: Text("Address", style: MyTextStyles.textGreyDetail,),
                  content: Text("123 Main St, Suite 300, Anytown, Use"),
                )),
              ]),
              _section("Description",children: [
                Text(widget.workOrder.description),
              ]),
              _section("Customer", children: [
                _detailRow((
                  title: Text("Name", style: MyTextStyles.textGreyDetail,),
                  content: Text("Sarah Johnson (Facilities)"),
                )),
                _detailRow((
                  title: Text("Phone", style: MyTextStyles.textGreyDetail,),
                  content: Text("(555) 123-4567"),
                )),
                _detailRow((
                  title: Text("Email", style: MyTextStyles.textGreyDetail,),
                  content: Text("s.johnson@company.com"),
                )),
              ]),
              _section("Required Materials", children: [
                Text(widget.workOrder.materials),
                // Text("- PVC Pipes (1.5\")"),
                // Text("- Pipe cutter"),
                // Text("- Pipe wrench set"),
                // Text("- Teflon tape"),
                // Text("- Joint compound"),
              ]),
              _section("Attachments", children: [
                Row(
                  children: [
                    Container(
                        color: Colors.lightBlue[200],
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.camera_alt, size: 64,)),
                    SizedBox(width: 16,),
                    Container(
                        color: Colors.lightBlue[200],
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.book, size: 64,)),
                  ],
                ),
              ]),
          ],),
        ),
      ),
    );
  }

  _section(String title, {List<Widget>? children}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      TitleText(title),
      Divider(),
      ...?children,
      SizedBox(height: 16,)
    ],);
  }

  _detailRow(({Widget title, Widget content}) widgetPair){
    return Row(
      children: [
        Expanded(child: widgetPair.title),
        Expanded(
            flex: 2,
            child: widgetPair.content),
      ],
    );
  }
}
