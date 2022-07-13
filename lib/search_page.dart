import 'package:flutter/material.dart';
import 'games.dart';
import 'package:search_page/search_page.dart';

class SearchingPage extends StatelessWidget {
  const SearchingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: demogames.length,
        itemBuilder: (context, index) {
          final Game game = demogames[index];
          return ListTile(
            title: Text(game.name),
            subtitle: Text(game.categories.toString()),
            trailing: Text('${game.price} \$'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 113, 65, 148),
        tooltip: 'Search Games',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Game>(
            onQueryUpdate: (s) => print(s),
            items: demogames,
            searchLabel: 'Search Games',
            suggestion: Center(
              child: Text("Filter by title, category or price"),
            ),
            failure: Center(
              child: Text("No game found"),
            ),
            filter: (game) => [
              game.name,
              game.categories.toString(),
              game.price.toString(),
            ],
            builder: (game) => ListTile(
              title: Text(game.name),
              subtitle: Text(game.categories.toString()),
              trailing: Text(game.price.toString() + "\$"),
            ),
          ),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}
