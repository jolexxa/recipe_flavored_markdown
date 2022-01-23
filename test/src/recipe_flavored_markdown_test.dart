// ignore_for_file: prefer_const_constructors
import 'package:markdown/markdown.dart';
import 'package:recipe_flavored_markdown/recipe_flavored_markdown.dart';
import 'package:test/test.dart';

void main() {
  group('TextchefEngine', () {
    test('can be instantiated', () {
      expect(RecipeFlavoredMarkdown(markdown: ''), isNotNull);
    });

    test('returns parsed nodes', () {
      final engine = RecipeFlavoredMarkdown(markdown: '1 3/4 cups [sugar]');
      final results = engine.parse();
      expect(results, isA<List<Node>>());
    });
  });
}
