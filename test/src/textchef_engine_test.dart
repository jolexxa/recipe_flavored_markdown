// ignore_for_file: prefer_const_constructors
import 'package:markdown/markdown.dart';
import 'package:test/test.dart';
import 'package:textchef_engine/textchef_engine.dart';

void main() {
  const recipe = '''
# Ingredients

## Dough

- 2 cups all-purpose [flour]
- 2 tbsp [white sugar]
- 2 tsp [baking powder]
- 1 tsp [salt]
- 3 tbsp [butter], softened
- 3/4 cup [milk]
- 1 [egg]

## Filling

- 1/2 cup [white sugar]
- 1/2 cup [brown sugar]
- 1 tbsp [ground cinnamon]

## Cream Cheese Frosting

- 1 cup [powdered sugar]
- 4 oz [cream cheese], softened
- 1/4 cup [butter], softened
- 1/2 tsp vanilla extract

# Instructions

1. Preheat oven to 400 degrees. Brush a [9" baking dish] with 2 tbsp [butter].
2. Whisk [flour], 2 tbsp [white sugar], [baking powder], and [salt] together in a large bowl.
3. Work 3 tbsp softened [butter] into [flour] mixture using your hands. Beat [milk] and [egg] together in another bowl; pour into flour-butter mixture and stir with a spatula until a soft dough forms.
4. Whisk 1/2 cup [white sugar], [brown sugar], and cinnamon together in a small bowl. Sprinkle 1/2 of the cinnamon sugar mixture in the bottom of the prepared baking dish. Sprinkle remaining cinnamon sugar over butter-brushed dough. Roll dough around filling to form a log; cut log into 18 rolls and place rolls in the prepared baking dish.
5. Bake in the preheated oven until rolls are set, 20 to 25 minutes.
6. Beat [powdered sugar], [cream cheese], 1/4 cup softened [butter], and [vanilla extract] together in a bowl until frosting is smooth. Top hot cinnamon rolls with cream cheese frosting.

# Notes
Don't need as much? Cut the recipe in half and bake for only 15 minutes!
''';
  group('TextchefEngine', () {
    test('can be instantiated', () {
      expect(RecipeEngine(markdown: ''), isNotNull);
    });

    test('returns parsed nodes', () {
      final engine = RecipeEngine(markdown: recipe);
      final results = engine.parse();
      expect(results, isA<List<Node>>());
    });
  });
}
