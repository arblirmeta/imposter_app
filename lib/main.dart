import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';

void main() {
  runApp(ImposterApp());
}

class ImposterApp extends StatelessWidget {
  const ImposterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imposter App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.deepPurpleAccent,
        ),
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey[900],
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.deepPurpleAccent,
          inactiveTrackColor: Colors.deepPurple,
          thumbColor: Colors.deepPurpleAccent,
          overlayColor: Colors.deepPurple.withAlpha(32),
          valueIndicatorColor: Colors.deepPurpleAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Imposter Spiel',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.deepPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SetupScreen()),
                  );
                },
                child: Text('Spiel starten'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int playerCount = 4;
  int imposterCount = 1; // Standardwert
  String selectedTopic = "Fußballspieler";
  int roundCount = 5; // Standardwert für die Anzahl der Runden
  String selectedMode = "Klassisch"; // Standardwert für den Spielmodus

  final Map<String, IconData> topicsWithIcons = {
    "Fußballspieler": Icons.sports_soccer,
    "Länder": Icons.public,
    "Musik-Weltstars": Icons.music_note,
    "Superhelden": Icons.shield,
    "Videospiel-Charaktere": Icons.videogame_asset,
    "Berühmte Filme": Icons.movie,
    "Tiere": Icons.pets,
    "Technologie": Icons.computer,
    "Marken": Icons.shopping_bag,
    "Märchenfiguren": Icons.auto_awesome,
    "Wissenschaftler": Icons.science,
    "Essen & Trinken": Icons.restaurant,
    "Sportarten": Icons.sports,
    "Fahrzeuge": Icons.directions_car,
    "Hauptstädte": Icons.location_city,
  };

  final List<String> gameModes = [
    "Klassisch",
    "Timer-Modus",
    "Teams",
    "Nomen",
    "Adjektive",
    "Verben"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spieleranzahl und Thema auswählen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anzahl der Spieler: $playerCount',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Slider(
                        value: playerCount.toDouble(),
                        min: 3,
                        max: 8,
                        divisions: 5,
                        label: playerCount.toString(),
                        onChanged: (double value) {
                          setState(() {
                            playerCount = value.toInt();
                          });
                        },
                      ),
                      if (playerCount >= 5) ...[
                        Text(
                          'Anzahl der Imposter: $imposterCount',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Slider(
                          value: imposterCount.toDouble(),
                          min: 1,
                          max: 3,
                          divisions: 2,
                          label: imposterCount.toString(),
                          onChanged: (double value) {
                            setState(() {
                              imposterCount = value.toInt();
                            });
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anzahl der Runden: $roundCount',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Slider(
                        value: roundCount.toDouble(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label: roundCount.toString(),
                        onChanged: (double value) {
                          setState(() {
                            roundCount = value.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thema auswählen:',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      DropdownButton<String>(
                        value: selectedTopic,
                        items: topicsWithIcons.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Row(
                              children: [
                                Icon(entry.value, color: Colors.deepPurpleAccent),
                                SizedBox(width: 10),
                                Text(entry.key),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedTopic = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Spielmodus auswählen:',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      DropdownButton<String>(
                        value: selectedMode,
                        items: gameModes.map((String mode) {
                          return DropdownMenuItem<String>(
                            value: mode,
                            child: Text(mode),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedMode = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerSetupScreen(
                        playerCount: playerCount,
                        imposterCount: imposterCount,
                        selectedTopic: selectedTopic,
                        roundCount: roundCount,
                        selectedMode: selectedMode,
                      ),
                    ),
                  );
                },
                child: Text('Weiter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerSetupScreen extends StatefulWidget {
  final int playerCount;
  final int imposterCount;
  final String selectedTopic;
  final int roundCount;
  final String selectedMode;

  PlayerSetupScreen({
    required this.playerCount,
    required this.imposterCount,
    required this.selectedTopic,
    required this.roundCount,
    required this.selectedMode,
  });

  @override
  _PlayerSetupScreenState createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  List<String> playerNames = [];
  List<String> teamNames = [];
  List<List<String>> teamPlayers = [];
  int teamCount = 2; // Standardwert für die Anzahl der Teams

  @override
  void initState() {
    super.initState();
    playerNames = List.generate(widget.playerCount, (index) => "Spieler ${index + 1}");
    teamNames = List.generate(teamCount, (index) => "Team ${index + 1}");
    teamPlayers = List.generate(teamCount, (index) => []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spielernamen eingeben'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Spielernamen eingeben:',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.playerCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Spieler ${index + 1}",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        playerNames[index] = value;
                      },
                    ),
                  );
                },
              ),
              if (widget.selectedMode == "Teams") ...[
                SizedBox(height: 20),
                Text(
                  'Anzahl der Teams: $teamCount',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Slider(
                  value: teamCount.toDouble(),
                  min: 2,
                  max: 4,
                  divisions: 2,
                  label: teamCount.toString(),
                  onChanged: (double value) {
                    setState(() {
                      teamCount = value.toInt();
                      teamNames = List.generate(teamCount, (index) => "Team ${index + 1}");
                      teamPlayers = List.generate(teamCount, (index) => []);
                    });
                  },
                ),
                Text(
                  'Teamnamen eingeben:',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: teamCount,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Team ${index + 1}",
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              teamNames[index] = value;
                            },
                          ),
                        ),
                        Text(
                          'Spieler für ${teamNames[index]}:',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        ...List.generate(widget.playerCount, (playerIndex) {
                          return CheckboxListTile(
                            title: Text(playerNames[playerIndex]),
                            value: teamPlayers[index].contains(playerNames[playerIndex]),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  teamPlayers[index].add(playerNames[playerIndex]);
                                } else {
                                  teamPlayers[index].remove(playerNames[playerIndex]);
                                }
                              });
                            },
                          );
                        }),
                      ],
                    );
                  },
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        playerCount: widget.playerCount,
                        imposterCount: widget.imposterCount,
                        topic: widget.selectedTopic,
                        playerNames: playerNames,
                        rounds: widget.roundCount,
                        gameMode: widget.selectedMode, // Übergabe des Spielmodus
                        teamNames: widget.selectedMode == "Teams" ? teamNames : null, // Übergabe der Teamnamen
                        teamPlayers: widget.selectedMode == "Teams" ? teamPlayers : null, // Übergabe der Teamzuordnung
                      ),
                    ),
                  );
                },
                child: Text('Weiter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class FlipCard extends StatefulWidget {
  final String content;
  final VoidCallback onFlipBack;

  const FlipCard({super.key, required this.content, required this.onFlipBack});

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> {
  bool isFlipped = false;

  void flipBack() {
    setState(() {
      isFlipped = false;
    });
    widget.onFlipBack(); // Spielerwechsel auslösen
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFlipped = !isFlipped;

          // Wenn die Karte zurückgeflippt wird, Spielerwechsel auslösen
          if (!isFlipped) {
            widget.onFlipBack();
          }
        });
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final rotate = Tween(begin: pi, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            child: child,
            builder: (context, child) {
              final isUnder = (ValueKey(isFlipped) != child?.key);
              final value = isUnder ? min(rotate.value, pi / 2) : rotate.value;
              return Transform(
                transform: Matrix4.rotationY(value),
                alignment: Alignment.center,
                child: child,
              );
            },
          );
        },
        child: isFlipped
            ? Container(
                key: ValueKey(true),
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  color: widget.content == 'Imposter' ? Colors.red.shade900 : Colors.green.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.content == 'Imposter' ? Icons.warning : Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.content,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              )
            : Container(
                key: ValueKey(false),
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.question_mark,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Karte ziehen',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}


class GameScreen extends StatefulWidget {
  final int playerCount;
  final int imposterCount;
  final String topic;
  final List<String> playerNames;
  final int rounds;
  final String gameMode; // Spielmodus
  final List<String>? teamNames; // Teamnamen für den Team-Modus
  final List<List<String>>? teamPlayers; // Teamzuordnung der Spieler

  GameScreen({
    required this.playerCount,
    required this.imposterCount,
    required this.topic,
    required this.playerNames,
    required this.rounds,
    required this.gameMode,
    this.teamNames,
    this.teamPlayers,
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<String> roles;
  late Map<String, int> scores;
  late Map<String, int> teamScores;
  late List<String> shuffledPlayerNames;
  int currentPlayer = 0;
  int currentRound = 1;
  Timer? timer;
  int timeLeft = 180; // Standardzeit für den Timer-Modus

  @override
  void initState() {
    super.initState();
    roles = generateRoles(widget.playerCount, widget.imposterCount, widget.topic);
    scores = Map.fromEntries(widget.playerNames.map((name) => MapEntry(name, 0)));
    if (widget.gameMode == "Teams" && widget.teamNames != null) {
      teamScores = Map.fromEntries(widget.teamNames!.map((name) => MapEntry(name, 0)));
    }
    shuffledPlayerNames = List.from(widget.playerNames)..shuffle();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          endRound();
        }
      });
    });
  }

  List<String> generateRoles(int playerCount, int imposterCount, String topic) {
    List<String> terms = getTermsForTopic(topic);
    terms.shuffle();

    List<String> roles = List.filled(playerCount - imposterCount, terms[0], growable: true);
    roles.addAll(List.filled(imposterCount, 'Imposter'));
    roles.shuffle();
    return roles;
  }

  List<String> getTermsForTopic(String topic) {
    switch (topic) {
      case "Fußballspieler":
        return [
          "Lionel Messi",
          "Cristiano Ronaldo",
          "Neymar",
          "Kylian Mbappé",
          "Erling Haaland",
          "Luka Modrić",
          "Robert Lewandowski",
          "Karim Benzema",
          "Virgil van Dijk",
          "Kevin De Bruyne",
          "Mohamed Salah",
          "Gianluigi Donnarumma",
          "Harry Kane",
          "Paulo Dybala",
          "Son Heung-min",
          "Sergio Ramos",
          "Thiago Silva",
          "Romelu Lukaku",
          "Antoine Griezmann",
          "Manuel Neuer",
          "Joshua Kimmich",
          "Toni Kroos",
          "Gerard Piqué",
          "Marcus Rashford",
          "Phil Foden",
          "Pedri",
          "Alphonso Davies",
          "Eden Hazard",
          "Joao Félix",
          "Jadon Sancho"
        ];
      case "Länder":
        return [
          "Deutschland",
          "Frankreich",
          "Italien",
          "Spanien",
          "Brasilien",
          "Japan",
          "Argentinien",
          "Kanada",
          "Australien",
          "Indien",
          "USA",
          "Mexiko",
          "Ägypten",
          "Südafrika",
          "Neuseeland",
          "Russland",
          "Türkei",
          "Südkorea",
          "Norwegen",
          "Schweden",
          "Finnland",
          "Island",
          "Saudi-Arabien",
          "Vereinigtes Königreich",
          "Niederlande",
          "Schweiz",
          "Österreich",
          "Polen",
          "Portugal",
          "Griechenland"
        ];
      case "Musik-Weltstars":
        return [
          "Beyoncé",
          "Taylor Swift",
          "Rihanna",
          "Ed Sheeran",
          "Drake",
          "Billie Eilish",
          "Ariana Grande",
          "The Weeknd",
          "Harry Styles",
          "Lady Gaga",
          "Adele",
          "Justin Bieber",
          "Bruno Mars",
          "Dua Lipa",
          "Sam Smith",
          "Shawn Mendes",
          "Olivia Rodrigo",
          "Bad Bunny",
          "Camila Cabello",
          "Selena Gomez",
          "Katy Perry",
          "Post Malone",
          "Doja Cat",
          "SZA",
          "Travis Scott",
          "Nicki Minaj",
          "Cardi B",
          "Eminem",
          "Kanye West",
          "Jay-Z"
        ];
      case "Superhelden":
        return [
          "Batman", "Superman", "Wonder Woman", "Spider-Man", "Iron Man",
          "Thor", "Hulk", "Black Widow", "Captain America", "Doctor Strange",
          "Aquaman", "Green Lantern", "The Flash", "Cyborg", "Wolverine",
          "Deadpool", "Black Panther", "Ant-Man", "Scarlet Witch", "Vision",
          "Shazam", "Hawkeye", "Star-Lord", "Gamora", "Drax",
          "Rocket Raccoon", "Groot", "Beast", "Nightcrawler", "Professor X"
        ];
      case "Videospiel-Charaktere":
        return [
          "Mario", "Luigi", "Link", "Zelda", "Pikachu",
          "Sonic", "Lara Croft", "Master Chief", "Kratos", "Geralt von Riva",
          "Samus Aran", "Pac-Man", "Cloud Strife", "Sephiroth", "Kirby",
          "Donkey Kong", "Fox McCloud", "Solid Snake", "Mega Man", "Ryu",
          "Chun-Li", "Sub-Zero", "Scorpion", "Crash Bandicoot", "Spyro",
          "Yoshi", "Bowser", "Tails", "Shadow the Hedgehog", "Ellie (The Last of Us)"
        ];
      case "Berühmte Filme":
        return [
          "Titanic", "Inception", "Avengers: Endgame", "The Dark Knight", "Forrest Gump",
          "The Matrix", "Pulp Fiction", "The Godfather", "Star Wars", "Jurassic Park",
          "Interstellar", "Schindler's List", "The Shawshank Redemption", "The Lion King", "Frozen",
          "Finding Nemo", "Toy Story", "Gladiator", "The Silence of the Lambs", "Avatar",
          "The Departed", "The Prestige", "Joker", "Django Unchained", "La La Land",
          "The Wolf of Wall Street", "Goodfellas", "The Social Network", "The Avengers", "Black Panther"
        ];
      case "Tiere":
        return [
          "Hund", "Katze", "Elefant", "Giraffe", "Löwe",
          "Tiger", "Panda", "Adler", "Hai", "Delfin",
          "Känguru", "Pinguin", "Nashorn", "Krokodil", "Zebra",
          "Eule", "Bär", "Wolf", "Schlange", "Frosch",
          "Schmetterling", "Wal", "Maus", "Eichhörnchen", "Kaninchen",
          "Fuchs", "Koala", "Strauß", "Otter", "Flamingo"
        ];
      case "Technologie":
        return [
          "Smartphone", "Laptop", "Tablet", "Roboter", "Drohne",
          "Künstliche Intelligenz", "Blockchain", "Smartwatch", "Virtual Reality", "3D-Drucker",
          "Selbstfahrendes Auto", "Augmented Reality", "Satellit", "5G-Netzwerk", "Glasfaser",
          "SSD", "USB-Stick", "Bluetooth", "Router", "Grafikkarte",
          "Prozessor", "Solarpanel", "Laser", "Touchscreen", "Sprachassistent",
          "Webcam", "Smart TV", "Cloud-Computing", "Quantencomputer", "Biometrie"
        ];
      case "Marken":
        return [
          "Apple", "Samsung", "Nike", "Adidas", "Coca-Cola",
          "Google", "Microsoft", "BMW", "Mercedes-Benz", "Tesla",
          "Sony", "Amazon", "Pepsi", "McDonald's", "Puma",
          "Intel", "Louis Vuitton", "Gucci", "Rolex", "Toyota",
          "Lego", "Nestlé", "IKEA", "Volkswagen", "Ferrari",
          "Heineken", "Huawei", "H&M", "Red Bull", "Netflix"
        ];
      case "Märchenfiguren":
        return [
          "Aschenputtel", "Schneewittchen", "Rotkäppchen", "Rapunzel", "Hänsel und Gretel",
          "Der Froschkönig", "Aladdin", "Dornröschen", "Peter Pan", "Pinocchio",
          "Der gestiefelte Kater", "Die kleine Meerjungfrau", "Rumpelstilzchen", "Schneeweißchen und Rosenrot", "Ali Baba",
          "König Midas", "Jack und die Bohnenranke", "Goldlöckchen", "Die sieben Zwerge", "Das tapfere Schneiderlein",
          "Die Hexe Baba Jaga", "Der Prinz", "Die gute Fee", "Der böse Wolf", "Das Biest",
          "Die Eisprinzessin", "Der Zauberer Merlin", "Der fliegende Teppich", "Die Feen", "Der Troll"
        ];
      case "Wissenschaftler":
        return [
          "Albert Einstein", "Isaac Newton", "Marie Curie", "Charles Darwin", "Nikola Tesla",
          "Galileo Galilei", "Stephen Hawking", "Johannes Kepler", "Alexander Fleming", "Ada Lovelace",
          "Gregor Mendel", "Niels Bohr", "James Watson", "Francis Crick", "Michael Faraday",
          "Max Planck", "Erwin Schrödinger", "Richard Feynman", "Carl Sagan", "Rosalind Franklin",
          "Alan Turing", "Rachel Carson", "Edwin Hubble", "Enrico Fermi", "Leonardo da Vinci",
          "Alfred Nobel", "Sigmund Freud", "Pythagoras", "Aristoteles", "Euclid"
        ];
      case "Essen & Trinken":
        return [
          "Pizza", "Burger", "Sushi", "Pasta", "Tacos",
          "Eiscreme", "Kaffee", "Tee", "Schokolade", "Wassermelone",
          "Apfel", "Banane", "Pommes", "Steak", "Sandwich",
          "Salat", "Croissant", "Donut", "Müsli", "Hotdog",
          "Kuchen", "Cupcake", "Spaghetti", "Lasagne", "Curry",
          "Bier", "Wein", "Cocktail", "Wasser", "Limonade"
        ];
      case "Sportarten":
        return [
          "Fußball", "Basketball", "Tennis", "Schwimmen", "Leichtathletik",
          "Baseball", "Boxen", "Skifahren", "Golf", "Rugby",
          "Eishockey", "Volleyball", "Badminton", "Turnen", "Handball",
          "Klettern", "Radsport", "Tischtennis", "Segeln", "Cricket",
          "Snowboarden", "Pferderennen", "Triathlon", "Surfen", "Laufen",
          "Ringen", "Bogenschießen", "Fechten", "Motorsport", "Kickboxen"
        ];
      case "Fahrzeuge":
        return [
          "Auto", "Motorrad", "Zug", "Flugzeug", "Schiff",
          "Fahrrad", "Bus", "Traktor", "Helikopter", "Sportwagen",
          "SUV", "Cabrio", "Limousine", "Lastwagen", "U-Bahn",
          "Elektroauto", "Segelboot", "Rennwagen", "Quad", "Bulldozer",
          "Kutsche", "Raumschiff", "Monstertruck", "Moped", "Tankwagen",
          "Ambulanz", "Polizeiauto", "Feuerwehrauto", "Kran", "Roller"
        ];
      case "Hauptstädte":
        return [
          "Berlin", "Paris", "London", "Madrid", "Rom",
          "Tokio", "Washington, D.C.", "Ottawa", "Canberra", "Brasília",
          "Moskau", "Peking", "Seoul", "Delhi", "Bangkok",
          "Wien", "Bern", "Amsterdam", "Brüssel", "Oslo",
          "Stockholm", "Helsinki", "Kopenhagen", "Dublin", "Reykjavik",
          "Lissabon", "Athen", "Prag", "Budapest", "Warschau"
        ];
      default:
        return ["Unbekanntes Thema"];
    }
  }


  void endRound() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wer hat gewonnen?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Dialog schließen
                  setState(() {
                    // Punkte für Imposter hinzufügen
                    for (int i = 0; i < widget.playerCount; i++) {
                      if (roles[i] == 'Imposter') {
                        scores[widget.playerNames[i]] = scores[widget.playerNames[i]]! + 2;
                        if (widget.gameMode == "Teams" && widget.teamNames != null && widget.teamPlayers != null) {
                          for (int teamIndex = 0; teamIndex < widget.teamPlayers!.length; teamIndex++) {
                            if (widget.teamPlayers![teamIndex].contains(widget.playerNames[i])) {
                              teamScores[widget.teamNames![teamIndex]] =
                                  teamScores[widget.teamNames![teamIndex]]! + 2;
                            }
                          }
                        }
                      }
                    }

                    prepareNextRound();
                  });
                },
                child: Text('Imposter hat gewonnen'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Dialog schließen
                  setState(() {
                    // Punkte für die anderen Spieler hinzufügen
                    for (int i = 0; i < widget.playerCount; i++) {
                      if (roles[i] != 'Imposter') {
                        scores[widget.playerNames[i]] = scores[widget.playerNames[i]]! + 1;
                        if (widget.gameMode == "Teams" && widget.teamNames != null && widget.teamPlayers != null) {
                          for (int teamIndex = 0; teamIndex < widget.teamPlayers!.length; teamIndex++) {
                            if (widget.teamPlayers![teamIndex].contains(widget.playerNames[i])) {
                              teamScores[widget.teamNames![teamIndex]] =
                                  teamScores[widget.teamNames![teamIndex]]! + 1;
                            }
                          }
                        }
                      }
                    }

                    prepareNextRound();
                  });
                },
                child: Text('Die anderen Spieler haben gewonnen'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ),
        );
      },
    );
  }

  void prepareNextRound() {
    if (currentRound < widget.rounds) {
      // Vorbereitung für die nächste Runde
      currentRound++;
      roles = generateRoles(widget.playerCount, widget.imposterCount, widget.topic);
      currentPlayer = 0;
      timeLeft = 180; // Setze den Timer auf 180 Sekunden zurück
      shuffledPlayerNames.shuffle(); // Spielerreihenfolge für die nächste Runde neu mischen
    } else {
      // Spielende, zur ScoreScreen navigieren
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(
            scores: scores,
            teamScores: widget.gameMode == "Teams" ? teamScores : null,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Runde $currentRound / ${widget.rounds}'),
      ),
      body: Center(
        child: currentPlayer < widget.playerCount
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Spieler ${shuffledPlayerNames[currentPlayer]}, ziehe deine Karte:',
                    style: TextStyle(fontSize: 20),
                  ),
                  FlipCard(
                    content: roles[currentPlayer],
                    onFlipBack: () {
                      setState(() {
                        currentPlayer++;
                        if (currentPlayer == widget.playerCount) {
                          if (widget.gameMode == "Timer-Modus") {
                            startTimer();
                          }
                        }
                      });
                    },
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.gameMode == "Timer-Modus") ...[
                    Text(
                      'Zeit übrig: $timeLeft Sekunden',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    LinearProgressIndicator(
                      value: timeLeft / 180,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ],
                  ElevatedButton(
                    onPressed: endRound, // Aufruf der neuen Methode
                    child: Text('Runde beenden'),
                  ),
                ],
              ),
      ),
    );
  }
}

class ScoreScreen extends StatelessWidget {
  final Map<String, int> scores;
  final Map<String, int>? teamScores;

  ScoreScreen({super.key, required this.scores, this.teamScores});

  final List<String> endRoundMessages = [
    'hat euch in den Boden gestampft!',
    'hat euch alle besiegt!',
    'hat das Spiel dominiert!',
    'hat euch alle überlistet!',
    'hat euch alle ausgetrickst!',
    'hat das Spiel gewonnen!',
    'hat euch alle geschlagen!',
    'hat euch alle übertroffen!',
    'hat euch alle überlistet!',
    'hat euch alle überrascht!',
  ];

  final List<String> tieMessages = [
    'Es ist ein Unentschieden!',
    'Keiner hat gewonnen!',
    'Das Spiel endet unentschieden!',
    'Niemand hat dominiert!',
    'Es gibt keinen Sieger!',
  ];

  String getRandomEndRoundMessage() {
    final random = Random();
    return endRoundMessages[random.nextInt(endRoundMessages.length)];
  }

  String getRandomTieMessage() {
    final random = Random();
    return tieMessages[random.nextInt(tieMessages.length)];
  }

  @override
  Widget build(BuildContext context) {
    final sortedScores = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final highestScore = sortedScores.first.value;
    final winners = sortedScores.where((entry) => entry.value == highestScore).toList();

    String message;
    if (winners.length > 1) {
      message = getRandomTieMessage();
    } else {
      message = '${winners.first.key} ${getRandomEndRoundMessage()}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ergebnisse'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sortedScores.length,
              itemBuilder: (context, index) {
                final entry = sortedScores[index];
                return ListTile(
                  title: Text(entry.key),
                  trailing: Text('${entry.value} Punkte'),
                );
              },
            ),
          ),
          if (teamScores != null) ...[
            Divider(),
            Text(
              'Team-Ergebnisse',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: teamScores!.length,
                itemBuilder: (context, index) {
                  final entry = teamScores!.entries.toList()[index];
                  return ListTile(
                    title: Text(entry.key),
                    trailing: Text('${entry.value} Punkte'),
                  );
                },
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: Text('Zurück zur Themenauswahl'),
          ),
        ],
      ),
    );
  }
}