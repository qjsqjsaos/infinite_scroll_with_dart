import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll/ajaxprovider/ajaxprovider.dart';

class ProviderInfiniteScrollScreen extends StatefulWidget {
  const ProviderInfiniteScrollScreen({Key? key}) : super(key: key);

  @override
  _ProviderInfiniteScrollScreenState createState() =>
      _ProviderInfiniteScrollScreenState();
}

class _ProviderInfiniteScrollScreenState
    extends State<ProviderInfiniteScrollScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() => {
          //잠깐 기다렸다가 실행
          Provider.of<AjaxProvider>(context, listen: false)
              .fetchItems(nextId: 0)
          //위젯이 변경될때 재빌드 하지 않는다.
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Provider Infinite Scroll'),
        ),
        body: _renderListView()
    );
  }

  _renderListView(){
    //initState에서 처음 실행된 이후에 한 번 더 써야하기 때문에 가져옴
    final provider = Provider.of<AjaxProvider>(context);
    final cache = provider.cache;
    final loading = provider.loading; //로딩을 하고 있는지 아닌지

    //로딩중이면서 캐시에 아무것도 없을때 로딩창 켜주기
    if(loading && cache.length == 0){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    //로딩중이 아닌데 캐시에 아무것도 없을때
    //아무것도 가져올 데이터가 없을 때 보통 사용한다.
    if(!loading && cache.length == 0){
      return Center(
        child: Text(
            '아이템이 없습니다.'
        ),
      );
    }


    //리스트뷰 리턴하기
    return ListView.builder(
        itemCount: cache.length + 1,
        itemBuilder: (context, index) {
          if (index < cache.length) {
            return ListTile(
              title: Text(cache[index].toString()),
            );
          }
          if (!provider.loading && provider.hasMore) { //로딩상태가 아니고 데이터가 더 있을때,
            Future.microtask(() {
              provider.fetchItems(nextId: index);
            });
          }

          if(provider.hasMore){ //값이 더 있다면 로딩바를 넣어주고,
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{ //없으면 더 이상 아이템이 없다고 알려준다.
            return Center(
              child: Text('더 이상 아이템이 없습니다.'),
            );
          }
        }
    );
  }
}
