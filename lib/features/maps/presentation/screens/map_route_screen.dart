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

                  return GoogleMapsWidget(
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
                        print("Your Location");
                      },
                    ),
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
