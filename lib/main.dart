import 'dart:js_interop';

import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
      MaterialApp(
        theme: style.theme,
        home: MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;  // 현재 탭의 상태
  var data = [];

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    // Dio 패키지 설치하면 get요청 짧아짐



    if( result.statusCode == 200 ){
      // else 예외처리
    }
    // json을 []{}로 변환해서 씀
    setState(() {
      data = jsonDecode(result.body);
    });
  }
  // 앱 로드될 때 실행
  @override
  void initState() {
    super.initState();
    getData();
  }

  var a = TextStyle( color: Colors.yellow );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined)),
        ],
      ),

      body: [
        // FutureBuilder(builder: (){}, future: data,) 자주 바뀌는 데이터에는 부적절
        HomePage(data : data),
        Text('샵페이지', style: Theme.of(context).textTheme.bodyText1,)
      ][tab],

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '샵'),
        ]
      )
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key, this.data}) : super(key: key);
  var cnt = 0;
  final data;

  @override
  Widget build(BuildContext context) {
    // data 가 있으면 실행해주세요
    if (data.isNotEmpty) {
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(data[index]['image']),
                //Image.asset('shuri.png'),
                Text("좋아요 " + data[index]['likes'].toString()),
                Text(data[index]['user']),
                Text(data[index]['content'])
              ],
            );
          }
        );
    } else {
      return Text('로딩중');
    }
  }
}
