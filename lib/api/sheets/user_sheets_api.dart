

import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';
import 'package:quiz_app/models/sheet.dart';

class UserSheetsApi {
  static const _credentials = r'''

 {
  "type": "service_account",
  "project_id": "quiz-316808",
  "private_key_id": "4192b0b1aa7a7e0db7cab444517bfc2890cba768",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCUiMFuY+a7CZ0C\nGPDcvUzRATz2663KSlUIMhI0eV/46FVluSLMVdZOl3edvTqdi+pLColdv8BFaC0J\n9wrNf8g+uBGOYTondK4t9kiA66dM08Cu5w3zTglZXAAbgjE1TdOzp+BOQI2DV1w2\n2QwFwJTBpl6B/X0Pq5rpAd0lrMJlueVGe/TEdUfAxQ21DXHUXooI709Qci1PoM4S\ng6Zz7ApggkZmXP+6uWdAvyRxnSi6xP/orZpPZ5j6KPlEZxbl6qHoqu885FYeC7sJ\ncnRWjKrKdQlqlYNVmtuDYth514Tu20A1bYsVkDg1HIjm00bRE9GvFYfKhV0ehYXk\nB/Ovq58bAgMBAAECggEACnvTOJ5r1PxrDOXZF6DI1jZXKOUeQW6ZAoNo44lEQTDs\n2MmGGj6zafKo6lpGfoOMnY/4fW8g/AUhVgMOISO0F4aDFAtAFomBbb8PWQIeWdQs\nVRamgRYbSiet3kMvLqBNS/CSar4wVCU2CK0DJeN03GzeCMttKKOnwxXIQnYndmna\nogjQarSORf4Mt9UtjcuUY2f+j42vQQ4Apsm3VF4zw8JjwCBg+tC5IAbUk3u170CN\nYstXD3Xaow0bost41L5B9ts+Fx9Uc675VBKY6pr5vLwRv6bN0mi3NT5jDhFbsOda\n/IOav7wnptglgpGTTHO84Jhdy9MmMvHO6Kb5wnLZ8QKBgQDOM+EhVdBSW518b5z5\n7f7jQnVTGrwLopncQyxY7DXRxgd/4iWoVRBloy5rN3VV3Td5NRt5OfxgEacu6NT4\na1o79HeraLrT6M7cqKE+/oE/kFF+B/XuRoXHv4NanaMMSaxx3Rhcu2Wmal0Z8x8V\nkVN2PK+o9Vk8HvQ0KK9CBjqzSQKBgQC4Z5/WUXYjpnqPyJJtg+kPFHPcw02ZO2Sa\nELyOaAalaR+KloJc2M8tlyXgoft4dHKAcmjxf9lQNoltPRbMPrujOy0IVTfUSAyl\nPihuHXEjs946Upk6fKaiDiEcw0JWwrcWAOT3j9rMXR+so4GwjkNfpyngALZR6qp4\nwqPFrDYbQwKBgEjenJijMtNn/OeUqezI5mJ5gey0be/OroDgXDOwhfRz/wJ6cMRk\nCz9fw2+wUY7edlQnKGZWz5FDq8kwDtMbXPADHKc+g4ePpkrkbNdOKW7FGYdoWMiz\ns2M7krfbLVuSTZaPg6SBtRJyVCRvfnSovs3x9EHJMpfEeJhWKFk0ylnBAoGBAJ0t\nFfvi60Nvvr+XQde+u4Ny916PyTB2g0UeRtlKqX+LnqrNpsfktJIzZsGUz3bYKlB5\nNCHDy0KneXN2wlvMjLqQ0c1sdW2nC8A8vtE8nxbDVQN5K8nCPXWbfXW6qGyzAsLq\neD7aiq/uH/VSWFRYrex12ydm8//WeP79SAJQyr1pAoGBAKHkwJ1VoTMC+3A6c9gm\nRpk5iVuHVupfTn+qvC8sDeE/jBkX+97GiL2ZTzaXqIf/C1s44gGd2iKP/34+XKk2\naItJa54JTFscy34ZFokgfjs1tazUKSBdiKI2h95Tt7i2RLZNIsVeBlf+6V80tXKh\nVPHq8B65Gd2ANVvLrOhW3o6T\n-----END PRIVATE KEY-----\n",
  "client_email": "quiz-331@quiz-316808.iam.gserviceaccount.com",
  "client_id": "110338932075532676790",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/quiz-331%40quiz-316808.iam.gserviceaccount.com"
}


  
   ''';
  static const _spreadsheetid = '1KSKOZfAR2rzJlieqEwMFAim8tGxXy1ur4XuqYud8w68';

  static final _gsheets = GSheets(_credentials);

  static Worksheet _userSheet;

  static Future init() async {
    try {
      final Spreadsheet = await _gsheets.spreadsheet(_spreadsheetid);
      _userSheet = await _geWorkSheet(Spreadsheet, title: 'Quiz');

      final firstRow = UserFeilds.getFeilds();
      _userSheet.values.insertRow(1, firstRow);
      print('Init Error: $UserFeilds');
    } on Exception catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _geWorkSheet(
    Spreadsheet spreadsheet, {
    @required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;
    _userSheet.values.map.appendRows(rowList);
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;
    final lastRow = await _userSheet.values.lastRow();
    return lastRow== null ?0: int.tryParse(lastRow.first)?? 0;
  }
}
