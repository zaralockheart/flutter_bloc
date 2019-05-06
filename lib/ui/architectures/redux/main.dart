import 'package:bloc_test/ui/architectures/redux/configure_store.dart';
import 'package:bloc_test/ui/architectures/redux/home.dart';
import 'package:bloc_test/ui/architectures/redux/main_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => {runApp(MyApp())};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<AppState, int>(
              converter: (store) => store.state.counter,
              builder: (_, counter) {
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),

            // display random quote and its author
            StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              onDidChange: (state) {
                if (state.quoteAction != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
              },
              builder: (_, state) {
                return Text(
                  ' ${state.quoteAction?.quote} \n -${state.quoteAction?.author}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20.0
                  ),
                );
              },
            ),
            // generate quote button
            StoreConnector<AppState, VoidCallback>(
              converter: (store) => () => store.dispatch(getRandomQuote),
              builder: (_, generateQuoteCallback) {
                return FlatButton(
                    color: Colors.lightBlue,
                    onPressed: generateQuoteCallback,
                    child: Text("generate random quote")
                );
              },
            )

          ],
        ),
      ),
      floatingActionButton: StoreConnector<AppState, VoidCallback>(
        converter: (store) => () => store.dispatch(Actions.IncrementAction),
        builder: (_, incrementCallback) {
          return FloatingActionButton(
            onPressed: incrementCallback,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
