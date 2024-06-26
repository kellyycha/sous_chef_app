// ignore_for_file: deprecated_member_use_from_same_package, deprecated_member_use, depend_on_referenced_packages

library flutter_neat_and_clean_calendar;

import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/date_picker_config.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import './date_utils.dart';
import './simple_gesture_detector.dart';
import './calendar_tile.dart';
import './neat_and_clean_calendar_event.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// Export NeatCleanCalendarEvent for using it in the application
export './neat_and_clean_calendar_event.dart';

typedef DayBuilder = Function(BuildContext context, DateTime day);
typedef EventListBuilder = Function(BuildContext context, List<NeatCleanCalendarEvent> events);

enum DatePickerType { hidden, date }

class Range {
  final DateTime from;
  final DateTime to;
  Range(this.from, this.to);
}

/// Clean Calndar's main class [Calendar]
///
/// This calls is responisble for controlling the look of the calnedar display as well
/// as the action taken, when changing the month or tapping a date. It's higly configurable
/// with its numerous properties.
///
/// [onDateSelected] is of type [ValueChanged<DateTime>] and it containes the callback function
///     extecuted when tapping a date
/// [onMonthChanged] is of type [ValueChanged<DateTime>] and it containes the callback function
///     extecuted when changing to another month
/// [onExpandStateChanged] is of type [ValueChanged<bool>] and it contains a callback function
///     executed when the view changes to expanded or to condensed
/// [onRangeSelected] contains a callback function of type [ValueChanged], that gets called on changes
///     of the range (switch to next or previous week or month)
/// [onEventSelected] is of type [ValueChanged<NeatCleanCalendarEvent>] and it contains a callback function
///     executed when an event of the event list is selected
/// [onEventLongPressed] is of type [ValueChanged<NeatCleanCalendarEvent>] and it contains a callback function
///     executed when an event of the event list is long pressed
/// [datePickerType] defines, if the date picker should get displayed and selects its type
///    Choose between datePickerType.hidden, datePickerType.date
/// [isExpandable] is a [bool]. With this parameter you can control, if the view can expand from week view
///     to month view. Default is [false].
/// [dayBuilder] can contain a [Widget]. If this property is not null (!= null), this widget will get used to
///     render the calenar tiles (so you can customize the view)
/// [eventListBuilder] can optionally contain a [Widget] that gets used to render the event list
/// [hideArrows] is a bool. When set to [true] the arrows to navigate to the next or previous week/month in the
///     top bar well get suppressed. Default is [false].
/// [hideTodayIcon] is a bool. When set to [true] the dispaly of the Today-Icon (button to navigate to today) in the
///     top bar well get suppressed. Default is [false].
/// [hideBottomBar] at the moment has no function. Default is [false].
/// [events] are of type [Map<DateTime, List<NeatCleanCalendarEvent>>]. This data structure contains the events to display
/// [defaultDayColor] is the color applied to days in the current month, that are not selected.
/// [defaultOutOfMonthDayColor] is the color applied to days outside the current month.
/// [selectedColor] this is the color, applied to the circle on the selected day
/// [selectedTodayColor] is the color, applied to the circle on the selected day, if it is today
/// [todayColor] this is the color of the date of today
/// [todayButtonText] is a [String]. With this property you can set the caption of the today icon (button to navigate to today).
///     If left empty, the calendar will use the string "Today".
/// [allDayEventText] is a [String]. With this property you can set the caption of the all day event. If left empty, the
///     calendar will use the string "All day".
/// [multiDayEndText] is a [String]. With this property you can set the caption of the end of a multi day event. If left empty, the
///    calendar will use the string "End".
/// [eventColor] lets you optionally specify the color of the event (dot). If the [CleanCaendarEvents] property color is not set, the
///     calendar will use this parameter.
/// [eventDoneColor] with this property you can define the color of "done" events, that is events in the past.
/// [initialDate] is of type [DateTime]. It can contain an optional start date. This is the day, that gets initially selected
///     by the calendar. The default is to not set this parameter. Then the calendar uses [DateTime.now()]
/// [isExpanded] is a bool. If is us set to [true], the calendar gets rendered in month view.
/// [weekDays] contains a [List<String>] defining the names of the week days, so that it is possible to name them according
///     to your current locale.
/// [locale] is a [String]. This setting gets used to format dates according to the current locale.
/// [startOnMonday] is a [bool]. This parameter allows the calendar to determine the first day of the week.
/// [dayOfWeekStyle] is a [TextStyle] for styling the text of the weekday names in the top bar.
/// [bottomBarTextStyle] is a [TextStyle], that sets the style of the text in the bottom bar.
/// [bottomBarArrowColor] can set the [Color] of the arrow to expand/compress the calendar in the bottom bar.
/// [bottomBarColor] sets the [Color] of the bottom bar
/// [expandableDateFormat] defines the formatting of the date in the bottom bar
/// [displayMonthTextStyle] is a [TextStyle] for styling the month name in the top bar.
/// [datePickerConfig] is a [DatePickerConfig] object. It contains the configuration of the date picker, if enabled.
/// [showEvents] is a [bool]. This parameter allows the calender to show listed events. Default value is set to [true], but the user can hide the events entirely by setting it to [false]

// The library internnaly will use a Map<DateTime, List<NeatCleanCalendarEvent>> for the events.

class Calendar extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;
  final ValueChanged<DateTime>? onMonthChanged;
  final ValueChanged<bool>? onExpandStateChanged;
  final ValueChanged? onRangeSelected;
  final ValueChanged<NeatCleanCalendarEvent>? onEventSelected;
  final ValueChanged<NeatCleanCalendarEvent>? onEventLongPressed;
  final bool isExpandable;
  final DayBuilder? dayBuilder;
  final EventListBuilder? eventListBuilder;
  final DatePickerType? datePickerType;
  final bool hideArrows;
  final bool hideTodayIcon;
  @Deprecated(
      'Use `eventsList` instead. Will be removed in NeatAndCleanCalendar 0.4.0')
  final Map<DateTime, List<NeatCleanCalendarEvent>>? events;
  final List<NeatCleanCalendarEvent>? eventsList;
  final Color? defaultDayColor;
  final Color? defaultOutOfMonthDayColor;
  final Color? selectedColor;
  final Color? selectedTodayColor;
  final Color? todayColor;
  final String todayButtonText;
  final String allDayEventText;
  final String multiDayEndText;
  final Color? eventColor;
  final Color? eventDoneColor;
  final DateTime? initialDate;
  final bool isExpanded;
  final List<String> weekDays;
  final String? locale;
  final bool startOnMonday;
  final bool hideBottomBar;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? bottomBarTextStyle;
  final Color? bottomBarArrowColor;
  final Color? bottomBarColor;
  final String? expandableDateFormat;
  final TextStyle? displayMonthTextStyle;
  final DatePickerConfig? datePickerConfig;
  final double? eventTileHeight;
  final bool showEvents;

  /// Configures the date picker if enabled

  const Calendar({super.key, 
    this.onMonthChanged,
    this.onDateSelected,
    this.onRangeSelected,
    this.onExpandStateChanged,
    this.onEventSelected,
    this.onEventLongPressed,
    this.hideBottomBar = false,
    this.isExpandable = false,
    this.events,
    this.eventsList,
    this.dayBuilder,
    this.eventListBuilder,
    this.datePickerType = DatePickerType.hidden,
    this.hideTodayIcon = false,
    this.hideArrows = false,
    this.defaultDayColor = const Color.fromARGB(255, 99, 99, 99),
    this.defaultOutOfMonthDayColor = const Color.fromARGB(255, 139, 139, 139),
    this.selectedColor = const Color.fromARGB(155, 67, 107, 31),
    this.selectedTodayColor = const Color.fromARGB(255, 67, 107, 31),
    this.todayColor = const Color.fromARGB(255, 67, 107, 31),
    this.todayButtonText = 'Today',
    this.allDayEventText = 'All Day',
    this.multiDayEndText = 'End',
    this.eventColor,
    this.eventDoneColor,
    this.initialDate,
    this.isExpanded = false,
    this.weekDays = const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    this.locale = 'en_US',
    this.startOnMonday = false,
    this.dayOfWeekStyle = const TextStyle(
      color: Color.fromARGB(155, 67, 107, 31),),
    this.bottomBarTextStyle,
    this.bottomBarArrowColor,
    this.bottomBarColor,
    this.expandableDateFormat = 'EEEE MMMM dd, yyyy',
    this.displayMonthTextStyle = const TextStyle(
      color: Color.fromARGB(255, 67, 107, 31),
      fontSize: 40.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'Italiana',
    ),
    this.datePickerConfig,
    this.eventTileHeight,
    this.showEvents = true,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarUtils = Utils();
  late List<DateTime> selectedMonthsDays;
  late Iterable<DateTime> selectedWeekDays;
  late Map<DateTime, List<NeatCleanCalendarEvent>>? eventsMap;
  // selectedDate is the date, that is currently selected. It is highlighted with a circle.
  DateTime _selectedDate = DateTime.now();
  String? currentMonth;
  late bool isExpanded;
  String displayMonth = '';
  DateTime get selectedDate => _selectedDate;
  List<NeatCleanCalendarEvent>? _selectedEvents;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;

    _selectedDate = widget.initialDate ?? DateTime.now();
    initializeDateFormatting(widget.locale, null).then((_) => setState(() {
          var monthFormat =
              DateFormat('MMMM', widget.locale).format(_selectedDate);
          displayMonth = monthFormat.toUpperCase();
        }));
  }

  /// The method [_updateEventsMap] has the purpose to update the eventsMap, when the calendar widget
  /// renders its view. When this method executes, it fills the eventsMap with the contents of the
  /// given eventsList. This can be used to update the events shown by the calendar.
  void _updateEventsMap() {
    eventsMap = widget.events ?? {};
    // If the user provided a list of events, then convert it to a map, but only if there
    // was no map of events provided. To provide the events in form of a map is the way,
    // the library worked before the v0.3.x release. In v0.3.x the possibility to provide
    // the eventsList property was introduced. This simplifies the handaling. In v0.4.0 the
    // property events (the map) will get removed.
    // Here the library checks, if a map was provided. You can not provide a list and a map
    // at the same time. In that case the map will be used, while the list is omitted.
    if (widget.eventsList != null &&
        widget.eventsList!.isNotEmpty &&
        eventsMap!.isEmpty) {
      for (var event in widget.eventsList!) {        
        List<NeatCleanCalendarEvent> dateList = eventsMap![DateTime(
                event.expirationDate.year,
                event.expirationDate.month,
                event.expirationDate.day)] ??
            [];
        // Just add the event to the list.
        eventsMap![DateTime(event.expirationDate.year, event.expirationDate.month,
            event.expirationDate.day)] = dateList..add(event);
      }
    }
    selectedMonthsDays = _daysInMonth(_selectedDate);
    selectedWeekDays = Utils.daysInRange(
            _firstDayOfWeek(_selectedDate), _lastDayOfWeek(_selectedDate))
        .toList();

    _selectedEvents = eventsMap?[DateTime(
            _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
        [];
  }

  Widget get nameAndIconRow {
    StatelessWidget todayIcon;
    StatelessWidget leftArrow;
    StatelessWidget rightArrow;
    StatelessWidget jumpDateIcon;

    if (!widget.hideArrows) {
      leftArrow = PlatformIconButton(
        onPressed: isExpanded ? () => previousMonth(true) : previousWeek,
        icon: const Icon(Icons.chevron_left),
      );
      rightArrow = PlatformIconButton(
        onPressed: isExpanded ? () => nextMonth(true) : nextWeek,
        icon: const Icon(Icons.chevron_right),
      );
    } else {
      leftArrow = Container();
      rightArrow = Container();
    }

    if (!widget.hideTodayIcon) {
      todayIcon = GestureDetector(
        onTap: resetToToday,
        child: Text(widget.todayButtonText),
      );
    } else {
      todayIcon = Container();
    }

    if (widget.datePickerType != null &&
        widget.datePickerType != DatePickerType.hidden) {
      jumpDateIcon = GestureDetector(
        child: const Icon(
          Icons.date_range_outlined,
          color: Color.fromARGB(155, 67, 107, 31), 
          ),
        onTap: () {
          if (widget.datePickerType == DatePickerType.date) {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData(
                    colorScheme: const ColorScheme.light(
                      primary: Color.fromARGB(255, 67, 107, 31),
                      onPrimary: Color.fromARGB(255, 205, 219, 192),
                      surface: Color.fromARGB(255, 225, 235, 206),
                    ),
                  ),
                  child: child!,
                );
              },
            ).then((date) {
              if (date != null) {
                // The selected date is printed to the console in ISO 8601 format for debugging purposes.
                // The "onJumpToDateSelected" callback is then invoked with the selected date.
                // These lines have been moved outside of the "setState" block to
                // trigger the callback methods (i.e. onMonthChanged) in the parent widget.
                // After the callback methods are invoked, the "setState" block is called and the
                // _selectedDate is updated. This must be done after the callback methods are invoked,
                // otherwise the callback methods will not trigger, if the current date is equal to the
                // selected date.
                onJumpToDateSelected(date);
                setState(() {
                  _selectedDate = date;
                  selectedMonthsDays = _daysInMonth(_selectedDate);
                  selectedWeekDays = Utils.daysInRange(
                          _firstDayOfWeek(_selectedDate),
                          _lastDayOfWeek(_selectedDate))
                      .toList();
                  var monthFormat = DateFormat('MMMM', widget.locale).format(_selectedDate);
                  displayMonth = displayMonth = monthFormat.toUpperCase();
                  _selectedEvents = eventsMap?[DateTime(_selectedDate.year,
                          _selectedDate.month, _selectedDate.day)] ??
                      [];
                });
              }
            });
          }
        },
      );
    } else {
      jumpDateIcon = Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftArrow,
        Expanded(
          child: Column(
            children: <Widget>[
              todayIcon,
              Text(
                displayMonth,
                style: widget.displayMonthTextStyle ??
                    const TextStyle(
                      fontSize: 20.0,
                    ),
              ),
            ],
          ),
        ),
        jumpDateIcon,
        rightArrow,
      ],
    );
  }

  Widget get calendarGridView {
    return SimpleGestureDetector(
      onSwipeUp: _onSwipeUp,
      onSwipeDown: _onSwipeDown,
      onSwipeLeft: _onSwipeLeft,
      onSwipeRight: _onSwipeRight,
      swipeConfig: const SimpleSwipeConfig(
        verticalThreshold: 10.0,
        horizontalThreshold: 40.0,
        swipeDetectionMoment: SwipeDetectionMoment.onUpdate,
      ),
      child: Column(
        children: <Widget>[
          GridView.count(
            childAspectRatio: 1.5,
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 7,
            padding: const EdgeInsets.only(bottom: 0.0),
            children: calendarBuilder(),
          ),
        ],
      ),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
        isExpanded ? selectedMonthsDays : selectedWeekDays as List<DateTime>;
    for (var day in widget.weekDays) {
        dayWidgets.add(
          NeatCleanCalendarTile(
            defaultDayColor: widget.defaultDayColor,
            defaultOutOfMonthDayColor: widget.defaultOutOfMonthDayColor,
            selectedColor: widget.selectedColor,
            selectedTodayColor: widget.selectedTodayColor,
            todayColor: widget.todayColor,
            eventColor: widget.eventColor,
            eventDoneColor: widget.eventDoneColor,
            // ignore: collection_methods_unrelated_type
            events: eventsMap![day],
            isDayOfWeek: true,
            dayOfWeek: day,
            dayOfWeekStyle: widget.dayOfWeekStyle ??
                TextStyle(
                  color: widget.selectedColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
          ),
        );
      }

    bool monthStarted = false;
    bool monthEnded = false;

    for (var day in calendarDays) {
        if (day.hour > 0) {
          day = DateFormat("yyyy-MM-dd HH:mm:ssZZZ")
              .parse(day.toString())
              .toLocal();
          day = day.subtract(Duration(hours: day.hour));
        }

        if (monthStarted && day.day == 01) {
          monthEnded = true;
        }

        if (Utils.isFirstDayOfMonth(day)) {
          monthStarted = true;
        }

        if (widget.dayBuilder != null) {
          // Use the dayBuilder widget passed as parameter to render the date tile
          dayWidgets.add(
            NeatCleanCalendarTile(
              defaultDayColor: widget.defaultDayColor,
              defaultOutOfMonthDayColor: widget.defaultOutOfMonthDayColor,
              selectedColor: widget.selectedColor,
              selectedTodayColor: widget.selectedTodayColor,
              todayColor: widget.todayColor,
              eventColor: widget.eventColor,
              eventDoneColor: widget.eventDoneColor,
              events: eventsMap![day],
              child: widget.dayBuilder!(context, day),
              date: day,
              onDateSelected: () => handleSelectedDateAndUserCallback(day),
            ),
          );
        } else {
          dayWidgets.add(
            NeatCleanCalendarTile(
                defaultDayColor: widget.defaultDayColor,
                defaultOutOfMonthDayColor: widget.defaultOutOfMonthDayColor,
                selectedColor: widget.selectedColor,
                selectedTodayColor: widget.selectedTodayColor,
                todayColor: widget.todayColor,
                eventColor: widget.eventColor,
                eventDoneColor: widget.eventDoneColor,
                events: eventsMap![day],
                onDateSelected: () => handleSelectedDateAndUserCallback(day),
                date: day,
                dateStyles: configureDateStyle(monthStarted, monthEnded),
                isSelected: Utils.isSameDay(selectedDate, day),
                inMonth: day.month == selectedDate.month),
          );
        }
      }
    return dayWidgets;
  }

  TextStyle? configureDateStyle(monthStarted, monthEnded) {
    TextStyle? dateStyles;
    final TextStyle? body1Style = Theme.of(context).textTheme.bodyText2;

    if (isExpanded) {
      final TextStyle body1StyleDisabled = body1Style!.copyWith(
          color: Color.fromARGB(
        100,
        body1Style.color!.red,
        body1Style.color!.green,
        body1Style.color!.blue,
      ));

      dateStyles =
          monthStarted && !monthEnded ? body1Style : body1StyleDisabled;
    } else {
      dateStyles = body1Style;
    }
    return dateStyles;
  }

  Widget get expansionButtonRow {
    if (widget.isExpandable) {
      return GestureDetector(
        onTap: toggleExpanded,
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 250, 250, 245),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), 
              topRight: Radius.circular(30),
            ),
          ),
          height: 60,
          margin: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // SizedBox(width: 1.0),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Expiring ${DateFormat('M/d/yy').format(_selectedDate)}",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 67, 107, 31), 
                        fontWeight: FontWeight.w600,
                        ),
                    ),
                  ),
                  PlatformIconButton(
                    onPressed: toggleExpanded,
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    icon: isExpanded
                        ? const Icon(
                            Icons.keyboard_arrow_up_rounded,
                            size: 30.0,
                            color: Color.fromARGB(255, 67, 107, 31),
                          )
                        : const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 30.0,
                            color: Color.fromARGB(255, 67, 107, 31),
                          ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
                height: 1,
                indent: 10,
                endIndent: 10,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget get eventList {
    // If eventListBuilder is provided, use it to build the list of events to show.
    // Otherwise use the default list of events.
    if (widget.eventListBuilder == null) {
      return Expanded(
        child: _selectedEvents != null && _selectedEvents!.isNotEmpty
            // Create a list of events that are occurring on the currently selected day, if there are
            // any. Otherwise, display an empty Container.
            ? Container(
              color: const Color.fromARGB(255, 250, 250, 245),
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (BuildContext context, int index) {
                    final NeatCleanCalendarEvent event = _selectedEvents![index];
                    return MySquare(
                      title: event.title,
                      qty: event.qty,
                      img: event.image,
                    );
                  },
                  itemCount: _selectedEvents!.length,
                ),
            )
            : Container(
              color: const Color.fromARGB(255, 250, 250, 245),
              margin: const EdgeInsets.only(left: 10, right: 10),
            ),
      );
    } else {
      // eventListBuilder is not null
      return widget.eventListBuilder!(context, _selectedEvents!);
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateEventsMap();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        nameAndIconRow,
        ExpansionCrossFade(
          collapsed: calendarGridView,
          expanded: calendarGridView,
          isExpanded: isExpanded,
        ),
        expansionButtonRow,
        if (widget.showEvents) eventList
      ],
    );
  }

  /// The function [resetToToday] is called on tap on the Today button in the top
  /// position of the screen. It re-caclulates the range of dates, so that the
  /// month view or week view changes to a range containing the current day.
  void resetToToday() {
    onJumpToDateSelected(DateTime.now());
  }

  // The function [nextMonth] updates the "_selectedDate" to the first day of the previous month.
  // If "launchCallback" is true, it also triggers the date selection callback with the new date.
  // The state is then updated with the new selected date, the days in the new month, the display month, and any events on the new date.
  // This function is typically used to navigate to the previous month in a calendar widget.
  void nextMonth(bool launchCallback) {
    DateTime newDate = Utils.nextMonth(_selectedDate);
    // Parameter "launchCallback" is there to avoid triggering the callback twice.
    if (launchCallback) {
      _launchDateSelectionCallback(newDate);
    }
    setState(() {
      _selectedDate = newDate;
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat =
          DateFormat('MMMM', widget.locale).format(_selectedDate);
      displayMonth = displayMonth = monthFormat.toUpperCase();
      _selectedEvents = eventsMap?[DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
          [];
    });
  }

  // The function [previousMonth] updates the "_selectedDate" to the first day of the previous month.
  // If "launchCallback" is true, it also triggers the date selection callback with the new date.
  // The state is then updated with the new selected date, the days in the new month, the display month, and any events on the new date.
  // This function is typically used to navigate to the previous month in a calendar widget.
  void previousMonth(bool launchCallback) {
    DateTime newDate = Utils.previousMonth(_selectedDate);
    // Parameter "launchCallback" is there to avoid triggering the callback twice.
    if (launchCallback) {
      _launchDateSelectionCallback(newDate);
    }
    setState(() {
      _selectedDate = newDate;
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat =
          DateFormat('MMMM', widget.locale).format(_selectedDate);
      displayMonth = displayMonth = monthFormat.toUpperCase();
      _selectedEvents = eventsMap?[DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
          [];
    });
  }

  void nextWeek() {
    DateTime newDate = Utils.nextWeek(_selectedDate);
    _launchDateSelectionCallback(newDate);
    setState(() {
      _selectedDate = newDate;
      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      var monthFormat =
          DateFormat('MMMM', widget.locale).format(_selectedDate);
      displayMonth = displayMonth = monthFormat.toUpperCase();
      _selectedEvents = eventsMap?[DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
          [];
    });
  }

  void previousWeek() {
    DateTime newDate = Utils.previousWeek(_selectedDate);
    _launchDateSelectionCallback(newDate);
    setState(() {
      _selectedDate = newDate;
      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      var monthFormat =
          DateFormat('MMMM', widget.locale).format(_selectedDate);
      displayMonth = displayMonth = monthFormat.toUpperCase();
      _selectedEvents = eventsMap?[DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
          [];
    });
  }

  void onJumpToDateSelected(DateTime day) {
    // Fire onDateSelected callback and onMonthChanged callback.
    _launchDateSelectionCallback(day);

    _selectedDate = day;
    var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);

    setState(() {
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat =
          DateFormat('MMMM', widget.locale).format(_selectedDate);
      displayMonth = displayMonth = monthFormat.toUpperCase();
      _selectedEvents = eventsMap?[DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
          [];
    });
  }

  void _onSwipeUp() {
    if (isExpanded) toggleExpanded();
  }

  void _onSwipeDown() {
    if (!isExpanded) toggleExpanded();
  }

  void _onSwipeRight() {
    if (isExpanded) {
      // Here _launchDateSelectionCallback was not called before. That's why set the
      // "launchCallback" parameter to true.
      previousMonth(true);
    } else {
      previousWeek();
    }
  }

  void _onSwipeLeft() {
    if (isExpanded) {
      // Here _launchDateSelectionCallback was not called before. That's why set the
      // "launchCallback" parameter to true.
      nextMonth(true);
    } else {
      nextWeek();
    }
  }

  void toggleExpanded() {
    if (widget.isExpandable) {
      setState(() => isExpanded = !isExpanded);
      if (widget.onExpandStateChanged != null) {
        widget.onExpandStateChanged!(isExpanded);
      }
    }
  }

  // The "handleSelectedDateAndUserCallback" method is responsible for processing the
  // selected date and invoking the corresponding user callback.
  // It is expected to be called when a user selects a date.
  // The exact functionality can vary depending on the implementation,
  // but typically this method will store the selected date and then call a
  // user-defined callback function based on this date.
  void handleSelectedDateAndUserCallback(DateTime day) {
    // Fire onDateSelected callback and onMonthChanged callback.
    _launchDateSelectionCallback(day);

    var firstDayOfCurrentWeek = _firstDayOfWeek(day);
    var lastDayOfCurrentWeek = _lastDayOfWeek(day);
    // Check if the selected day falls into the next month. If this is the case,
    // then we need to additionaly check, if a day in next year was selected.
    if (_selectedDate.month > day.month) {
      // Day in next year selected? Switch to next month.
      if (_selectedDate.year < day.year) {
        // _launchDateSelectionCallback was already called befor. That's why set the
        // "launchCallback" parameter to false, to avoid calling the callback twice.
        nextMonth(false);
      } else {
        // _launchDateSelectionCallback was already called befor. That's why set the
        // "launchCallback" parameter to false, to avoid calling the callback twice.
        previousMonth(false);
      }
    }
    // Check if the selected day falls into the last month. If this is the case,
    // then we need to additionaly check, if a day in last year was selected.
    if (_selectedDate.month < day.month) {
      // Day in next last selected? Switch to next month.
      if (_selectedDate.year > day.year) {
        // _launchDateSelectionCallback was already called befor. That's why set the
        // "launchCallback" parameter to false, to avoid calling the callback twice.
        previousMonth(false);
      } else {
        // _launchDateSelectionCallback was already called befor. That's why set the
        // "launchCallback" parameter to false, to avoid calling the callback twice.
        nextMonth(false);
      }
    }
    setState(() {
      _selectedDate = day;
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = _daysInMonth(day);
      _selectedEvents = eventsMap?[_selectedDate] ?? [];
    });
  }

  // The "_launchDateSelectionCallback" method is used to trigger the date selection callbacks.
  // If the "onDateSelected" callback is not null, it is invoked with the selected day.
  // Additionally, if the "onMonthChanged" callback is not null and the selected day is in
  // a different month or year than the previously selected date,
  // the "onMonthChanged" callback is invoked with the selected day.
  // This additional condition prevents the "onMonthChanged" callback from being invoked twice when a date in the same month is selected.
  void _launchDateSelectionCallback(DateTime day) {
    if (widget.onDateSelected != null) {
      widget.onDateSelected!(day);
    }
    // Additional conditions: Only if month or year changed, then call the callback.
    // This avoids double executing the callback when selecting a date in the same month.
    if (widget.onMonthChanged != null &&
        (day.month != _selectedDate.month || day.year != _selectedDate.year)) {
      widget.onMonthChanged!(day);
    }
  }

  _firstDayOfWeek(DateTime date) {
    var day = DateTime.utc(
        _selectedDate.year, _selectedDate.month, _selectedDate.day, 12);
    if (widget.startOnMonday == true) {
      day = day.subtract(Duration(days: day.weekday - 1));
    } else {
      // if the selected day is a Sunday, then it is already the first day of week
      day = day.weekday == 7 ? day : day.subtract(Duration(days: day.weekday));
    }
    return day;
  }

  _lastDayOfWeek(DateTime date) {
    return _firstDayOfWeek(date).add(const Duration(days: 7));
  }

  /// The function [_daysInMonth] takes the parameter [month] (which is of type [DateTime])
  /// and calculates then all the days to be displayed in month view based on it. It returns
  /// all that days in a [List<DateTime].
  List<DateTime> _daysInMonth(DateTime month) {
    var first = Utils.firstDayOfMonth(month);
    var daysBefore = first.weekday;
    var firstToDisplay = first.subtract(
        Duration(days: daysBefore - (widget.startOnMonday ? 1 : 0)));
    var last = Utils.lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    // Adding an extra day necessary (if week starts on Monday).
    // Otherwise the week with days in next month would always end on Saturdays.
    var lastToDisplay = last
        .add(Duration(days: daysAfter + (widget.startOnMonday ? 1 : 0)));
    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
  }
}

class ExpansionCrossFade extends StatelessWidget {
  final Widget collapsed;
  final Widget expanded;
  final bool isExpanded;

  const ExpansionCrossFade(
      {super.key, required this.collapsed,
      required this.expanded,
      required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: collapsed,
      secondChild: expanded,
      firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.decelerate,
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}
