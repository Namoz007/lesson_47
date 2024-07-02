
import 'package:dars_47_home/controllers/tests_controller.dart';
import 'package:dars_47_home/main.dart';
import 'package:dars_47_home/models/test.dart';
import 'package:dars_47_home/views/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final testController = TestsController();
  bool isStart = false;
  int trueQuestion = 0;
  int falseQuestion = 0;
  final pageController = PageController();
  bool isEnd = false;

  void initState() {
    super.initState();
  }

  void nextPage() {
    pageController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final testControllers = Provider.of<TestsController>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          'Welcome to Tests',
          style: TextStyle(color: Colors.red, fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
          }, icon: Icon(Icons.logout),),
        ],
      ),
      drawer: CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isStart ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('True:$trueQuestion',style: TextStyle(fontSize: 25,color: Colors.green,fontWeight: FontWeight.bold),),
              Text('False:$falseQuestion',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.red),)
            ],
          ) : SizedBox(),
          isStart
              ? Expanded(
                  child: Center(
                    child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      controller: pageController,
                      itemCount: testControllers.getTests().length,
                      itemBuilder: (ctx, index) {
                        Test   test = testControllers.getTests()[index];
                        return Center(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(child: Text('${index + 1}.${test.question}',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                for(int i = 0;i < test.options.length;i++)
                                  InkWell(
                                    onTap: () async{
                                      setState(() {
                                        if(!testControllers.clickedIndexs().contains(index))
                                          if(i == test.trueAnswer){
                                            trueQuestion += 1;
                                            testControllers.clickQuestion(index);
                                          }else{
                                            falseQuestion += 1;
                                            testControllers.clickQuestion(index);
                                          }

                                        if(index + 1 == testControllers.getTests().length){
                                          isStart = false;
                                          isEnd = true;
                                        }

                                        testControllers.writeResponse(trueQuestion);

                                        nextPage();
                                      });
                                    },
                                    child: Text("${i + 1}.${test.options[i]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                                  )
                              ],
                            )
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Center(
                child: Column(
                  children: [
                    isEnd ? Text('Game end',style: TextStyle(color: Colors.white,fontSize: 25),) : SizedBox(),
                    isEnd ? Text('True answer: ${trueQuestion}',style: TextStyle(color: Colors.white,fontSize: 25),) : SizedBox(),
                    isEnd ? Text('False answer: ${falseQuestion}',style: TextStyle(color: Colors.white,fontSize: 25),) : SizedBox(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isStart = true;
                            isEnd = false;
                            trueQuestion = 0;
                            falseQuestion = 0;
                          });
                        },
                        icon: Container(
                          height: 50,
                          width: 290,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          child: Text(
                            '${isEnd ? "Restart" : "Start"}',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          SizedBox()
        ],
      ),
    );
  }
}
