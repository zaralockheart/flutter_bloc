import 'package:bloc_test/ui/architectures/redux/configure_store.dart';
import 'package:bloc_test/util/dio.dart';
import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class UpdateQuoteAction {
  String _quote;
  String _author;

  String get quote => this._quote;
  String get author => this._author;

  UpdateQuoteAction(this._quote, this._author);
}

ThunkAction<AppState> getRandomQuote = (Store<AppState> store) async {

  Response response = await dio.get('http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1');

  List<dynamic> result = response.data;

  // This is to remove the <p></p> html tag received. This code is not crucial.
  String quote = result[0]['content'].replaceAll(RegExp('[(<p>)(</p>)]'), '').replaceAll(RegExp('&#8217;'),'\'');
  String author = result[0]['title'];

  store.dispatch(
      UpdateQuoteAction(
          quote,
          author
      )
  );
};

UpdateQuoteAction getQuote(UpdateQuoteAction state, action) {
  if (action is UpdateQuoteAction) {
    return UpdateQuoteAction(action.quote, action.author);
  }
  return state;
}