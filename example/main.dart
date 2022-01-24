import 'package:recipe_flavored_markdown/recipe_flavored_markdown.dart';

const recipe = '1 3/4 cups [sugar]';

const parser = RecipeMarkdownParser(
  markdown: recipe,
);

final nodes = parser.parse();
