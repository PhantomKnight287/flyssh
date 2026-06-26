import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/models/port_forward.dart';

class AddForwardDialog extends StatefulWidget {
  const AddForwardDialog({super.key});

  @override
  State<AddForwardDialog> createState() => _AddForwardDialogState();
}

class _AddForwardDialogState extends State<AddForwardDialog> {
  PortForwardType _type = PortForwardType.local;
  final _formKey = GlobalKey<FormState>();
  final _bindPortController = TextEditingController();
  final _targetHostController = TextEditingController();
  final _targetPortController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _targetHostController.text =
        _type == PortForwardType.local ? '' : 'localhost';
  }

  @override
  void dispose() {
    _bindPortController.dispose();
    _targetHostController.dispose();
    _targetPortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Port Forward'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SegmentedButton<PortForwardType>(
                segments: const [
                  ButtonSegment(
                    value: PortForwardType.local,
                    label: Text('Local'),
                    icon: Icon(Icons.arrow_forward),
                  ),
                  ButtonSegment(
                    value: PortForwardType.remote,
                    label: Text('Remote'),
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
                selected: {_type},
                onSelectionChanged: (selected) {
                  setState(() {
                    _type = selected.first;
                    _targetHostController.text =
                        _type == PortForwardType.local ? '' : 'localhost';
                  });
                },
              ),
              SizedBox(height: BASE_SPACE * 4),
              Text(
                _type == PortForwardType.local
                    ? 'Bind a local port and forward traffic to a remote host'
                    : 'Bind a remote port and forward traffic back to a local host',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: BASE_SPACE * 3),
              TextFormField(
                controller: _bindPortController,
                decoration: InputDecoration(
                  labelText: _type == PortForwardType.local
                      ? 'Local Port'
                      : 'Remote Port',
                  hintText: 'e.g. 8080',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final port = int.tryParse(v);
                  if (port == null || port < 1 || port > 65535) {
                    return 'Enter a valid port (1-65535)';
                  }
                  return null;
                },
              ),
              SizedBox(height: BASE_SPACE * 2),
              TextFormField(
                controller: _targetHostController,
                decoration: InputDecoration(
                  labelText: _type == PortForwardType.local
                      ? 'Remote Host'
                      : 'Local Host',
                  hintText: _type == PortForwardType.local
                      ? 'e.g. 127.0.0.1'
                      : 'localhost',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  return null;
                },
              ),
              SizedBox(height: BASE_SPACE * 2),
              TextFormField(
                controller: _targetPortController,
                decoration: InputDecoration(
                  labelText: _type == PortForwardType.local
                      ? 'Remote Port'
                      : 'Local Port',
                  hintText: 'e.g. 80',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final port = int.tryParse(v);
                  if (port == null || port < 1 || port > 65535) {
                    return 'Enter a valid port (1-65535)';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FButton(
          onPress: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, {
                'type': _type,
                'bindPort': int.parse(_bindPortController.text),
                'targetHost': _targetHostController.text,
                'targetPort': int.parse(_targetPortController.text),
              });
            }
          },
          child: const Text('Start'),
        ),
      ],
    );
  }
}
