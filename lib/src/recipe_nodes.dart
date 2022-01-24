import 'package:markdown/markdown.dart';

/// {@template recipe_node_visitor}
/// A [NodeVisitor] used to visit nodes created by parsing
/// a markdown file with the recipe engine extensions.
abstract class RecipeNodeVisitor implements NodeVisitor {
  /// Called when a reference node has been reached.
  void visitReference(Reference reference);

  /// Called when a scalar node has been reached.
  void visitScalar(Scalar scalar);
}

/// {@template reference}
/// Reference to another recipe, ingredient, or supply.
/// {@endtemplate}
class Reference implements Node {
  /// {@macro reference}
  const Reference(this.textContent);

  @override
  final String textContent;

  @override
  void accept(covariant RecipeNodeVisitor visitor) =>
      visitor.visitReference(this);
}

/// {@template scalar}
/// Represents a cooking scalar, such as `1 cup`, or `30 seconds`.
/// {@endtemplate}
class Scalar implements Node {
  /// {@macro scalar}
  const Scalar({
    required this.textContent,
    required this.unitString,
    this.wholeNumberString = '',
    this.numeratorString = '',
    this.denominatorString = '',
  });

  /// Matched "whole number" portion of the scalar —
  /// can technically be a decimal number.
  final String wholeNumberString;

  /// Numerator portion of the scalar.
  final String numeratorString;

  /// Denominator portion of the scalar.
  final String denominatorString;

  /// The unit of measure of the scalar.
  final String unitString;

  /// Whole number portion of the scalar, if any.
  double get wholeNumber => double.tryParse(wholeNumberString) ?? 0;

  /// Numerator portion of the scalar, if any.
  double get numerator => double.tryParse(numeratorString) ?? 0;

  /// Denominator portion of the scalar, if any.
  double get denominator => double.tryParse(denominatorString) ?? 1;

  /// Value of the scalar.
  double get value => wholeNumber + numerator / denominator;

  @override
  final String textContent;

  @override
  void accept(covariant RecipeNodeVisitor visitor) => visitor.visitScalar(this);
}
