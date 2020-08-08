import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  static String routeName = 'edit_page';

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool _editCard = false;
  String _title = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card: $_title '),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Form(
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Value'),
            ),
          ),
        ],
      ),
    );
  }
}
