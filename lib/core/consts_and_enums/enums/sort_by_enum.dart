enum WorkOrderSortFieldBy {
  title('title'),
  dueDate('dueDate'),
  priority('priority'),
  status('status');

  final String value;
  const WorkOrderSortFieldBy(this.value);
}