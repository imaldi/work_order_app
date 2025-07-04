import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_order_app/core/consts_and_enums/enums/work_order_enums.dart';
import 'package:work_order_app/core/injection/injection.dart';
import 'package:work_order_app/features/work_order/domain/entities/work_order_entity.dart';
import 'package:work_order_app/features/work_order/presentation/bloc/work_order_bloc.dart';
import 'package:work_order_app/widgets/appbar/custom_app_bar.dart';

import '../../../../core/themes/text_styles.dart';
import '../../../../widgets/text/title_text.dart';

@RoutePage()
class WorkOrderDetailScreen extends StatefulWidget {
  const WorkOrderDetailScreen({required this.workOrder, super.key});
  final WorkOrderEntity workOrder;
  @override
  State<WorkOrderDetailScreen> createState() => _WorkOrderDetailScreenState();

}

class _WorkOrderDetailScreenState extends State<WorkOrderDetailScreen> {
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
              _section("Location Map",
              children: [
                Text(widget.workOrder.address),
                Text("Lat: ${widget.workOrder.latitude}"),
                Text("Lng: ${widget.workOrder.longitude}"),
              ]),
              _section("Details", children: [
                _detailRow((
                  title: Text("Work Order ID", style: MyTextStyles.textGreyDetail,),
                  content: Text("WO-2023-0452"),
                )),
                _detailRow((
                  title: Text("Status", style: MyTextStyles.textGreyDetail,),
                  content: Text(WorkOrderStatus.values.firstWhere((el) => el.value == widget.workOrder.status).string),
                )),
                _detailRow((
                  // FIXME, ini perbaiki gimana bagusnya
                  title: Text("Assigned To", style: MyTextStyles.textGreyDetail,),
                  content: Text("You"),
                )),
                _detailRow((
                  title: Text("Created", style: MyTextStyles.textGreyDetail,),
                  // content: Text("Today, 8:15 AM"),
                  content: Text("Today, 8:15 AM"),
                )),
                _detailRow((
                  title: Text("Scheduled", style: MyTextStyles.textGreyDetail,),
                  content: Text("Today, 1:30 PM"),
                )),
                _detailRow((
                  title: Text("Location", style: MyTextStyles.textGreyDetail,),
                  content: Text(widget.workOrder.location),
                )),
                _detailRow((
                  title: Text("Address", style: MyTextStyles.textGreyDetail,),
                  content: Text("123 Main St, Suite 300, Anytown, Use"),
                )),
              ]),
              _section("Description",children: [
                Text(widget.workOrder.description),
              ]),
              _section("Customer", children: [
                _detailRow((
                  title: Text("Name", style: MyTextStyles.textGreyDetail,),
                  content: Text("Sarah Johnson (Facilities)"),
                )),
                _detailRow((
                  title: Text("Phone", style: MyTextStyles.textGreyDetail,),
                  content: Text("(555) 123-4567"),
                )),
                _detailRow((
                  title: Text("Email", style: MyTextStyles.textGreyDetail,),
                  content: Text("s.johnson@company.com"),
                )),
              ]),
              _section("Required Materials", children: [
                Text(widget.workOrder.materials),
                // Text("- PVC Pipes (1.5\")"),
                // Text("- Pipe cutter"),
                // Text("- Pipe wrench set"),
                // Text("- Teflon tape"),
                // Text("- Joint compound"),
              ]),
              _section("Attachments", children: [
                Row(
                  children: [
                    Container(
                        color: Colors.lightBlue[200],
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.camera_alt, size: 64,)),
                    SizedBox(width: 16,),
                    Container(
                        color: Colors.lightBlue[200],
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.book, size: 64,)),
                  ],
                ),
              ]),
          ],),
        ),
      ),
    );
  }

  _section(String title, {List<Widget>? children}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      TitleText(title),
      Divider(),
      ...?children,
      SizedBox(height: 16,)
    ],);
  }

  _detailRow(({Widget title, Widget content}) widgetPair){
    return Row(
      children: [
        Expanded(child: widgetPair.title),
        Expanded(
            flex: 2,
            child: widgetPair.content),
      ],
    );
  }
}
