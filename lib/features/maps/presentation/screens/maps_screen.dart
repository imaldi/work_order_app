import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';

import '../../../../core/consts_and_enums/consts/google_maps_keys.dart';
import '../../../../core/injection/injection.dart';
import '../state_management/location_cubit.dart';

@RoutePage()
class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  TextEditingController searchController = TextEditingController();

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  final TextEditingController _searchController = TextEditingController();

  // GoogleMapController? _controller;

  // =
  // GoogleMapController();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int _markerIdCounter = 1;
  MarkerId? selectedMarker;
  LatLng? markerPosition;

  @override
  initState() {
    super.initState();

    var stateParam = getIt<LocationCubit>().state.param;
    // if (stateParam.latitude != null && stateParam.longitude != null) {
      _addOrMoveMarkerAtCoordinate(stateParam.latitude ?? 0,
          stateParam.longitude ?? 0);
    // }
  }

  Future<void> _onMarkerDrag(MarkerId markerId, LatLng newPosition) async {
    setState(() {
      markerPosition = newPosition;
    });
  }

  Future<void> _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      // setState(() {
      //   markerPosition = null;
      // });
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                      ],
                    )));
          });
    }
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
      // onTap: () => _onMarkerTapped(markerId),
      onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    setState(() {
      selectedMarker = markerId;
      markers[markerId] = marker;
      markerPosition = LatLng(latitude, longitude);
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider.value(
      value: getIt<LocationCubit>(),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        // appBar: _buildAppBar(context),
        body: BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            state.maybeMap(orElse: () {
              EasyLoading.dismiss();
            },
                // success: (s){
                // },
                loading: (s) {
              EasyLoading.show(status: "Loading Address", dismissOnTap: true);
            }, success: (s) async {
              EasyLoading.dismiss();
              // final GoogleMapController controller = await _controller.future;
              _currentLocation(s.param.latitude, s.param.longitude);
              _addOrMoveMarkerAtCoordinate(s.param.latitude, s.param.longitude);
            }, initial: (s) {
              EasyLoading.dismiss();
            }, failure: (s) {
              EasyLoading.dismiss();
            }, successSelectLocation: (s) {
              EasyLoading.dismiss();
              _addOrMoveMarkerAtCoordinate(
                  s.param.latitude, s.param.longitude);

              _currentLocation(s.param.latitude, s.param.longitude);


              Fluttertoast.showToast(
                  msg: "Lokasi terpilih: ${s.param.currentAddress ?? s.param.simpleName}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.lightBlue,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
          },
          builder: (context, state) {
            var stateParam = state.param;
            googleMapWidget(LocationParam param) {
              return Stack(
                children: [

                  PlacePicker(
                    // apiKey: Platform.isAndroid
                    //     ? 'GOOGLE_MAPS_API_KEY_ANDROID'
                    //     : 'GOOGLE_MAPS_API_KEY_IOS',
                    googleAPIParameters: GoogleAPIParameters(region: "id"),
                    minMaxZoomPreference: const MinMaxZoomPreference(0, 18),
                    zoomControlsEnabled: false,
                    myLocationFABConfig: MyLocationFABConfig(
                      tooltip: "Lokasi Saya",
                      child: Text("Lokasi Saya"),
                      left: 16.0,
                      right: 16.0,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(16), // ubah radius sesuai selera
                      // ),
                    ),
                    enableNearbyPlaces: false,
                    apiKey: googleApiKey,
                    onPlacePicked: (LocationResult result) async {
                      debugPrint("Place picked: ${result.formattedAddress}");

                      await getIt<LocationCubit>().updateSelectedCoordinate(
                          result.latLng?.latitude ?? param.latitude, result.latLng?.longitude ?? param.longitude);
                    },
                    initialLocation: LatLng(param.latitude, param.longitude),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    searchInputConfig: const SearchInputConfig(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      autofocus: false,
                      textDirection: TextDirection.ltr,
                    ),
                    searchInputDecorationConfig: const SearchInputDecorationConfig(
                      hintText: "Search for a building, street or ...",
                    ),
                  ),
                  // GoogleMap(
                  //   myLocationEnabled: false,
                  //   // myLocationButtonEnabled: true,
                  //   mapToolbarEnabled: false,
                  //   mapType: MapType.normal,
                  //   markers: markers.values.toSet(),
                  //   initialCameraPosition: CameraPosition(
                  //     target: LatLng(param.latitude ?? 0.0, param.longitude ?? 0.0),
                  //     zoom: 16.4746,
                  //   ),
                  //   onTap: (coordinate) async {
                  //     await getIt<LocationCubit>().updateSelectedCoordinate(
                  //         coordinate.latitude, coordinate.longitude);
                  //   },
                  //   onMapCreated: (GoogleMapController controller) {
                  //     _controller.complete(controller);
                  //     // _controller = controller;
                  //   },
                  //
                  // ),
                  // Positioned(
                  //   left: 0,
                  //   right: 0,
                  //   top: 32,
                  //   child: Container(
                  //     color: Colors.white,
                  //     child: SingleChildScrollView(
                  //       child:
                  //       GooglePlaceSearchAdvance(
                  //         googleMapsApiKey: googleApiKey,
                  //         country: "ID",
                  //         iconImagePath: "assets/images/img_search.png",
                  //         mapimagePath: "assets/images/image_map.png",
                  //         onLocationSelected: (double lat, double lng, String address, String mainText, String imageURL) async {
                  //           print("Coordinates are $lat,$lng");
                  //           print("Address is : $address");
                  //           print("Image URL is: $imageURL");
                  //
                  //           await getIt<LocationCubit>().updateSelectedCoordinate(
                  //               lat, lng, altName: address);
                  //           // await _currentLocation(lat, lng);
                  //           // await _addOrMoveMarkerAtCoordinate(lat, lng);
                  //         }, lightTheme: true, focusNode: focusNode!,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                ],
              );
            }

            return state.mapOrNull(
                  // loading: (s) => googleMapWidget(s.param),
                  successSelectLocation: (s) => googleMapWidget(s.param),
                  success: (s) => googleMapWidget(s.param),
                ) ??
                googleMapWidget(stateParam);
            //   Container(
            // child: Center(child: CircularProgressIndicator()),);
          },
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () async {
        //     getIt<LocationCubit>().getCurrentLocationCoordinateAndAddress();
        //   },
        //   label: Text('My Location'),
        //   icon: Icon(Icons.location_on),
        // ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed:
        //   (){
        //     Navigator.of(context).pop();
        //   },
        //   // _fetchCoordinateAndAddressThenPop,
        //   label: const Text('Pilih lokasi ini'),
        //   icon: const Icon(Icons.directions_boat),
        // ),
        //   FlutterLocationPicker(
        //       // showLocationController: false,
        //       // showSearchBar: false,
        //       // showSelectLocationButton: false,
        //       // showContributorBadgeForOSM: false,
        //       initZoom: 11,
        //       minZoomLevel: 5,
        //       maxZoomLevel: 16,
        //       trackMyPosition: false,
        //       onPicked: (pickedData) {
        //       }),
        // Container(
        //     width: SizeUtils.width,
        //     height: SizeUtils.height,
        //     decoration: const BoxDecoration(
        //         color: Colors.blue,
        //         // image: DecorationImage(
        //         //     image: AssetImage(ImageConstant.imgMaps),
        //         //     fit: BoxFit.cover)
        //     ),
        //     child: Stack(
        //       children: [
        //         Container(
        //           color: Colors.green,
        //             child: FlutterMap(
        //               options:
        //               const MapOptions(
        //                 initialCenter: LatLng(
        //                     -7.7960880216862165,
        //                     110.49552644751105),
        //                 initialZoom:
        //                 17.0,
        //                 maxZoom:
        //                 18.0,
        //               ),
        //               children: [
        //                 TileLayer(
        //                   urlTemplate:
        //                   'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        //                   userAgentPackageName:
        //                   'com.example.app',
        //                 ),
        //                 MarkerLayer(
        //                     markers: [
        //                       Marker(
        //                         width: 80,
        //                         height: 80,
        //                         rotate: true,
        //                         point: const LatLng(
        //                             -7.7960880216862165,
        //                             110.49552644751105),
        //                         child:
        //                         Icon(
        //                           Icons
        //                               .location_on_rounded,
        //                           color: appTheme.amber500,
        //                           size: 64,
        //                         ),
        //                         // FlutterLogo(
        //                         //   textColor: Colors.blue,
        //                         //   key: ObjectKey(Colors.blue),
        //                         // ),
        //                       )
        //                     ]),
        //               ],
        //             ),
        //         ),
        //         Column(
        //           children: [
        //             const Spacer(),
        //             SizedBox(
        //                 width: double.maxFinite,
        //                 child: _buildFifteen(context)),
        //           ],
        //         ),
        //       ],
        //     ),
        // ),
      ),
    ));
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
}
