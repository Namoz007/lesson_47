import 'package:dars_47_home/controllers/tests_controller.dart';
import 'package:dars_47_home/models/user.dart';
import 'package:dars_47_home/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final statisticController = TestsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          "Statistics",
          style: TextStyle(color: Colors.red),
        ),
      ),
      drawer: CustomDrawer(),
      body: StreamBuilder(
        stream: statisticController.getStatistics,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Kechirasiz malumot olishda hatolik chiqdi',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            );
          }
          List<User> userUsers = [];
          List<User> users = [];
          List<int> count = [];
          final statistics = snapshot.data!.docs;
          if(!statistics.isEmpty){
            for(int i = 0;i < statistics.length;i++){
              userUsers.add(User.fromJson(statistics[i]));
              count.add(User.fromJson(statistics[i]).count);
            }

            count.sort((a,b) => b.compareTo(a));
            for(int i = 0;i < count.length;i++){
              for(int j = 0;j < userUsers.length;j++){
                if(count[i] == userUsers[j].count){
                  users.add(userUsers[j]);
                  break;
                }
              }
            }
          }
          return  statistics.isEmpty
              ? Center(
                  child: Text("Hozirda malumotlar mavjud emas"),
                )
              : ListView.builder(
            itemCount: users.length,
            itemBuilder: (context,index){
              User user = users[index];
              return ListTile(
                title: Text(
                  "${user.userEmail}",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
                trailing: Text("${user.count}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),),
              );
            },
          );
        },
      ),
    );
  }
}
