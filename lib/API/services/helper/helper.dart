import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Helper{
  Helper(){
    debugPrint('Helper has been triggered!');
  }
  void share(BuildContext context, String text) {
    // Share the text
    Share.share(text);
  }

  void shareEvent(BuildContext context, {String content = '', }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Event Code'),
              onTap: () {
                Navigator.pop(context);
                Share.share(content);
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy to Clipboard'),
              onTap: () {
                Navigator.pop(context);
                Clipboard.setData(ClipboardData(text: content)).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}