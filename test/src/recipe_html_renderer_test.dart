import 'package:recipe_flavored_markdown/src/recipe_html_renderer.dart';
import 'package:recipe_flavored_markdown/src/recipe_nodes.dart';
import 'package:test/test.dart';

void main() {
  group('RecipeHtmlRenderer', () {
    test('renders Reference node', () {
      const text = '[tomato]';
      const nodes = [Reference(text)];
      final renderer = RecipeHtmlRenderer();
      final html = renderer.render(nodes);
      expect(html, text);
    });

    test('renders Quantity node', () {
      const text = '1 3/4 cups';
      const nodes = [Quantity(text)];
      final renderer = RecipeHtmlRenderer();
      final html = renderer.render(nodes);
      expect(html, text);
    });
  });
}
