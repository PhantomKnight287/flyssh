import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/widgets/input.dart';

class CreateDirectoryDialog extends StatefulWidget {
  const CreateDirectoryDialog({super.key});

  @override
  State<CreateDirectoryDialog> createState() => _CreateDirectoryDialogState();
}

class _CreateDirectoryDialogState extends State<CreateDirectoryDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("New Directory"),
      content: InputField(
        hintText: "Directory name",
        controller: _controller,
        autoFocus: true,
        onFieldSubmitted: (_) {
          Navigator.pop(context, _controller.text);
        },
      ),
      actions: [
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        FButton(
          onPress: () {
            Navigator.pop(context, _controller.text);
          },
          child: Text("Create"),
        ),
      ],
    );
  }
}
