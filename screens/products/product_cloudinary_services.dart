// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;

// Future<bool> uploadToloudinary(FilePickerResult? filePickerResult) async {
//   if (filePickerResult == null || filePickerResult.files.isEmpty) {
//     print('No file selected');
//     return false;
//   }

//   File file = File(filePickerResult.files.single.path!);
//   String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
// //MULTIPART REQUEST TO UPLOAD THE FILE
//   var uri = Uri.parse("http://api.cloudinary.com/v1_1/$cloudName/raw/upload");
//   var request = http.MultipartRequest("POST", uri);

//   //read the file content as bytes
//   var fileBytes = await file.readAsBytes();

//   var multipartFile = http.MultipartFile.fromBytes(
//     'file',
//     fileBytes,
//     filename: file.path.split("/").last,
//   );

//   //add the file part to the request
//   request.files.add(multipartFile);
//   request.fields['upload_preset'] = "product_images";
//   request.fields['resource_type'] = "raw";

//   //Send the req & await the response
//   var response = await request.send();

//   //get response as text
//   var responseBody = await response.stream.bytesToString();
//   print(responseBody);

//   if (response.statusCode == 200) {
//     print('Upload successful');
//     return true;
//   } else {
//     print('Upload failed with status: ${response.statusCode}');
//     return false;
//   }
// }
