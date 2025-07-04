import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:work_order_app/core/consts_and_enums/enums/work_order_enums.dart';
import 'package:work_order_app/core/injection/injection.dart';
import 'package:work_order_app/core/params/params.dart';
import 'package:work_order_app/features/technician/domain/use_cases/get_all_technicians.dart';
import 'package:work_order_app/features/technician/presentation/bloc/technician_bloc.dart';
import 'package:work_order_app/features/work_order/domain/entities/work_order_entity.dart';
import 'package:work_order_app/features/work_order/presentation/bloc/work_order_bloc.dart';
import 'package:work_order_app/widgets/appbar/custom_app_bar.dart';

import '../../../../core/themes/text_styles.dart';
import '../../../../core/utils/string_helpers.dart';
import '../../../../widgets/text/title_text.dart';
import '../../../technician/domain/entity/technician_entity.dart';

@RoutePage()
class WorkOrderDetailScreen extends StatefulWidget implements AutoRouteWrapper {
  const WorkOrderDetailScreen({required this.workOrder, super.key});
  final WorkOrderEntity workOrder;
  @override
  State<WorkOrderDetailScreen> createState() => _WorkOrderDetailScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _WorkOrderDetailScreenState extends State<WorkOrderDetailScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int _markerIdCounter = 1;
  MarkerId? selectedMarker;
  LatLng? markerPosition;
  @override
  void initState() {
    super.initState();
    _addOrMoveMarkerAtCoordinate(widget.workOrder.latitude ?? 0, widget.workOrder.longitude ?? 0);
    _currentLocation(widget.workOrder.latitude ?? 0, widget.workOrder.longitude ?? 0);
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

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(bearing: 0, target: LatLng(latitude, longitude), zoom: 17.0),
      ),
    );
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
        longitude,
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
              _section(
                "Location Map",
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
                  SizedBox(height: 16),
                ],
              ),
              _section(
                "Details",
                children: [
                  _detailRow((
                    title: Text("Work Order ID", style: MyTextStyles.textGreyDetail),
                    content: Text("WO-2023-0452"),
                  )),
                  _detailRow((
                    title: Text("Status", style: MyTextStyles.textGreyDetail),
                    content: Text(
                      WorkOrderStatus.values
                          .firstWhere((el) => el.value == widget.workOrder.status)
                          .string,
                    ),
                  )),
                  BlocProvider.value(
                    value: getIt<TechnicianBloc>()..add(LoadTechniciansEvent()),
                    // value: getIt<TechnicianBloc>()..add(GetTechnicianEvent(QueryIdParams(id: widget.workOrder.id))),
  child: BlocBuilder<TechnicianBloc, TechnicianState>(
                    builder: (context, state) {
                      var technicianList = state.whenOrNull(loaded: (l) => l) ?? [];
                      var technician = technicianList.firstWhere((t) => t.id == widget.workOrder.technicianId, orElse: ()=>TechnicianEntity(id: 0, name: "Technician Not Found"));
                      return _detailRow((
                        // FIXME, ini perbaiki gimana bagusnya
                        title: Text("Assigned To", style: MyTextStyles.textGreyDetail),
                        content: Text(technician?.name ?? "-"),
                        // content: Text(widget.workOrder.technicianId.toString()),
                      ));
                    },
                  ),
),
                  _detailRow((
                    title: Text("Created", style: MyTextStyles.textGreyDetail),
                    // content: Text("Today, 8:15 AM"),
                    content: Text(
                      formatDateTime(
                        DateFormat('yy-MM-dd HH:mm').parse(widget.workOrder.createdAt),
                      ),
                    ),
                  )),
                  _detailRow((
                    title: Text("Scheduled", style: MyTextStyles.textGreyDetail),
                    content: Text(
                      formatDateTime(
                        DateFormat('yy-MM-dd HH:mm').parse(widget.workOrder.scheduledStart),
                      ),
                    ),
                  )),
                  _detailRow((
                    title: Text("Location", style: MyTextStyles.textGreyDetail),
                    content: Text(widget.workOrder.location),
                  )),
                  _detailRow((
                    title: Text("Address", style: MyTextStyles.textGreyDetail),
                    content: Text(widget.workOrder.address),
                  )),
                ],
              ),
              _section("Description", children: [Text(widget.workOrder.description)]),
              _section(
                "Customer",
                children: [
                  _detailRow((
                    title: Text("Name", style: MyTextStyles.textGreyDetail),
                    content: Text("Sarah Johnson (Facilities)"),
                  )),
                  _detailRow((
                    title: Text("Phone", style: MyTextStyles.textGreyDetail),
                    content: Text("(555) 123-4567"),
                  )),
                  _detailRow((
                    title: Text("Email", style: MyTextStyles.textGreyDetail),
                    content: Text("s.johnson@company.com"),
                  )),
                ],
              ),
              _section(
                "Required Materials",
                children: [
                  Text(widget.workOrder.materials),
                  // Text("- PVC Pipes (1.5\")"),
                  // Text("- Pipe cutter"),
                  // Text("- Pipe wrench set"),
                  // Text("- Teflon tape"),
                  // Text("- Joint compound"),
                ],
              ),
              _section(
                "Attachments",
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.lightBlue[200],
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.camera_alt, size: 64),
                      ),
                      SizedBox(width: 16),
                      Container(
                        color: Colors.lightBlue[200],
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.book, size: 64),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _section(String title, {List<Widget>? children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [TitleText(title), Divider(), ...?children, SizedBox(height: 16)],
    );
  }

  _detailRow(({Widget title, Widget content}) widgetPair) {
    return Row(
      children: [
        Expanded(child: widgetPair.title),
        Expanded(flex: 2, child: widgetPair.content),
      ],
    );
  }
}
