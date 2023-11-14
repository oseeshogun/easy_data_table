import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;
  final int age;

  const Person({
    required this.name,
    required this.age,
  });

  @override
  List<Object?> get props => [name, age];
}