import 'package:markdown/markdown.dart';

/// {@template recipe_node_visitor}
/// A [NodeVisitor] used to visit nodes created by parsing
/// a markdown file with the recipe engine extensions.
abstract class RecipeNodeVisitor implements NodeVisitor {
  /// Called when a reference node has been reached.
  void visitReference(Reference reference);

  /// Called when a quantity node has been reached.
  void visitQuantity(Quantity quantity);
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

/// {@template quantity}
/// Represents a cooking quantity.
/// {@endtemplate}
class Quantity implements Node {
  /// {@macro quantity}

  const Quantity(this.textContent);

  @override
  final String textContent;

  @override
  void accept(covariant RecipeNodeVisitor visitor) =>
      visitor.visitQuantity(this);
}
