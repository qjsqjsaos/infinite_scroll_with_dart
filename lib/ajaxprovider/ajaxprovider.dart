import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AjaxProvider extends ChangeNotifier {
  List<int> cache = []; //리스트

  bool loading = false; //로딩 상태
  bool hasMore = true;  //아이템이 더 있는지 없는지


// 아이템 만들기 공장
  fetchItems({required int nextId}) async {
    // ignore: unnecessary_statements
    nextId ?? 0; //nextId가 null이면 0값이다.

    loading = true; //로딩 상태 시작

    notifyListeners();

    final items = await _makeRequest(nextId: nextId);

    this.cache = [ //캐시 리스트 업데이트
    ...this.cache, //원래있던 리스트
    ...items, //새로운 리스트
    ];

    //items가 만약 빈 값이면 hasMore을 false로 바꾸어준다.
    if(items.length == 0) {
      hasMore = false;
    }

    loading = false; // 리스트가 다 끝나면 로딩 종료

    notifyListeners(); //ui 업데이트
    }

    //리스트 만들어주는 메서드
  _makeRequest({required int nextId}) async {
    assert(nextId != null); //nextId가 null이면 안된다. //null이면 중단(디버깅 모드일 때만)
    await Future.delayed(Duration(seconds: 1));

    //Item 은 nextId가 99 까지만 있다.
    if(nextId >= 100 ){
      return []; // 비어 있는 값 보내기
    }

    //nextId 다음에 20개의 값을 리스트로 리턴한다.
    //아래에서 index는 새로 가져오는 리스트의 인덱스이다.

    return List.generate(20, (index) => nextId + index);
  }
}
