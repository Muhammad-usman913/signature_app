import 'dart:typed_data';

import 'package:documentsignature/signature_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;


class CatchSignature extends StatefulWidget {
  const CatchSignature({Key? key}) : super(key: key);

  @override
  State<CatchSignature> createState() => _CatchSignatureState();
}

class _CatchSignatureState extends State<CatchSignature> {

  ByteData? bytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Signature'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: bytes == null ?  Container(
                  width:  150,
                  height: 150,
                color: Colors.green,
                child: Center(child: Text('Signature place holder'))
              ) : Container(
                width:  150,
                height: 150,
                child: Image.memory(bytes!.buffer.asUint8List()),
              )
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final signatureImage = await showDialog(
            context: context,
            builder: (BuildContext context) => SignatureDialog(),
          );
          print('Value that comes from dialog : $signatureImage');

          if(signatureImage != null){
            setState(() async{
              bytes =  await signatureImage.toByteData(format: ui.ImageByteFormat.png);
              print('The data in debuge $bytes');
            });
          }
        },
        child: Icon(Icons.ads_click),
      ),

    );
  }
}
