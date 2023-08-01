import 'package:expensemanagerflutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';

class MyWELCOMEApp extends StatelessWidget {
  const MyWELCOMEApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Gallery(),
    );
  }
}

class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300, crossAxisSpacing: 16, mainAxisSpacing: 16),
        children: [
          const FourCirclePulse(),
          YinAndYang(
            yangColor: Theme.of(context).colorScheme.primary,
          ),
          const RippleRing(),
          const LineEllipsis(),
          // Add tShe blue container widget below
          SizedBox(height: 20,),
              Container(
              height: 100,
                //color: Colors.blue,
                child: Center(
                  child:TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                    ),
                  )
                ),
              ),
              Container(
                height: 100,
                //color: Colors.blue,
                child: Center(
                    child:TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                      ),
                    )
                ),
              ),
      SizedBox(height: 20),
      Container(
        height: 40,
        width: 100,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );

            // Perform signup logic here
          },
          child: Text('Next'),
        ),
      ),



            ],
          )



    );




      //floatingActionButton: FloatingActionButton(
        //onPressed: () {
         // int idx =
             // DateTime.now().millisecondsSinceEpoch % Colors.primaries.length;
          //ThemeColorChooser.themeKey.currentState
          //  ?.updateColor(Colors.primaries[idx]);
        //},
       // child: const Icon(Icons.palette_outlined),

  }
}
