import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
// import 'package:flutter/services.dart';
import 'package:pokedex/model/pokemen.dart';

class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;

  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  PaletteGenerator paletteGenerator;
  Color baskinrenk;
  Color dominantrenk;

  @override
  void initState() {
    super.initState();
    baskinRenkBul();
  }

  void baskinRenkBul() {
    Future<PaletteGenerator> fGenerator =
        PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img));
    fGenerator.then((value) {
      paletteGenerator = value;
      setState(() {
        baskinrenk = paletteGenerator.vibrantColor.color;
        if (baskinrenk == null) {
          baskinrenk = paletteGenerator.lightMutedColor.color;
        }
        dominantrenk = paletteGenerator.dominantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitDown]);
    return Scaffold(
      backgroundColor: baskinrenk,
      appBar: AppBar(
        backgroundColor: dominantrenk,
        elevation: 0,
        title: Text(
          widget.pokemon.name,
          textAlign: TextAlign.center,
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return dikeyBody(context);
          } else {
            return yatayBody(context);
          }
        },
      ),
    );
  }

  dikeyBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height * (3 / 4),
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          // right: 10,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                Text(widget.pokemon.name),
                Text("Y??kseklik = " + widget.pokemon.height),
                Text("A????rl??k = " + widget.pokemon.weight),
                Text(
                  "Tip",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.type
                      .map((tip) => Chip(
                            backgroundColor: Colors.blue.shade300,
                            label: Text(
                              tip,
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                ),
                Text(
                  "??nceki Evrimi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.prevEvolution != null
                      ? widget.pokemon.prevEvolution
                          .map((prevEvolution) => Chip(
                                backgroundColor: Colors.blue.shade300,
                                label: Text(
                                  prevEvolution.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList()
                      : [
                          Text(
                            "??lk Hali",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                ),
                Text(
                  "Sonraki Evrimi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.nextEvolution != null
                      ? widget.pokemon.nextEvolution
                          .map((evolation) => Chip(
                                backgroundColor: Colors.blue.shade300,
                                label: Text(
                                  evolation.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList()
                      : [
                          Text(
                            "Son Hali",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                ),
                Text(
                  "Zay??fl??klar??",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.weaknesses != null
                      ? widget.pokemon.weaknesses
                          .map((weaknesses) => Chip(
                                backgroundColor: Colors.blue.shade300,
                                label: Text(
                                  weaknesses,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList()
                      : [
                          Text(
                            "Zay??fl?????? yok",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon.img,
            child: Container(
              height: 200,
              width: 200,
              child: Image.network(
                widget.pokemon.img,
                fit: BoxFit.fill,
              ),
            ),
          ),
        )
      ],
    );
  }

  yatayBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * (3 / 4),
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          border: Border.all(color: Colors.white)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                // height: 150,
                width: 200,
                child: Image.network(
                  widget.pokemon.img,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.pokemon.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Y??kseklik = " + widget.pokemon.height),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("A????rl??k = " + widget.pokemon.weight),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Tip",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type
                        .map((tip) => Chip(
                              backgroundColor: Colors.blue.shade300,
                              label: Text(
                                tip,
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "??nceki Evrimi",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.prevEvolution != null
                        ? widget.pokemon.prevEvolution
                            .map((prevEvolution) => Chip(
                                  backgroundColor: Colors.blue.shade300,
                                  label: Text(
                                    prevEvolution.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList()
                        : [
                            Text(
                              "??lk Hali",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Sonraki Evrimi",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                            .map((evolation) => Chip(
                                  backgroundColor: Colors.blue.shade300,
                                  label: Text(
                                    evolation.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList()
                        : [
                            Text(
                              "Son Hali",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Zay??fl??klar??",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses != null
                        ? widget.pokemon.weaknesses
                            .map((weaknesses) => Chip(
                                  backgroundColor: Colors.blue.shade300,
                                  label: Text(
                                    weaknesses,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList()
                        : [
                            Text(
                              "Zay??fl?????? yok",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
