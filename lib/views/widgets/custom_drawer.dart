import 'package:dars_47_home/views/screens/home_screen.dart';
import 'package:dars_47_home/views/screens/statistics_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 30,),

          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            title: Text("Game"),
            trailing: Icon(Icons.arrow_right),
          ),

          SizedBox(height: 20,),

          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => StatisticsScreen()));
            },
            title: Text("Statistics"),
            trailing: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
