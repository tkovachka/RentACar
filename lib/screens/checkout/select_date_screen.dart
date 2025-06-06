import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_a_car/services/booking_service.dart';
import 'package:rent_a_car/widgets/buttons/custom_button.dart';
import 'package:rent_a_car/widgets/buttons/text_filter_button.dart';
import 'package:rent_a_car/widgets/text/custom_text.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rent_a_car/models/booking.dart';
import 'package:rent_a_car/models/car.dart';

class SelectDateScreen extends StatefulWidget {
  final Car car;

  const SelectDateScreen({super.key, required this.car});

  @override
  _SelectDateScreenState createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  final BookingsService _bookingsService = BookingsService();
  Set<DateTime> _unavailableDates = {};

  DateTimeRange? _dateRange;
  DateTime _focusedDay = DateTime.now();
  String? _pickupTime;
  double totalPrice = 0.0;

  Car get car => widget.car;

  @override
  void initState() {
    super.initState();
    _loadUnavailableDates();
  }

  Future<void> _loadUnavailableDates() async {
    final dates = await _bookingsService.getUnavailableDatesForCar(car.id);
    setState(() {
      final today = DateTime.now();
      final todayNormalized = DateTime(today.year, today.month, today.day);
      _unavailableDates = dates..add(todayNormalized);
    });
  }

  double _calculateTotalPrice() {
    if (_dateRange != null) {
      final days = _dateRange!.end.difference(_dateRange!.start).inDays;
      return days * car.pricePerDay.toDouble();
    }
    return 0.0;
  }

  bool _isDateBlocked(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    return _unavailableDates.contains(d);
  }

  bool _isRangeBlocked(DateTime start, DateTime end) {
    DateTime current = start;
    while (!current.isAfter(end)) {
      if (_unavailableDates
          .contains(DateTime(current.year, current.month, current.day))) {
        return true;
      }
      current = current.add(const Duration(days: 1));
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleText(text: "Dates"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SubtitleText(
                          text:
                              "Select from the available dates. You only need to select the start and end date"),
                      SizedBox(
                        height: 350,
                        child: TableCalendar(
                          focusedDay: _focusedDay,
                          firstDay: DateTime.now(),
                          lastDay: DateTime(2100),
                          rangeStartDay: _dateRange?.start,
                          rangeEndDay: _dateRange?.end,
                          rangeSelectionMode: RangeSelectionMode.toggledOn,
                          onPageChanged: (newFocusedDay) {
                            setState(() {
                              _focusedDay = newFocusedDay;
                            });
                          },
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            leftChevronVisible: false,
                            rightChevronVisible: false,
                          ),
                          enabledDayPredicate: (day) => !_isDateBlocked(day),
                          onRangeSelected: (start, end, newFocusedDay) {
                            if (start != null &&
                                end != null &&
                                !_isRangeBlocked(start, end)) {
                              setState(() {
                                _dateRange = DateTimeRange(
                                  start: start.isBefore(end) ? start : end,
                                  end: start.isBefore(end) ? end : start,
                                );
                                _focusedDay = newFocusedDay;
                              });
                            }
                          },
                          calendarFormat: CalendarFormat.month,
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: Colors.purple.shade100,
                              shape: BoxShape.circle,
                            ),
                            rangeStartDecoration: const BoxDecoration(
                              color: Colors.purple,
                              shape: BoxShape.circle,
                            ),
                            rangeEndDecoration: const BoxDecoration(
                              color: Colors.purple,
                              shape: BoxShape.circle,
                            ),
                            rangeHighlightColor: Colors.purple.shade50,
                            outsideDaysVisible: true,
                          ),
                          calendarBuilders: CalendarBuilders(
                            defaultBuilder: (context, day, focusedDay) {
                              final normalized =
                                  DateTime(day.year, day.month, day.day);
                              if (_unavailableDates.contains(normalized)) {
                                return Center(
                                  child: Text(
                                    '${day.day}',
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
                                  ),
                                );
                              }
                              return null;
                            },
                            disabledBuilder: (context, day, focusedDay) {
                              return Center(
                                child: Text(
                                  '${day.day}',
                                  style: TextStyle(color: Colors.grey.shade400),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const NormalText(text: 'Total price:'),
                          const SizedBox(width: 8,),
                          LinkText(size: 20,
                              text:
                              '\$${_calculateTotalPrice().toStringAsFixed(2)}')
                        ],
                      ),
                      const SizedBox(height: 16),
                      const NormalText(text: 'Pick-up Time:'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          TextFilterButton(
                              label: 'Morning',
                              isSelected: _pickupTime == 'Morning',
                              onTap: () {
                                setState(() {
                                  _pickupTime = 'Morning';
                                });
                              }),
                          const SizedBox(
                            width: 8,
                          ),
                          TextFilterButton(
                              label: 'Evening',
                              isSelected: _pickupTime == 'Evening',
                              onTap: () {
                                setState(() {
                                  _pickupTime = 'Evening';
                                });
                              }),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            text: 'Next',
                            onPressed: () async {
                              if (_dateRange == null || _pickupTime == null) {
                                return;
                              }

                              if (_isRangeBlocked(
                                  _dateRange!.start, _dateRange!.end)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Selected range contains unavailable dates.")),
                                );
                                return;
                              }

                              final booking = Booking(
                                id: '',
                                //overwritten in service
                                carId: car.id,
                                userId: '',
                                //overwritten in service
                                startDate: _dateRange!.start,
                                endDate: _dateRange!.end,
                                pickupTime: _pickupTime!,
                                createdAt: Timestamp.now(),
                              );

                              await _bookingsService.addBooking(booking);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Booking saved successfully")),
                              );

                              Navigator.pushNamed(context, '/checkout');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
