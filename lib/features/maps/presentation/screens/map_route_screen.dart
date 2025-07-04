import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_order_app/core/consts_and_enums/consts/google_maps_keys.dart';
import 'package:work_order_app/features/maps/presentation/state_management/location_cubit.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:work_order_app/widgets/appbar/custom_app_bar.dart';
import '../../../../core/injection/injection.dart';

@RoutePage()
class MapRouteScreen extends StatefulWidget implements AutoRouteWrapper {
  const MapRouteScreen({required this.addressCord, super.key});
  final (double, double) addressCord;
  @override
  State<MapRouteScreen> createState() => _MapRouteScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<LocationCubit>()..getCurrentLocationCoordinateAndAddress()),
      ],
      child: this,
    );
  }
}

class _MapRouteScreenState extends State<MapRouteScreen> {
  String? totalDistance;
  String? totalTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Rute Work Order Task"),
      body: BlocConsumer<LocationCubit, LocationState>(
        builder: (ctx, state) {
          return state.whenOrNull(
                loading: (_) {
                  return Center(child: CircularProgressIndicator());
                },
                success: (locationParam) {
                  (double, double) coord = (locationParam.latitude, locationParam.longitude);

                  return Stack(
                    children: [
                      GoogleMapsWidget(
                        apiKey: googleApiKey,
                        sourceLatLng: LatLng(coord.$1, coord.$2),
                        sourceMarkerIconInfo: MarkerIconInfo(
                          infoWindowTitle: "You are here",
                          onTapInfoWindow: (_) {
                            print("Your Location");
                          },
                        ),
                        destinationLatLng: LatLng(widget.addressCord.$1, widget.addressCord.$2),
                        destinationMarkerIconInfo: MarkerIconInfo(
                          infoWindowTitle: "This is your destination",
                          onTapInfoWindow: (_) {
                            print("Your Destination");
                          },
                        ),
                        totalDistanceCallback: (val){
                          print("The distance: $val");
                          setState(() {
                            totalDistance = val;
                          });
                        },
                        totalTimeCallback: (val){
                          setState(() {
                            totalTime = val;
                          });
                        },
                      ),
                      Positioned(
                          left: 16,
                          bottom: 32,
                          child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          // height: 75,
                          // width: 75,
                          child: Center(
                            child: IntrinsicHeight(
                              child: IntrinsicWidth(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Distance: ${totalDistance ?? "0 km"}"),
                                    Text("Time: ${totalTime ?? "0 seconds"}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                    ],
                  );
                },
              ) ??
              Center(child: Text("Not Found"));
        },
        listener: (ctx, stt) {},
      ),
    );
  }
}
