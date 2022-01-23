import 'package:markdown/markdown.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_flavored_markdown/src/recipe_nodes.dart';
import 'package:recipe_flavored_markdown/src/recipe_syntaxes.dart';
import 'package:test/test.dart';

class MockInlineParser extends Mock implements InlineParser {}

class MockMatch extends Mock implements Match {}

void main() {
  registerFallbackValue(Text(''));

  group('QuantityMixedNumberSyntax', () {
    test('adds node on match', () {
      const text = '1 3/4 cups';
      final syntax = QuantityMixedNumberSyntax();
      final parser = MockInlineParser();
      final match = MockMatch();
      when(() => match.group(0)).thenReturn(text);
      syntax.onMatch(parser, match);
      final quantity = verify(
        () => parser.addNode(captureAny(that: isA<Quantity>())),
      ).captured.single as Quantity;
      verify(() => match.group(0)).called(1);
      expect(quantity.textContent, text);
    });
  });

  group('QuantityWholeNumberSyntax', () {
    test('adds node on match', () {
      const text = '1 cup';
      final syntax = QuantityWholeNumberSyntax();
      final parser = MockInlineParser();
      final match = MockMatch();
      when(() => match.group(0)).thenReturn(text);
      syntax.onMatch(parser, match);
      final quantity = verify(
        () => parser.addNode(captureAny(that: isA<Quantity>())),
      ).captured.single as Quantity;
      verify(() => match.group(0)).called(1);
      expect(quantity.textContent, text);
    });
  });

  group('QuantityFractionalSyntax', () {
    test('adds node on match', () {
      const text = '3/4 cup';
      final syntax = QuantityFractionalSyntax();
      final parser = MockInlineParser();
      final match = MockMatch();
      when(() => match.group(0)).thenReturn(text);
      syntax.onMatch(parser, match);
      final quantity = verify(
        () => parser.addNode(captureAny(that: isA<Quantity>())),
      ).captured.single as Quantity;
      verify(() => match.group(0)).called(1);
      expect(quantity.textContent, text);
    });
  });
}
