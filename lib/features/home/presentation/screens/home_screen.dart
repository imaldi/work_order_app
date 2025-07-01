// lib/presentation/pages/home_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_order_app/core/consts_and_enums/enums/sort_by_enum.dart';
import 'package:work_order_app/core/router/router.dart';
import 'package:work_order_app/core/utils/extensions/extensions.dart';
import 'package:work_order_app/core/params/work_order_params.dart';
import 'package:work_order_app/features/technician/domain/entity/technician_entity.dart';

import '../../../../core/consts_and_enums/enums/work_order_enums.dart';
import '../../../technician/presentation/bloc/technician_bloc.dart';
import '../../../work_order/presentation/bloc/work_order_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Order App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.push(const TechnicianListRoute());
                    },
                    child: const Text("Manage Teknisi"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.push(const WorkOrderListRoute());
                    },
                    child: const Text("Manage Work Order"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO hidupkan setelah generate route nya
          // context.router.push(const AddWorkOrderRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

