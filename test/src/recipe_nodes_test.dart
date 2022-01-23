import 'package:mocktail/mocktail.dart';
import 'package:recipe_flavored_markdown/src/recipe_nodes.dart';
import 'package:test/test.dart';

class MockVisitor extends Mock implements RecipeNodeVisitor {}

void main() {
  group('Reference', () {
    test('initializes and accepts a recipe node visitor', () {
      const text = '[tomato]';
      const reference = Reference(text);
      expect(reference.textContent, text);
      final visitor = MockVisitor();
      reference.accept(visitor);
      verify(() => visitor.visitReference(reference));
    });
  });
  group('Quantity', () {
    test('initializes and accepts a recipe node visitor', () {
      const text = '1 3/4 cups';
      const quantity = Quantity(text);
      expect(quantity.textContent, text);
      final visitor = MockVisitor();
      quantity.accept(visitor);
      verify(() => visitor.visitQuantity(quantity));
    });
  });
}
