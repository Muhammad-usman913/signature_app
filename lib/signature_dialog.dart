import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart'; // Import the signature package

class SignatureDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignatureController _controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );

    return AlertDialog(
      title: Text('Sign Here'),
      content: Container(
        height: 300,
        child: Signature(
          controller: _controller,
          height: 280,
          backgroundColor: Colors.white,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            Navigator.pop(context, _controller.toPngBytes());
          },
        ),
      ],
    );
  }
}

class SignatureScreen extends StatefulWidget {
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  Uint8List? _signature;

  Future<void> _showSignatureDialog(BuildContext context) async {
    final signature = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SignatureDialog();
      },
    );

    if (signature != null) {
      setState(() {
        _signature = signature;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signature Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if (_signature != null)
              Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Image.memory(_signature!,width: 50,height: 50,),
              )
            else
              Text('No signature yet'),
            ElevatedButton(
              onPressed: () => _showSignatureDialog(context),
              child: Text('Open Signature Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SignatureScreen()));
}
