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
          IconButton(onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (c) => Upload() )
            );
          }, icon: Icon(Icons.add_box_outlined)),
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

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.data}) : super(key: key);
  final data;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var cnt = 0;

  // 스크롤 높이
  var scroll = ScrollController();
  var getReqCnt = 0;
  var getReqUrl = ['https://codingapple1.github.io/app/more1.json', 'https://codingapple1.github.io/app/more2.json'];

  // flag
  var gettingMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 왼쪽변수(scroll)이 변할때마다
    scroll.addListener(() async {
      // 맨 밑까지 스크롤 했니 ?
      // 필요없어지면 리스너 제거 > 성능
      //print(scroll.position.pixels);  // 현재 위치 (스크롤 거리)
      //print(scroll.position.maxScrollExtent);     // 최대 스크롤 거리
      //print(scroll.position.userScrollDirection);  // 방향

      if(scroll.position.pixels == scroll.position.maxScrollExtent){

        // 게시물 더 가져와주세요
        // http://codingapple1.github.io/app/more1.json
        // GET요청
        if( !gettingMore ) {
          if(getReqCnt < 2) {
            var result = await http.get(Uri.parse(getReqUrl[getReqCnt]));
            var more = jsonDecode(result.body);
            setState(() {
              widget.data.add(more);
            });
            getReqCnt++;
          } else {
            gettingMore = true;
          }
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // data 가 있으면 실행해주세요
    if (widget.data.isNotEmpty) {
      return ListView.builder(
          controller: scroll,
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(widget.data[index]['image']),
                //Image.asset('shuri.png'),
                Text("좋아요 " + widget.data[index]['likes'].toString()),
                Text(widget.data[index]['user']),
                Text(widget.data[index]['content'])
              ],
            );
          }
        );
    } else {
      return Text('로딩중');
    }
  }
}

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이미지업로드화면'),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close))
        ],
      ),
    );
  }
}
