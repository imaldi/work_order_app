import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_order_app/core/params/params.dart';
import 'package:work_order_app/features/technician/domain/use_cases/get_all_technicians.dart';

import '../../../../core/injection/injection.dart';
import '../../../../core/params/technician_params.dart';
import '../../../../core/router/router.dart';
import '../../../../widgets/my_confirm_dialog/my_confirm_dialog.dart';
import '../bloc/technician_bloc.dart';

@RoutePage()
class TechnicianListScreen extends StatefulWidget implements AutoRouteWrapper {
  const TechnicianListScreen({super.key});

  @override
  State<TechnicianListScreen> createState() => _TechnicianListScreenState();


  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
        value: getIt<TechnicianBloc>()..add(LoadTechniciansEvent()),
        child: this);
  }
}

class _TechnicianListScreenState extends State<TechnicianListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Teknisi')),
      body: BlocBuilder<TechnicianBloc, TechnicianState>(
        builder: (context, state) {
          return state.whenOrNull(
            loading: (){
              return const Center(child: CircularProgressIndicator());
            },
            loaded: (list){
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final technician = list[index];
                  return ListTile(
                    title: Text(technician.name),
                    subtitle: Text(technician.contact ?? 'No Contact'),
                    onTap: () {
                      // FIXME uncomment ketika sudah generate route
                      context.router.push(EditTechnicianRoute(technician: technician));
                    },
                    trailing:
                    ElevatedButton(
                      onPressed: () {

                        myConfirmDialog(
                          context,
                          title: "Yakin Hapus data Teknisi?",
                          positiveButtonCallback: (){
                            context
                                .read<TechnicianBloc>()
                                .add(DeleteTechnicianEvent(
                                DeleteTechnicianParams(
                                    id: technician.id
                                )
                            ));
                          },
                          positiveButtonText: "Ya",
                          negativeButtonCallback: (){
                            context.router.pop();
                          },
                          negativeButtonText: "Batal",
                        );
                      },
                      // style: ElevatedButton.styleFrom(
                      //     textStyle: TextStyle(color: Colors.white),
                      //     backgroundColor: Colors.amber),
                      child: const Text('Hapus',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
              );

            }
          ) ?? const Center(child: Text('Tidak ada data teknisi'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const AddTechnicianRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}