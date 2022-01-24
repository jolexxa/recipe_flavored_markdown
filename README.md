# Recipe-Flavored Markdown

![Coverage][coverage-badge] [![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link] [![License: MIT][license_badge]][license_link]

Have you ever wanted a simpler approach to writing and maintaining recipes? Are you tired of fidgeting with apps that make it hard to specify ingredients or instructions for all your tasty, sacred texts? Would you rather take matters into your own hands and write recipes using nothing but a plain-text editor?

**Note:** *This is a passion project that is still in its infancy. Feel free to make suggestions!*

Meet recipe-flavored markdown! Using nothing but markdown, you can write your tasty tomes in a loosely-opinionated way that reads almost exactly like your grandmother's (or grandfather's!) recipes. Better yet, this package allows you to parse recipe-flavored markdown documents in Dart and use them however you like! Let's get to cookin'!

Below is what a recipe for Cinnamon Rolls might look like in recipe-flavored markdown: 

```markdown
---
# Use YAML front matter to specify recipe metadata
categories: desserts, baking, feel good, comfort food
yields: 18 cinnamon rolls
servings: 9
prep: 20 mins
cook: 20 mins
---

# Homemade Cinnamon Rolls

Made from scratch, these soft, creamy cinnamon rolls will leave you feeling happy and satisfied, even on the coldest winter nights. Pour over a generous, sugary glaze for the warm, comforting snack you know you deserve!

## Ingredients

### Dough

- 2 cups all-purpose [flour]
- 2 tbsp [white sugar]
- 2 tsp [baking powder]
- 1 tsp [salt]
- 3 tbsp [butter], softened
- 3/4 cup [milk]
- 1 [egg]

### Filling

- 1/2 cup [white sugar]
- 1/2 cup [brown sugar]
- 1 tbsp [ground cinnamon]

### Cream Cheese Frosting

- 1 cup [powdered sugar]
- 4 oz [cream cheese], softened
- 1/4 cup [butter], softened
- 1/2 tsp [vanilla extract]

## Instructions

1. Preheat oven to 400 degrees. Brush a [9" baking dish] with 2 tbsp [butter].

2. Whisk [flour], 2 tbsp [white sugar], [baking powder], and [salt] together in a large bowl.

3. Work 3 tbsp softened [butter] into [flour] mixture using your hands. Beat [milk] and [egg] together in another bowl; pour into flour-butter mixture and stir with a spatula until a soft dough forms.

4. Whisk 1/2 cup [white sugar], [brown sugar], and [cinnamon] together in a small bowl. Sprinkle 1/2 of the cinnamon sugar mixture in the bottom of the prepared baking dish.

Sprinkle remaining cinnamon sugar over butter-brushed dough. Roll dough around filling to form a log; cut log into 18 rolls and place rolls in the prepared baking dish.

5. Bake in the preheated oven until rolls are set, 20 to 25 minutes.

6. Beat [powdered sugar], [cream cheese], 1/4 cup softened [butter], and [vanilla extract] together in a bowl until frosting is smooth. Top hot cinnamon rolls with cream cheese frosting.

## Notes

Don't need as much? Cut the recipe in half and bake for only 15 minutes!
```

## About

Recipe-flavored markdown builds on Dart's [markdown] package by adding syntax extensions and a link resolver.

Unresolved links (such as `- 3 tsp [onion powder]`) are marked as references, allowing developers utilizing this package to determine if the link refers to an ingredient, cooking supply, or even another recipe. Cooking scalars (measurements of time or quantity, such as `30 minutes` or `1/2 tbsp`) are recognized within the markdown document wherever they occur using syntax extensions. Developers utilizing this package can walk through the markdown syntax tree nodes looking for `Scalar` and `Reference` nodes. For example, a `Scalar` node that occurs before a `Reference` node on the same line of text almost certainly represents the quantity for a specific ingredient.

There are other plain text recipe formats, such as the markdown [Grocery Recipe Format] and the plain text format used in [Cooklang], but the author feels these do not read as easily. While the aforementioned formats are more specific, recipe-flavored markdown opts for a more open-ended approach, choosing minimal syntax over rigorous definition. Because of the flexibility of recipe-flavored markdown, applications utilizing this package are left with the complexity of determining what the user meant. The author feels this approach is better than forcing the user to be keenly aware of their recipe syntax. 

By allowing cooking quantities to exist within plain text loosely and exploiting the fact that markdown allows links without explicit url's, we can concoct a simpler, more flexible, and (hopefully) more readable plain text recipe format. The added flexibility allows users to write recipes in a way that is readable to them, while still providing enough information for programmatic analysis.

Recipe-flavored markdown does not insist on a specific syntax for denoting "Ingredients" and "Instructions" sections within recipes, although it is expected the user will likely use some form of heading syntax.

## Usage

To parse markdown-flavored recipe text, add the following code to your project:

```dart
const recipe = '1 3/4 cups [sugar]';

const parser = RecipeMarkdownParser(
  markdown: recipe,
);

final nodes = parser.parse();
```

Like the standard markdown package, `nodes` will have the type `List<Node>`. You can then walk through the nodes, examining their children and looking for the `Scalar` and `Reference` nodes that are specific to recipe-flavored markdown. :)   

For a complete demonstration of how to parse recipe-flavored markdown strings within Dart, see [recipe_markdown_parser_test.dart](test/src/recipe_markdown_parser_test.dart) 

## Credits

Project generated by 🦄 [Very Good CLI].

[coverage-badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[markdown]: https://pub.dev/packages/markdown
[Very Good CLI]: https://pub.dev/packages/very_good_cli
[Grocery Recipe Format]: https://github.com/cnstoll/Grocery-Recipe-Format
[Cooklang]: https://cooklang.org/docs/spec/
