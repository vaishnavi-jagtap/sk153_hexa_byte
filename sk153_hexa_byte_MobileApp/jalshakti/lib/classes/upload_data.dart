import 'package:http/http.dart' as http;
import 'dart:io';

import 'Constants.dart';

class UploadData {
  var response;
  var error;

  _setResponse(response) {
    this.response = response;
  }

  _setErrorResponse(error) {
    this.error = error;
  }

  String getErrorResponse() {
    return this.error;
  }

  String getResponse() {
    return this.response;
  }

  Future<bool> sendImageDataToServer(imagePath, url) async {
    bool flag = true;

    var request = http.MultipartRequest("POST", Uri.parse(SERVER_URL + url));

    var image =
        await http.MultipartFile.fromPath("image-file", File(imagePath).path);

    request.files.add(image);
    http.StreamedResponse response = await request.send().catchError((error) {
      flag = false;
    });

    //Get the response from the server
    if (flag) {
      print(response.statusCode);
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      _setResponse(responseString);
    } else {
      _setErrorResponse("Some error occured uploading image");
    }

    return flag;
  }
}
