import 'package:flutter/material.dart';
import 'screens/tab_screen.dart';
import 'toro_theme.dart';

void main() => runApp(ToroInvestimentosApp());

class ToroInvestimentosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Toro Investimentos App';

    return MaterialApp(
      title: title,
      theme: toroTheme,
      debugShowCheckedModeBanner: false,
      home: TabScreen(),
    );
  }
}

//       MyHomePage(
//         title: title,
//         channel: IOWebSocketChannel.connect(
//             'ws://localhost:8080/quotes'), //('ws://echo.websocket.org'),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   final String title;
//   final WebSocketChannel channel;

//   MyHomePage({Key key, @required this.title, @required this.channel})
//       : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             StreamBuilder(
//                 stream: widget.channel.stream,
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) return const Text("Loading...");

//                   return ListView.builder(
//                       itemCount: snapshot.data.documents.lenght,
//                       itemBuilder: (context, index) {
//                         print(snapshot.data[index]);
//                         return ListTile(title: Text(snapshot.data[index]));
//                       });
//                 })
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendMessage,
//         tooltip: 'Send message',
//         child: Icon(Icons.send),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       widget.channel.sink.add(_controller.text);
//     }
//   }

//   @override
//   void dispose() {
//     widget.channel.sink.close();
//     super.dispose();
//   }
// }
