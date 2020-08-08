import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imageshapecalculator/widgets/twoLineText.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: FaIcon(
          FontAwesomeIcons.infoCircle,
          color: Colors.grey,
          size: 30,
        ),
      ),
      onTap: () {
        print("Displaying info");
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: Text("Tipps"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TwoLineText(
                      topText: "Delete:",
                      topTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      bottomText:
                          "you can swipe Layers left or right to delete them",
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    SizedBox(height: 20),
                    TwoLineText(
                      topText: "Copy:",
                      topTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      bottomText: "you can double tap a Layers to copy them",
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    SizedBox(height: 20),
                    TwoLineText(
                      topText: "Modify:",
                      topTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      bottomText: "you can tap a Layers to modify them",
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    SizedBox(height: 20),
                    getCodeTip(),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("close"),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            });
      },
    );
  }

  Column getCodeTip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Code:", style: TextStyle(fontWeight: FontWeight.bold)),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "To see the source code for this app, please visit the ",
                style: TextStyle(color: Colors.black, fontSize: 16)),
            TextSpan(
                text: "github repository",
                style: TextStyle(color: Colors.blue, fontSize: 16),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final url =
                        "https://github.com/aeAlex/dnnImageLayerCalculator";
                    if (await canLaunch(url)) {
                      await launch(url, forceSafariVC: false);
                    }
                  }),
          ]),
        ),
      ],
    );
  }
}
