import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/technician_bloc.dart';

@RoutePage()
class TechnicianListScreen extends StatelessWidget {
  const TechnicianListScreen({Key? key}) : super(key: key);

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
                      // context.router.push(EditTechnicianRoute(technician: technician));
                    },
                  );
                },
              );

            }
          ) ?? const Center(child: Text('Tidak ada data teknisi'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.router.push(const AddTechnicianRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}