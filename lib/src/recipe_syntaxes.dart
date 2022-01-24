import 'package:markdown/markdown.dart';
import 'package:recipe_flavored_markdown/src/recipe_nodes.dart';

const String _units = '('
    'tsp(?:s?)|tbsp(?:s?)|oz|cup(?:s?)|pint(?:s?)|quart(?:s?)|'
    'gal(?:s?)|gallon(?:s?)|lb(?:s?)|kg|g|ml|l|hr(?:s?)|'
    'hour(?:s?)|min(?:s?)|minute(?:s?)|sec(?:s?)|second(?:s?)'
    ')';

/// {@template scalar_mixed_number_syntax}
/// Represents a cooking scalar given as a mixed number: i.e.,
/// `1 2/3 cups`, `1.5 2.3/4.5 tbsp`, or `30 4/5 mins`.
/// Decimals are allowed, but not recommended.
/// {@endtemplate}
class ScalarMixedNumberSyntax extends InlineSyntax {
  /// {@macro scalar_mixed_number_syntax}
  ScalarMixedNumberSyntax() : super(_pattern);

  static const String _quantifier =
      r'(\d+(?:\.\d+)?)\s+(\d+(?:\.\d+)?)\s*\/\s*(\d+(?:\.\d+)?)';
  static const String _pattern = '$_quantifier\\s+$_units';

  @override
  bool onMatch(InlineParser parser, Match match) {
    parser.addNode(
      Scalar(
        textContent: match.group(0)!,
        wholeNumberString: match.group(1)!,
        numeratorString: match.group(2)!,
        denominatorString: match.group(3)!,
        unitString: match.group(4)!,
      ),
    );
    return true;
  }
}

/// {@template scalar_whole_number_syntax}
/// Represents a cooking scalar given as a whole number: i.e.,
/// `1 cup`, `1.5 tbsp`, '35.6 seconds`.
/// Decimals are allowed, but not recommended.
/// {@endtemplate}
class ScalarWholeNumberSyntax extends InlineSyntax {
  /// {@macro scalar_whole_number_syntax}
  ScalarWholeNumberSyntax() : super(_pattern);

  static const String _quantifier = r'(\d+(?:\.\d+)?)';
  static const String _pattern = '$_quantifier\\s+$_units';

  @override
  bool onMatch(InlineParser parser, Match match) {
    parser.addNode(
      Scalar(
        textContent: match.group(0)!,
        wholeNumberString: match.group(1)!,
        unitString: match.group(2)!,
      ),
    );
    return true;
  }
}

/// {@template scalar_fractional_syntax}
/// Represents a cooking scalar given as a fraction: i.e.,
/// `1/2 tsp`, `1.5/4.5 tbsp`, or `1/2 minute`.
/// Decimals are allowed, but not recommended.
/// {@endtemplate}
class ScalarFractionalSyntax extends InlineSyntax {
  /// {@macro scalar_fractional_syntax}
  ScalarFractionalSyntax() : super(_pattern);

  static const String _quantifier = r'(\d+(?:\.\d+)?)\s*\/\s*(\d+(?:\.\d+)?)';
  static const String _pattern = '$_quantifier\\s+$_units';

  @override
  bool onMatch(InlineParser parser, Match match) {
    parser.addNode(
      Scalar(
        textContent: match.group(0)!,
        numeratorString: match.group(1)!,
        denominatorString: match.group(2)!,
        unitString: match.group(3)!,
      ),
    );
    return true;
  }
}
