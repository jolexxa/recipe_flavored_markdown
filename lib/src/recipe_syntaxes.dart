import 'package:markdown/markdown.dart';
import 'package:recipe_engine/src/recipe_nodes.dart';

const String _units = '(?:'
    'tsp(?:s?)|tbsp(?:s?)|oz|cup(?:s?)|pint(?:s?)|quart(?:s?)|'
    'gal(?:s?)|gallon(?:s?)|lb(?:s?)|kg|g|ml|l'
    ')';

/// {@template quantity_mixed_number_syntax}
/// Represents a cooking quantity given as a mixed number: i.e.,
/// `1 2/3 cups` or `1.5 2.3/4.5 tbsp` (you probably shouldn't use
/// decimals, but you can).
/// {@endtemplate}
class QuantityMixedNumberSyntax extends InlineSyntax {
  /// {@macro quantity_mixed_number_syntax}
  QuantityMixedNumberSyntax() : super(_pattern);

  static const String _quantifier =
      r'(\d+(?:\.\d+)?\s+(\d+(?:\.\d+)?)\s*\/\s*(\d+(?:\.\d+)?))';
  static const String _pattern = '$_quantifier\\s+$_units';

  @override
  bool onMatch(InlineParser parser, Match match) {
    parser.addNode(Quantity(match.group(0)!));
    return true;
  }
}

/// {@template quantity_whole_number_syntax}
/// Represents a cooking quantity given as a whole number: i.e.,
/// `1 cup` or `1.5 tbsp` (you probably shouldn't use decimals, but you can).
/// {@endtemplate}
class QuantityWholeNumberSyntax extends InlineSyntax {
  /// {@macro quantity_whole_number_syntax}
  QuantityWholeNumberSyntax() : super(_pattern);

  static const String _quantifier = r'(\d+(?:\.\d+)?)';
  static const String _pattern = '$_quantifier\\s+$_units';

  @override
  bool onMatch(InlineParser parser, Match match) {
    parser.addNode(Quantity(match.group(0)!));
    return true;
  }
}

/// {@template quantity_fractional_syntax}
/// Represents a cooking quantity given as a fraction: i.e.,
/// `1/2 tsp` or `1.5/4.5 tbsp` (you probably shouldn't use decimals, but you can).
/// {@endtemplate}
class QuantityFractionalSyntax extends InlineSyntax {
  /// {@macro quantity_fractional_syntax}
  QuantityFractionalSyntax() : super(_pattern);

  static const String _quantifier = r'(\d+(?:\.\d+)?\s*\/\s*\d+(?:\.\d+)?)';
  static const String _pattern = '$_quantifier\\s+$_units';

  @override
  bool onMatch(InlineParser parser, Match match) {
    parser.addNode(Quantity(match.group(0)!));
    return true;
  }
}
