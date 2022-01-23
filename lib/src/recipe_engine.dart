import 'package:markdown/markdown.dart';
import 'package:recipe_engine/src/recipe_nodes.dart';
import 'package:recipe_engine/src/recipe_syntaxes.dart';

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
      inlineSyntaxes: [
        QuantityMixedNumberSyntax(),
        QuantityWholeNumberSyntax(),
        QuantityFractionalSyntax(),
      ],
    );
    // Replace windows line endings with unix line endings, and split.
    final lines = [...markdown.replaceAll('\r\n', '\n').split('\n'), '\n'];
    return document.parseLines(lines);
  }
}
