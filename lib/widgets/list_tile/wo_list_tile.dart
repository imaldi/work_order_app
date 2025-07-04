import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_order_app/core/params/params.dart';
import 'package:work_order_app/core/router/router.dart';
import 'package:work_order_app/core/themes/text_styles.dart';
import 'package:work_order_app/features/work_order/domain/use_cases/delete_work_order.dart';
import 'package:work_order_app/features/work_order/presentation/bloc/work_order_bloc.dart';

import '../../core/utils/string_helpers.dart';
import '../../features/work_order/domain/entities/work_order_entity.dart';
import '../my_confirm_dialog/my_confirm_dialog.dart';

class WoListTile extends StatelessWidget {
  const WoListTile(this.workOrder, {super.key});
  final WorkOrderEntity workOrder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(WorkOrderDetailRoute(workOrder: workOrder));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          // color: Colors.amber,
          // padding: EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(workOrder.title, style: MyTextStyles.titleLarge),
                          Text(workOrder.id.toString(), style: MyTextStyles.textGreyDetail),
                          // Text(workOrder.customId),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(workOrder.location, style: MyTextStyles.textGreyDetail),
                          ),
                          Expanded(
                            child: Text(
                              formatDateTime(
                                DateFormat('yy-MM-dd HH:mm').parse(workOrder.scheduledStart),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("High"),
                      IntrinsicWidth(
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  context.router.push(EditWorkOrderRoute(workOrder: workOrder));
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  myConfirmDialog(
                                    context,
                                    title: "Yakin hapus data Work Order?",
                                    positiveButtonCallback: () {
                                      context.read<WorkOrderBloc>().add(
                                        DeleteWorkOrderEvent(QueryIdParams(id: workOrder.id)),
                                      );
                                    },
                                    positiveButtonText: "Ya",
                                    negativeButtonCallback: () {
                                      context.router.pop();
                                    },
                                    negativeButtonText: "Batal",
                                  );
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
