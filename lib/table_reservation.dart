import 'package:flutter/material.dart';
import 'package:restrospt/booking_manager.dart';
import 'package:restrospt/dashborad_screen.dart';
import 'package:restrospt/my_bookings.dart';

class TableReservationScreen extends StatefulWidget {
  final String restaurantName;
  final String imagePath;
  final double rating;
  final String hours;

  const TableReservationScreen({
    super.key,
    required this.restaurantName,
    required this.imagePath,
    this.rating = 4.4,
    this.hours = '8 am to 10 pm',
  });

  @override
  State<TableReservationScreen> createState() => _TableReservationScreenState();
}

class _TableReservationScreenState extends State<TableReservationScreen> {
  final BookingManager _bookingManager = BookingManager();
  DateTime _selectedDate = DateTime.now();
  int? _selectedTable;
  String? _selectedTime;

  final List<String> _timeSlots = const [
    '8 am',
    '10 am',
    '12 pm',
    '3 pm',
    '5 pm',
    '7 pm',
    '8 pm',
    '9 pm',
    '9:30 pm',
    '10 pm',
  ];

  // Get booked tables for a given date/time from booking manager
  Set<int> _bookedTablesFor(DateTime date, String? time) {
    if (time == null || time.isEmpty) return {};
    return _bookingManager.getBookedTables(date, time);
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate.isBefore(DateTime(today.year, today.month, today.day))
          ? today
          : _selectedDate,
      firstDate: DateTime(
        today.year,
        today.month,
        today.day,
      ), // disallow past dates
      lastDate: DateTime(today.year + 1),
      helpText: 'Select reservation date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Colors.deepOrange),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        // Reset selections when date changes
        _selectedTable = null;
        _selectedTime = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Colors.deepOrange;
    final booked = _bookedTablesFor(_selectedDate, _selectedTime);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Table Resrvation',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date chip
            Center(
              child: GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.event, size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Date : ${_formatDate(_selectedDate)}',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Restaurant card
            _buildRestaurantHeader(primary),
            const SizedBox(height: 16),

            // Choose Table
            _sectionTitle('Choose Table'),
            _boxed(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(10, (i) {
                  final tableNo = i + 1;
                  final isBooked = booked.contains(tableNo);
                  final isSelected = _selectedTable == tableNo;
                  final bg = isBooked
                      ? Colors.red.shade400
                      : isSelected
                      ? Colors.green.shade400
                      : Colors.grey.shade300;
                  final fg = isBooked || isSelected
                      ? Colors.white
                      : Colors.black87;
                  return _pillButton(
                    label: 'Table -$tableNo',
                    background: bg,
                    foreground: fg,
                    onTap: isBooked
                        ? null
                        : () => setState(() => _selectedTable = tableNo),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),

            // Choose Time
            _sectionTitle('Choose Time'),
            _boxed(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _timeSlots.map((slot) {
                  final isSelected = _selectedTime == slot;
                  return _pillButton(
                    label: slot,
                    background: isSelected
                        ? Colors.green.shade400
                        : Colors.grey.shade300,
                    foreground: isSelected ? Colors.white : Colors.black87,
                    onTap: () => setState(() => _selectedTime = slot),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Summary
            Text(
              widget.restaurantName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              'Date : ${_formatDate(_selectedDate)}   Table no. ${_selectedTable ?? '-'}   Time: ${_selectedTime ?? '-'}',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Reserve button
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: _canReserve(booked)
                      ? () {
                          // Save booking
                          final newBooking = BookingModel(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            restaurantName: widget.restaurantName,
                            imagePath: widget.imagePath,
                            date: _selectedDate,
                            tableNo: _selectedTable!,
                            time: _selectedTime!,
                            rating: widget.rating,
                            hours: widget.hours,
                          );
                          _bookingManager.addBooking(newBooking);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Reserved table ${_selectedTable!} at ${_selectedTime!} on ${_formatDate(_selectedDate)}',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );

                          // Navigate back to dashboard
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DashboardScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      : null,
                  child: const Text(
                    'Reserve Table',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canReserve(Set<int> booked) {
    final today = DateTime.now();
    final isPastDate = _selectedDate.isBefore(
      DateTime(today.year, today.month, today.day),
    );
    final valid =
        !isPastDate &&
        _selectedTable != null &&
        _selectedTime != null &&
        !booked.contains(_selectedTable);
    return valid;
  }

  Widget _buildRestaurantHeader(Color primary) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              widget.imagePath,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.restaurantName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Review : ',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        Text(
                          widget.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Open : ${widget.hours}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    ),
  );

  Widget _boxed({required Widget child}) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.deepOrange.shade200),
    ),
    child: child,
  );

  Widget _pillButton({
    required String label,
    required Color background,
    required Color foreground,
    required VoidCallback? onTap,
  }) {
    return Opacity(
      opacity: onTap == null ? 0.6 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(color: foreground, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final d = date.day.toString().padLeft(2, '0');
    final m = months[date.month - 1];
    final y = date.year.toString();
    return '$d/$m/$y';
  }
}
