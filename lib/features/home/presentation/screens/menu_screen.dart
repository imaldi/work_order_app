import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:work_order_app/core/router/router.dart';

@RoutePage()
class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.push(const WorkOrderGroupListRoute());
                    },
                    child: const Text("Manage Work Order Group"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

