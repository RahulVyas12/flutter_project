import 'package:restrospt/my_bookings.dart';

/// Simple in-memory booking manager
/// In production, replace with backend API calls or local database
class BookingManager {
  static final BookingManager _instance = BookingManager._internal();
  factory BookingManager() => _instance;
  BookingManager._internal();

  final List<BookingModel> _bookings = [
    // Past booking - user can rate this
    BookingModel(
      id: '0',
      restaurantName: 'Golden Spot Restorant',
      imagePath: 'assets/restaurant.jpg',
      date: DateTime(2025, 10, 1),
      tableNo: 5,
      time: '8 pm',
      rating: 4.4,
      hours: '8 am to 10 pm',
    ),
    // Future bookings
    BookingModel(
      id: '1',
      restaurantName: 'Golden Spot Restorant',
      imagePath: 'assets/restaurant.jpg',
      date: DateTime(2025, 10, 15),
      tableNo: 3,
      time: '9:30 pm',
      rating: 4.4,
      hours: '8 am to 10 pm',
    ),
    BookingModel(
      id: '2',
      restaurantName: 'Golden Spot Restorant',
      imagePath: 'assets/restaurant.jpg',
      date: DateTime(2025, 10, 20),
      tableNo: 7,
      time: '7 pm',
      rating: 4.4,
      hours: '8 am to 10 pm',
    ),
  ];

  List<BookingModel> get bookings => List.unmodifiable(_bookings);

  void addBooking(BookingModel booking) {
    _bookings.add(booking);
  }

  void cancelBooking(String bookingId) {
    _bookings.removeWhere((b) => b.id == bookingId);
  }

  bool isTableBooked(DateTime date, int tableNo, String time) {
    return _bookings.any((b) =>
        b.date.year == date.year &&
        b.date.month == date.month &&
        b.date.day == date.day &&
        b.tableNo == tableNo &&
        b.time == time);
  }

  Set<int> getBookedTables(DateTime date, String time) {
    return _bookings
        .where((b) =>
            b.date.year == date.year &&
            b.date.month == date.month &&
            b.date.day == date.day &&
            b.time == time)
        .map((b) => b.tableNo)
        .toSet();
  }
}
