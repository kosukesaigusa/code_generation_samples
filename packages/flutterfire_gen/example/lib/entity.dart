import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

part 'entity.g.dart';

@flutterFireGen
class Entity {
  const Entity({
    required this.name,
    required this.age,
    required this.isAdult,
    required this.foo,
  });

  @Default('aaaaa')
  final String name;

  // @Default(0)
  final int age;

  @Default(false)
  final bool isAdult;

  @Default(Foo('ba'))
  final Foo foo;
}

class Foo {
  const Foo(this.bar);

  final String bar;
}
