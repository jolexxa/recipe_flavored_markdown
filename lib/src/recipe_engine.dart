import 'package:markdown/markdown.dart';

/// {@template recipe_node_visitor}
/// A [NodeVisitor] used to visit nodes created by parsing
/// a markdown file with the recipe engine extensions.
abstract class RecipeNodeVisitor implements NodeVisitor {
  /// Called when a reference node has been reached.
  void visitReference(Reference reference);
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

/// {@template recipe_html_renderer}
/// An HTML renderer that can render recipe-flavored markdown.
/// {@endtemplate}
class RecipeHtmlRenderer extends HtmlRenderer implements RecipeNodeVisitor {
  /// {@macro recipe_html_renderer}
  RecipeHtmlRenderer();

  /// Visit a reference node.
  @override
  void visitReference(Reference reference) {
    buffer.write(reference.textContent);
  }
}

/// {@template recipe_engine}
/// Examine Markdown recipe files.
/// {@endtemplate}
class RecipeEngine {
  /// {@macro recipe_engine}
  const RecipeEngine({required this.markdown});

  /// Markdown recipe text.
  final String markdown;

  /// Parse the recipe text.
  List<Node> parse() {
    final document = Document(
      // Unresolved links are most likely references to ingredients,
      // recipes, or cooking supplies.
      linkResolver: (String name, [String? title]) => Reference(name),
    );
    // Replace windows line endings with unix line endings, and split.
    final lines = [...markdown.replaceAll('\r\n', '\n').split('\n'), '\n'];
    return document.parseLines(lines);
  }
}
