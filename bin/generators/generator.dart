abstract class IGenerator {
  String get outputDir;

  void generate(String name, [List<String> attributes]);
}
