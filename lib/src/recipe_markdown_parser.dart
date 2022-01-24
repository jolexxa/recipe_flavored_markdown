import 'package:markdown/markdown.dart';
import 'package:recipe_flavored_markdown/src/recipe_nodes.dart';
import 'package:recipe_flavored_markdown/src/recipe_syntaxes.dart';

/// {@template recipe_flavored_markdown}
/// Recipe-flavored markdown engine.
///
/// Parses recipe-flavored markdown and returns abstract syntax tree
/// nodes, including recipe-flavored nodes which represent cooking
/// quantities, ingredients, and other references.
/// {@endtemplate}
class RecipeMarkdownParser {
  /// {@macro recipe_flavored_markdown}
  const RecipeMarkdownParser({required this.markdown});

  /// Markdown recipe text.
  final String markdown;

  /// Parse recipe-flavored markdown and return a list of syntax tree nodes.
  List<Node> parse() {
    final document = Document(
      // Unresolved links are most likely references to ingredients,
      // recipes, or cooking supplies.
      linkResolver: (String name, [String? title]) => Reference(name),
      inlineSyntaxes: [
        ScalarMixedNumberSyntax(),
        ScalarWholeNumberSyntax(),
        ScalarFractionalSyntax(),
      ],
    );
    // Replace windows line endings with unix line endings, and split.
    final lines = [...markdown.replaceAll('\r\n', '\n').split('\n'), '\n'];
    return document.parseLines(lines);
  }
}
