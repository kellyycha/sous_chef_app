class NeatCleanCalendarEvent {
  String title;
  int qty;
  DateTime expirationDate;
  String? image;

  NeatCleanCalendarEvent({
    required this.title, 
    required this.qty,
    required this.expirationDate,
    this.image,
  });
}
