
import 'package:equatable/equatable.dart';

class QueryIdParams extends Equatable {
  final int id;

  const QueryIdParams({required this.id});
  @override
  List<Object?> get props => [
    id
  ];
}


class CreateEntityParams<T> extends Equatable {
  final T entity;

  const CreateEntityParams({required this.entity});
  @override
  List<Object?> get props => [
    entity
  ];
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}