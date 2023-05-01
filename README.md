# instagram
2023.04.30~
Flutter > instagram 만들기

### Instagram 만들기 
1. ThemeData 
2. ThemeData -> style.dart 로 뺴기 
3. style.dart import 
4. import 중복문제 피하기 
  1) import 파일 작명하기
  2) _변수명 : 다른 파일에서 쓸 수 없는 변수 ( _변수명, _함수명, _클래스명 )
5. 버튼 스타일링
6. 레이아웃 중간에 ThemeData() 생성 가능 
  - 가까운 스타일을 적용
7. BottomNavigationBar
8. 페이지 나누기
  1) state에 현재 tab의 상태 저장
  2) state에 따라 tab이 어떻게 보일지 작성 : body : [Text, Text][state]
  3) 유저가 state 쉽게 조작할 수 있게 : onTap 
9. 동적인 UI 만드는 법 : pageView 써보기 
  1) state에 현재 UI 상태 저장 
  2) state에 따라 UI 어떻게 보일지 작성 
  3) 유저도 state 조작할 수 있게
10. 커스텀위젯 사용해서 페이지 1 만들기
11. ★ 서버에서 데이터 가져오기 GET요청

