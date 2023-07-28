import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:expensemanagerflutter/widget/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'date.dart';
//import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Notch Bottom Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const Page1(),
    Page2(),
    const Page3(),
   // const Page4(),
    //const Page5(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
     // crossAxisAlignment: CrossAxisAlignment.start,

      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 40,),
        Container(
          height: 800,
          width: 400,
          child: Scaffold(
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  bottomBarPages.length, (index) => bottomBarPages[index]),
            ),
            extendBody: true,
            bottomNavigationBar: (bottomBarPages.length <= maxCount)
                ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: false,
              notchColor: Colors.black87,

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              durationInMilliSeconds: 300,
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Page 1',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.star,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.star,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Page 2',
                ),

                ///svg example
                // BottomBarItem(
                //   inActiveItem: SvgPicture.asset(
                //     'assets/search_icon.svg',
                //     color: Colors.blueGrey,
                //   ),
                //   activeItem: SvgPicture.asset(
                //     'assets/search_icon.svg',
                //     color: Colors.white,
                //   ),
                //   itemLabel: 'Page 3',
                // ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.settings,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.settings,
                    color: Colors.pink,
                  ),
                  itemLabel: 'Page 4',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: Colors.yellow,
                  ),
                  itemLabel: 'Page 5',
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
                : null,
          ),
        ),
      ],
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar(context: context),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            firstDay: DateTime(2021),
            lastDay: DateTime(2030),
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            calendarBuilders: CalendarBuilders(
              // You can customize the day widget appearance here if needed.
              // For example, to highlight the selected day:
              selectedBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.only(top: 5, left: 6),
                  color: Colors.blue,
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              //color: Colors.grey,
              child: DefaultTabController(
                length: 3, // Number of tabs you want
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: 'Tab 1'),
                        Tab(text: 'Tab 2'),
                        // Tab(text: 'Tab 3'),
                      ],
                      indicatorColor: Colors.blue, // Customize the color of the selected tab indicator
                      labelColor: Colors.blue, // Customize the color of the selected tab label
                      unselectedLabelColor: Colors.black, // Customize the color of unselected tab labels
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [

                          // Content of Tab 1
                          Center(

                            //child: Text('Tab 1 content',style: TextStyle(color: Colors.green),),

                          ),

                          // Content of Tab 2
                          Center(
                            child: Text('Tab 2 content'),
                          ),

                          // Content of Tab 3
                          // Center(
                          //   child: Text('Tab 3 content'),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )






          // Add any other widgets below the calendar as needed.
        ]


      ),

    );

  }
}


// class AnimatedText extends StatefulWidget {
//   const AnimatedText({Key? key}) : super(key: key);
//
//   @override
//   _AnimatedTextState createState() => _AnimatedTextState();
// }
//
// class _AnimatedTextState extends State<AnimatedText> {
//   bool _isExpanded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _startAnimation();
//   }
//
//   void _startAnimation() async {
//     await Future.delayed(const Duration(seconds: 1));
//     setState(() {
//       _isExpanded = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedDefaultTextStyle(
//       duration: const Duration(milliseconds: 500),
//       style: _isExpanded
//           ? TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       )
//           : TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.normal,
//         color: Colors.white,
//       ),
//       child: const Text('Expense Manager'),
//     );
//   }
// }


class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyDateHomePage();
  }
}





class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red, child: const Center(child: Text('Page 3')));
  }
}



