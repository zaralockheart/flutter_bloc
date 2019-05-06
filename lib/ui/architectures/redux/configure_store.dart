import 'package:bloc_test/ui/architectures/redux/main_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class AppState {
  int counter;
  UpdateQuoteAction quoteAction;

  AppState({this.counter = 0, this.quoteAction});
}

enum Actions {
  IncrementAction
}

AppState appStateReducer(AppState state, action) {
  return AppState(
    quoteAction: getQuote(state.quoteAction, action),
    counter: incrementReducer(state.counter, action),
  );
}

int incrementReducer(int state, action) {
  if (action == Actions.IncrementAction) {
    return state + 1;
  }
  return state;
}


final store = Store<AppState>(
    appStateReducer,
    initialState: AppState(),
    middleware: [thunkMiddleware]
);