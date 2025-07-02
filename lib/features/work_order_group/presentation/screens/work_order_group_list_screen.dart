import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_order_app/core/params/params.dart';
import 'package:work_order_app/features/technician/domain/use_cases/get_all_technicians.dart';

import '../../../../core/injection/injection.dart';
import '../../../../core/params/technician_params.dart';
import '../../../../core/router/router.dart';
import '../../../../widgets/my_confirm_dialog/my_confirm_dialog.dart';
import '../bloc/work_order_group_bloc.dart';

@RoutePage()
class WorkOrderGroupListScreen extends StatefulWidget implements AutoRouteWrapper {
  const WorkOrderGroupListScreen({super.key});

  @override
  State<WorkOrderGroupListScreen> createState() => _WorkOrderGroupListScreenState();


  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
        value: getIt<WorkOrderGroupBloc>()..add(GetAllWorkOrderGroupsEvent()),
        child: this);
  }
}

class _WorkOrderGroupListScreenState extends State<WorkOrderGroupListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Work Order Group')),
      body: BlocBuilder<WorkOrderGroupBloc, WorkOrderGroupState>(
        builder: (context, state) {
          return state.whenOrNull(
            loading: (){
              return const Center(child: CircularProgressIndicator());
            },
            loaded: (list){
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final group = list[index];
                  return ListTile(
                    title: Text(group.title),
                    subtitle: Text(group.description),
                    onTap: () {
                      // FIXME uncomment ketika sudah generate route
                      context.router.push(EditWorkOrderGroupRoute(group: group));
                    },
                    trailing:
                    ElevatedButton(
                      onPressed: () {

                        myConfirmDialog(
                          context,
                          title: "Yakin Hapus data Work Order Group?",
                          positiveButtonCallback: (){
                            context
                                .read<WorkOrderGroupBloc>()
                                .add(DeleteWorkOrderGroupEvent(
                                QueryIdParams(
                                    id: group.id ?? 0
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

            },
            error: (error){
              return Center(child: Text(error.message));
            }
          ) ?? const Center(child: Text('Tidak ada data work order group'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const CreateWorkOrderGroupRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}