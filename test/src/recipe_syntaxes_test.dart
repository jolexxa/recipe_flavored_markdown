import 'package:markdown/markdown.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_flavored_markdown/src/recipe_nodes.dart';
import 'package:recipe_flavored_markdown/src/recipe_syntaxes.dart';
import 'package:test/test.dart';

class MockInlineParser extends Mock implements InlineParser {}

class MockMatch extends Mock implements Match {}

void main() {
  registerFallbackValue(Text(''));

  group('ScalarMixedNumberSyntax', () {
    test('adds node on match', () {
      const text = '1 3/4 cups';
      final syntax = ScalarMixedNumberSyntax();
      final parser = MockInlineParser();
      final match = MockMatch();
      when(() => match.group(0)).thenReturn(text);
      when(() => match.group(1)).thenReturn('1');
      when(() => match.group(2)).thenReturn('3');
      when(() => match.group(3)).thenReturn('4');
      when(() => match.group(4)).thenReturn('cups');
      syntax.onMatch(parser, match);
      final scalar = verify(
        () => parser.addNode(captureAny(that: isA<Scalar>())),
      ).captured.single as Scalar;
      verify(() => match.group(0)).called(1);
      expect(scalar.textContent, text);
    });
  });

  group('ScalarWholeNumberSyntax', () {
    test('adds node on match', () {
      const text = '1 cup';
      final syntax = ScalarWholeNumberSyntax();
      final parser = MockInlineParser();
      final match = MockMatch();
      when(() => match.group(0)).thenReturn(text);
      when(() => match.group(1)).thenReturn('1');
      when(() => match.group(2)).thenReturn('cup');
      syntax.onMatch(parser, match);
      final scalar = verify(
        () => parser.addNode(captureAny(that: isA<Scalar>())),
      ).captured.single as Scalar;
      verify(() => match.group(0)).called(1);
      expect(scalar.textContent, text);
    });
  });

  group('ScalarFractionalSyntax', () {
    test('adds node on match', () {
      const text = '3/4 cup';
      final syntax = ScalarFractionalSyntax();
      final parser = MockInlineParser();
      final match = MockMatch();
      when(() => match.group(0)).thenReturn(text);
      when(() => match.group(1)).thenReturn('3');
      when(() => match.group(2)).thenReturn('4');
      when(() => match.group(3)).thenReturn('cup');
      syntax.onMatch(parser, match);
      final scalar = verify(
        () => parser.addNode(captureAny(that: isA<Scalar>())),
      ).captured.single as Scalar;
      verify(() => match.group(0)).called(1);
      expect(scalar.textContent, text);
    });
  });
}
