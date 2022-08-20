const String tableEvents = 'events';

class EventFields {
  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String date = 'date';
  static const String type = 'type';
  static const String amount = 'amount';
}

class Event {
  int? id;
  String title;
  String des;
  DateTime date;
  String type;
  String amount;

  Event({
    this.id,
    required this.title,
    required this.des,
    required this.date,
    required this.type,
    required this.amount});

  static Event fromJson(Map<String, dynamic> json) => Event(
      id: json[EventFields.id],
      title: json[EventFields.title],
      des: json[EventFields.description],
      date: DateTime.parse(json[EventFields.date]),
      type: json[EventFields.type],
      amount: json[EventFields.amount]
  );

  Map<String, dynamic> toJson() => {
    EventFields.id: id,
    EventFields.title: title,
    EventFields.description: des,
    EventFields.date: date.toIso8601String(),
    EventFields.type: type,
    EventFields.amount: amount,
  };

  Event copy({
    int? id,
    String? title,
    String? des,
    DateTime? date,
    String? type,
    String? amount,
  }) => Event(
      id: id?? this.id,
      title: title?? this.title,
      des: des?? this.des,
      date: date?? this.date,
      type: type?? this.type,
      amount: amount?? this.amount
  );
}
