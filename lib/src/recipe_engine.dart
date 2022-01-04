import 'package:markdown/markdown.dart';

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
      // Unresolved links are likely references to ingredients or cooking supplies.
      linkResolver: (String name, [String? title]) => UnparsedContent(name),
    );
    // Replace windows line endings with unix line endings, and split.
    final lines = [...markdown.replaceAll('\r\n', '\n').split('\n'), '\n'];
    return document.parseLines(lines);
  }
}
