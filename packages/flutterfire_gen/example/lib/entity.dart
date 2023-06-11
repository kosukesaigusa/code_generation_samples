import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

part 'entity.g.dart';

@flutterFireGen
class Entity {
  const Entity({
    required this.name,
    required this.age,
    required this.isAdult,
  });

  final String name;
  final int age;
  final bool isAdult;
}
