import 'package:clanz/models/alert.dart';
import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:clanz/services/dialog_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  DialogManager({Key key, this.child}) : super(key: key);
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();
  TextEditingController textEditorController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    Alert(
        context: context,
        title: request.title,
        desc: request.description,
        closeFunction: () =>
            _dialogService.dialogComplete(AlertResponse(confirmed: false)),
        content: CupertinoTextField(
          placeholder: 'username',
          cursorColor: ClanzColors.getSecColor(),
          controller: textEditorController,
        ),
        buttons: [
          DialogButton(
            child: Text(request.buttonTitle),
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(
                  confirmed: true,
                  fieldOne: textEditorController.text.toString()));
              Navigator.of(context).pop();
            },
          )
        ]).show();
  }
}
