enum WorkOrderStatus {
  pending("pending", "Pending"),
  inProgress("in_progress", "In Progress"),
  completed("completed", "Completed");

  final String value;
  final String string;
  const WorkOrderStatus(this.value, this.string);
}
enum WorkOrderPriority {
  low("low"),
  medium("medium"),
  high("high");
  final String value;
  const WorkOrderPriority(this.value);
}