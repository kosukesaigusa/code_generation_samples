# code_generation_samples

Welcome to `code_generation_samples`, a suite of packages that demonstrate various code generation techniques in Dart and Flutter. This repository is designed as an educational tool to help developers learn how to simplify and automate tasks through the use of code generation.

Additionally, this collection is featured as part of a presentation at FlutterKaigi, a renowned Flutter conference taking place in Japan on November 10th, 2023.

## Packages Included

This repository includes the following packages, each tailored for a specific code generation scenario:

This repository includes the following packages, each tailored for a specific code generation scenario:

- `copy_builder`: A basic builder package that generates duplicate files for all input files.
- `copy_builder_annotation`: Provides the `@Copy` annotation, which is recognized by `copy_builder_for_annotation`.
- `copy_builder_for_annotation`: An advanced version of `copy_builder` that targets files marked with `@Copy` annotations.
- `from_json_generator`: A builder that generates a `fromJson` method for classes decorated with annotations.
- `from_json_generator_annotation`: Supplies annotations that drive the behavior of `from_json_generator`.

## Quick Start

To see code generation in action, run the following commands in the `copy_builder`, `copy_builder_for_annotation`, and `from_json_generator` package directories. The generated files can be found within the `test/helper` directories of each package.

```sh
dart pub get
dart run build_runner build --delete-conflicting-outputs
