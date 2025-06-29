enum WorkOrderSortField {
  dueDate('dueDate'),
  priority('priority'),
  creationDate('creationDate');

  final String value;
  const WorkOrderSortField(this.value);
}