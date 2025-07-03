enum WorkOrderStatus {
  pending("pending"),
  inProgress("in_progress"),
  completed("completed");

  final String value;
  const WorkOrderStatus(this.value);
}
enum WorkOrderPriority {
  low("low"),
  medium("medium"),
  high("high");
  final String value;
  const WorkOrderPriority(this.value);
}