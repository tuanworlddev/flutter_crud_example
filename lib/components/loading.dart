import 'package:flutter/material.dart';

class Loading {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Người dùng không thể tắt dialog bằng cách nhấn ra ngoài
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Làm trong suốt nền dialog
          elevation: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(), // Hiển thị vòng quay loading
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop(); // Đóng dialog loading
  }
}


