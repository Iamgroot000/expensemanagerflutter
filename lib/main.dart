import 'dart:convert';
import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:expensemanagerflutter/utils/ScreenSize.dart';
import 'package:expensemanagerflutter/widget/customAppBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'date.dart';
import 'date.dart';
import 'date.dart';
import 'firebase_options.dart';
//import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
    MySample(),
   // const Page4(),
    //const Page5(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
     // crossAxisAlignment: CrossAxisAlignment.start,

      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: Container(
            height: ScreenSize.height(context),
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

          SizedBox(height:60),
          Row(
           // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  width: 100,

                  child: Center(
                    child: Text(
                      'Source of Income',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ),

                    ),
                  ),

                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Perform any necessary actions before navigating, if needed.

                  // Navigate to the DestinationScreen using Navigator.push.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationApp(), // RepSourceOfIncomeWidgetSourceOfIncomeWidgetlace with your destination screen.
                    ),
                 );
                },
                child: Text("ADD HERE"),
              ),




     ] )
    ]
      ),
    ); // Close Scaffold
  }
}



        // Close Column's children list
       // Close Column







    class Expense {
  String name;
  double amount;

  Expense(this.name, this.amount);
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData.from(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//       ),
//       home: Page3(),
//     );
//   }
// }

class Page2 extends StatefulWidget {
  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  List<Expense> expenses = [];

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  double getTotalExpenses() {
    double total = 0.0;
    for (var expense in expenses) {
      total += expense.amount;
    }
    return total;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void saveExpenseToFirestore(Expense expense) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      Map<String, dynamic> expenseData = {
        'name': expense.name,
        'amount': expense.amount,
        'timestamp': FieldValue.serverTimestamp(),
      };
      await firestore.collection('expenses').add(expenseData);
    } catch (e) {
      print('Error saving expense to Firestore: $e');
    }
  }

  void _showExpenseDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Expense Name'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Expense Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String name = nameController.text.trim();
              double amount = double.tryParse(amountController.text) ?? 0.0;

              if (name.isNotEmpty && amount > 0) {
                addExpense(Expense(name, amount));
                saveExpenseToFirestore(Expense(name, amount));
              }

              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalExpenses = getTotalExpenses();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('YOUR EXPENSES')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60,),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            Text('Selected Date: ${selectedDate.toLocal()}'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
            SizedBox(height: 20),
            Text('Selected Time: ${selectedTime.format(context)}'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _showExpenseDialog(context),
              child: Text('Monthly Expenses'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(expenses[index].name),
                    subtitle: Text('\$${expenses[index].amount.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text('Total Expenses: \$${totalExpenses.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}



// class Gaurav extends StatefulWidget {
//   const Gaurav({Key? key}) : super(key: key);
//
//   @override
//   _GauravState createState() => _GauravState();
// }

// class _GauravState extends State<Gaurav> {
//   List<Map<String, String>> incomes = [];
//
//   void _showAddIncomeDialog() async {
//     final result = await showDialog(
//       context: context,
//       builder: (context) => AddIncomeDialog(),
//     );
//
//     if (result != null) {
//       setState(() {
//         incomes.add(result);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           OutlinedButton(
//             onPressed: _showAddIncomeDialog,
//             child: Text("Add source of income"),
//           ),
//           SizedBox(height: 20),
//           // Display the list of incomes
//           ListView.builder(
//             shrinkWrap: true,
//             itemCount: incomes.length,
//             itemBuilder: (context, index) {
//               final income = incomes[index];
//               return ListTile(
//                 title: Text(income['source'] ?? ''),
//                 subtitle: Text(income['amount'] ?? ''),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class AddIncomeDialog extends StatefulWidget {
//   @override
//   _AddIncomeDialogState createState() => _AddIncomeDialogState();
// }
//
// class _AddIncomeDialogState extends State<AddIncomeDialog> {
//   String incomeSource = '';
//   String incomeAmount = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add Source of Income'),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               decoration: InputDecoration(labelText: 'Income Source'),
//               onChanged: (value) {
//                 setState(() {
//                   incomeSource = value;
//                 });
//               },
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Income Amount'),
//               keyboardType: TextInputType.number,
//               onChanged: (value) {
//                 setState(() {
//                   incomeAmount = value;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             // Add the income to the list and close the dialog
//             if (incomeSource.isNotEmpty && incomeAmount.isNotEmpty) {
//               Navigator.of(context).pop({
//                 'source': incomeSource,
//                 'amount': incomeAmount,
//               });
//             } else {
//               // Show a snackbar or toast message indicating the fields are required
//             }
//           },
//           child: Text('Add'),
//         ),
//       ],
//     );
//   }
// }
//
//
//
//
// class Tab1Screen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      // appBar: AppBar(
//        // title: Text('Tab 1'),
//       //),
//       body: Center(
//         child: OutlinedButton(
//           onPressed: () {
//             // Navigate to Tab 2 by changing the selected index of the TabController
//             ///TODO index ke hisab se jayega dekh index 0 pe tab 1 and index 1 pe tab 2 and index 2 pe tab 3
//             DefaultTabController.of(context).animateTo(1); // 1 represents the index of Tab 2
//           },
//           child: Text("Source of income"),
//         ),
//       ),
//     );
//   }
// }


 // Add this import for using input formatters

class RegistrationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              height: 750,
              width: 700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(labelText: 'First Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      // You can add additional email format validation if required
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      // You can add additional password validation if required
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _aadharController,
                    keyboardType: TextInputType.number, // Allow only numeric input
                    decoration: InputDecoration(labelText: 'Aadhar No'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an Aadhar No';
                      }
                      // You can add additional Aadhar No validation if required
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _occupationController,
                    decoration: InputDecoration(labelText: 'Occupation'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your occupation';
                      }
                      // You can add additional occupation validation if required
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _incomeController,
                    decoration: InputDecoration(labelText: 'Income'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Income';
                      }

                      // Check if the input value contains only numeric characters
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid numeric value';
                      }

                      // Additional validation based on your requirements can be added here.

                      return null;
                    },
                  ),

                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Create a map with the form data
                        Map<String, dynamic> formData = {
                          'firstName': _firstNameController.text,
                          'lastName': _lastNameController.text,
                          'email': _emailController.text,
                          'aadharNo': _aadharController.text,
                          'occupation': _occupationController.text,
                          'income': double.parse(_incomeController.text),
                        };

                        try {
                          // Save the data to Cloud Firestore
                          await FirebaseFirestore.instance.collection('expenses').add(formData);

                          // Show a success message to the user (Optional)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Form data saved successfully!')),
                          );
                        } catch (e) {
                          // Handle any errors that occurred during the data saving process (Optional)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: Form data could not be saved.')),
                          );
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class Page2 extends StatefulWidget {
//   const Page2({super.key});
//
//   @override
//   State<Page2> createState() => _Page2State();
// }
//
//
// class _Page2State extends State<Page2> {
//   Future<List<dynamic>> fetchData() async {
//     final url = Uri.parse('http://universities.hipolabs.com/search?country=United+States');
//
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       // If the server returns a 200 OK response, parse the JSON.
//       final List<dynamic> data = json.decode(response.body);
//       return data;
//     } else {
//       // If the server did not return a 200 OK response, throw an exception.
//       throw Exception('Failed to load data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<dynamic>>(
//       future: fetchData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // While data is being fetched, show a loading indicator.
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           // If the data is successfully fetched, you can use it in your UI.
//           final data = snapshot.data;
//           return Container(
//             height: 100,
//             width: 100,
//             color: Colors.blueGrey,
//             child: Center(
//               child: Text('Data: $data'),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
//
