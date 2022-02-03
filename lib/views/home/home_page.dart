import 'package:flutter/material.dart';
import 'package:personal_pjt/connector/auth_connector.dart';

// multiple connector example  uses auth_connector and todo_connector
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthConnector(
      builder: (BuildContext authContext, AuthViewModel authModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Home Page for ${authModel.currentUser?.firstName ?? 'no user'}'),
            actions: <Widget>[
              new IconButton(
                icon: const Icon(Icons.file_download),
                onPressed: () {},
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                Text('${authModel.currentUser!.userId?.toString()}'),
                Text('${authModel.currentUser!.email?.toString()}')
              ],
            ),
          ),
        );
      },
    );
  }
}

//single connector example

//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return TodoConnector(
//      builder: (BuildContext c, TodoViewModel model) {
//        return Scaffold(
//          appBar: AppBar(
//            title: const Text('Home Page'),
//            actions: <Widget>[
//              new IconButton(
//                  icon: const Icon(Icons.file_download),
//                  onPressed: () {
//                    model.getList();
//                  }),
//            ],
//          ),
//          drawer: AppDrawer(),
//          body: ListView.builder(
//              padding: const EdgeInsets.all(16.0),
//              itemCount: model.toDoList?.length ?? 0,
//              itemBuilder: (BuildContext context, int i) {
//                return _buildRow(object: model.toDoList[i]);
//              }),
//        );
//      },
//    );
//  }
//
//  Widget _buildRow({TodoObject object}) {
//    return Card(
//      child: Container(padding: const EdgeInsets.all(5.0),child: new Text(object.title)),
//      elevation: 5.0,
//    );
//  }
//}
