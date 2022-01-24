// ignore_for_file: prefer_const_constructors

import 'package:markdown/markdown.dart';
import 'package:recipe_flavored_markdown/src/recipe_markdown_parser.dart';
import 'package:recipe_flavored_markdown/src/recipe_nodes.dart';
import 'package:test/test.dart';

const recipe = '''
- 2 tsp [vanilla extract]
- 1 3/4 cup [milk]
- 2/3 cup [sugar]
''';

void main() {
  group('RecipeMarkdownParser', () {
    test('custom syntaxes are ordered correctly for proper parsing', () {
      final parser = RecipeMarkdownParser(
        markdown: recipe,
      );
      final nodes = (parser.parse()[0] as Element).children!.cast<Element>();
      expect(
        nodes[0].children![0],
        isA<Quantity>().having(
          (q) => q.textContent,
          'textContent',
          '2 tsp',
        ),
      );
      expect(
        nodes[1].children![0],
        isA<Quantity>().having(
          (q) => q.textContent,
          'textContent',
          '1 3/4 cup',
        ),
      );
      expect(
        nodes[2].children![0],
        isA<Quantity>().having(
          (q) => q.textContent,
          'textContent',
          '2/3 cup',
        ),
      );
    });
  });
}
