import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/pokemen.dart';
import 'package:pokedex/pokemon_detail.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex pokedex;
  Future<Pokedex> veri;

  Future<Pokedex> getPokemons() async {
    var response = await http.get(url);
    var decodeJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(decodeJson);
    return pokedex;
  }

  @override
  void initState() {
    super.initState();
    veri = getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pokedex"),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return FutureBuilder(
                future: veri,
                builder: (BuildContext context,
                    AsyncSnapshot<Pokedex> gelenPokedex) {
                  if (gelenPokedex.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (gelenPokedex.connectionState ==
                      ConnectionState.done) {
                    // return GridView.builder(
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //   ),
                    //   itemBuilder: (context, index) {
                    //     return Text(gelenPokedex.data.pokemon[index].name);
                    //   },
                    // );
                    return GridView.count(
                      crossAxisCount: 2,
                      children: gelenPokedex.data.pokemon.map((poke) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PokemonDetail(
                                      pokemon: poke,
                                    )));
                          },
                          child: Hero(
                              tag: poke.img,
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 150,
                                      width: 200,
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/image/preloader.gif",
                                        image: poke.img,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      poke.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              )),
                        );
                      }).toList(),
                    );
                  }
                  // else {}
                },
              );
            } else {
              return FutureBuilder(
                future: veri,
                builder: (BuildContext context,
                    AsyncSnapshot<Pokedex> gelenPokedex) {
                  if (gelenPokedex.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (gelenPokedex.connectionState ==
                      ConnectionState.done) {
                    return GridView.extent(
                      maxCrossAxisExtent: 300,
                      children: gelenPokedex.data.pokemon.map((poke) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PokemonDetail(
                                      pokemon: poke,
                                    )));
                          },
                          child: Hero(
                              tag: poke.img,
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: 150,
                                        // width: 150,
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              "assets/image/preloader.gif",
                                          image: poke.img,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      poke.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              )),
                        );
                      }).toList(),
                    );
                  }
                  // else {}
                },
              );
            }
          },
        ));
  }
}
