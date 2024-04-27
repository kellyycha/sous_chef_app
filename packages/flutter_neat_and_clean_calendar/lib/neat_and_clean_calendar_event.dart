class NeatCleanCalendarEvent {
  int id;
  String title;
  int qty;
  DateTime expirationDate;
  String? image;

  NeatCleanCalendarEvent({
    required this.id,
    required this.title, 
    required this.qty,
    required this.expirationDate,
    this.image,
  });
}
