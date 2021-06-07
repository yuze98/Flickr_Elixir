import 'package:flutter_test/flutter_test.dart';

void main() {
  String public = "Public";
  String private = "Private";
  String dest;
  List<int> _selectedIndexList = [];
  List<String> publicList = [];
  List<String> privateList = [];
  List<String> imageList = [];
  bool isPublic;

  void movingTo(String destination) {
    if (destination == public) {
      for (int i = 0; i < _selectedIndexList.length; i++) {
        if (!publicList.contains(imageList[_selectedIndexList[i]]))
          publicList.add(imageList[_selectedIndexList[i]]);
      }
      isPublic = true;
    }

    if (destination == private) {
      for (int i = 0; i < _selectedIndexList.length; i++) {
        if (!private.contains(imageList[_selectedIndexList[i]]))
          privateList.add(imageList[_selectedIndexList[i]]);
      }
      isPublic = false;
    }
  }

  group('Valid moving to', () {
    test('value from true to false', () {
      dest = "Public";
      movingTo(dest);
      expect(isPublic, true);
    });

    test('Valid Changing password', () {
      dest = "Private";
      movingTo(dest);
      expect(isPublic, false);
    });
  });
}
