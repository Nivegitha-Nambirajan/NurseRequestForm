import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DocumentWidget extends StatefulWidget {
  DocumentWidget({Key? key, required this.selectedFiles}) : super(key: key);

  List<PlatformFile> selectedFiles;

  @override
  _DocumentWidgetState createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentWidget> {
  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        widget.selectedFiles.addAll(result.files);
      });
    }
  }

  IconData _getFileIcon(String extension) {
    switch (extension) {
      case 'pdf':
        return FontAwesomeIcons.filePdf;
      case 'jpeg':
      case 'jpg':
      case 'png':
        return FontAwesomeIcons.fileImage;
      default:
        return FontAwesomeIcons.file;
    }
  }

  void _removeFile(PlatformFile file) {
    setState(() {
      widget.selectedFiles.remove(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Documents",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                fontFamily: "Manrope"),
          ),
        ),
        GestureDetector(
          onTap: _pickFiles,
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: RichText(
                text: const TextSpan(
                  text: "Add ",
                  style: TextStyle(
                      color: Color(0xff3b42ba),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Manrope"),
                  children: <TextSpan>[
                    TextSpan(
                      text: "your files here",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Manrope"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "File size should be within 10 mb (PDF, JPEG, PNG)",
          style: TextStyle(
              color: Colors.grey, fontSize: 14, fontFamily: "Manrope"),
        ),
        const SizedBox(height: 8),
        if (widget.selectedFiles.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.selectedFiles.map((file) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(
                      _getFileIcon(file.extension ?? ""),
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        file.name,
                        style: const TextStyle(
                            fontSize: 16, fontFamily: "Manrope"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _removeFile(file),
                      child: const Icon(Icons.close, color: Colors.red),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
