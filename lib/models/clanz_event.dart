class ClanzEvent {
  String name;
  String icon;
  String game;
  List<String> participants;
  DateTime date;
  String description;
  String creator;
  String id;

  ClanzEvent(
      {this.name,
      this.icon,
      this.game,
      this.participants,
      this.date,
      this.description,
      this.creator});

  Map<String, dynamic> toJson() => {
        'name': name,
        'icon': icon,
        'game': game,
        'date': date,
        'description': description,
        'creator': creator,
      };

  ClanzEvent.fromJson(Map parsedJson) {
    id = parsedJson['id'] ?? '';
    game = parsedJson['game'] ?? '';
    name = parsedJson['name'] ?? '';
    icon = parsedJson['icon'] ?? '';
    date = DateTime.now(); //DateTime.parse(parsedJson['date']) ?? DateTime.now();
    description = parsedJson['description'] ?? '';
    creator = parsedJson['creator'] ?? '';
    participants = List();// parsedJson['participants'] ?? '';
  }
}
