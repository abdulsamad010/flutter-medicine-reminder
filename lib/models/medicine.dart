class Medicine {
  int? id;
  String name;
  String personName;
  String dosage;
  String reminderTime;
  String createdAt;

  Medicine({
    this.id,
    required this.name,
    required this.personName,
    required this.dosage,
    required this.reminderTime,
    required this.createdAt,
  });
}