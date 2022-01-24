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
  group('Scalar', () {
    test('initializes and accepts a recipe node visitor', () {
      const text = '1 3/4 cups';
      const scalar = Scalar(
        textContent: text,
        unitString: 'cups',
        wholeNumberString: '1',
        numeratorString: '3',
        denominatorString: '4',
      );
      expect(scalar.textContent, text);
      expect(scalar.wholeNumber, 1);
      expect(scalar.numerator, 3);
      expect(scalar.denominator, 4);
      expect(scalar.value, 1.75);
      final visitor = MockVisitor();
      scalar.accept(visitor);
      verify(() => visitor.visitScalar(scalar));
    });
  });
}
