enum WorkOrderSortFieldBy {
  title('title'),
  dueDate('dueDate'),
  priority('priority'),
  creationDate('creationDate');

  final String value;
  const WorkOrderSortFieldBy(this.value);
}