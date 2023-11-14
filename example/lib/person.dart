import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';

class Person extends Equatable {
  final String name;
  final int age;
  final bool isMarried;
  final double height;
  final String city;

  const Person({
    required this.name,
    required this.age,
    required this.isMarried,
    required this.height,
    required this.city,
  });

  @override
  List<Object?> get props => [name, age];
}

final persons = [
  for (var i = 0; i < 20; i++)
    Person(
      name: faker.person.firstName(),
      age: faker.randomGenerator.integer(50, min: 16),
      isMarried: faker.randomGenerator.boolean(),
      height: 1.6 + i / 10,
      city: faker.address.city(),
    ),
];
