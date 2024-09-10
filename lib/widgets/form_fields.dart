import 'package:flutter/material.dart';

class FormFields extends StatefulWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final List<dynamic>? items;
  final Widget? prefixIcon;
  String? selectedItem;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TimeOfDay? selectedTime;
  final bool isDateField;
  final bool isTimeField;
  final bool isIconField;
  final Function(String)? onChanged;
  final String validationMsg;

  FormFields({
    Key? key,
    required this.title,
    this.hintText,
    this.controller,
    this.items,
    this.prefixIcon,
    this.selectedItem,
    this.isDateField = false,
    this.isIconField = false,
    this.isTimeField = false,
    this.onChanged,
    required this.validationMsg,
  }) : super(key: key);

  @override
  _FormFieldsState createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                fontFamily: "Manrope"),
          ),
        ),
        widget.items != null
            ? DropdownButtonFormField<String>(
                value: widget.selectedItem,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // ignore: prefer_const_constructors
                icon: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ),
                iconSize: 30,
                validator: (String? value) {
                  if (value == null) {
                    return widget.validationMsg;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.normal,
                        height: 4)),
                items: widget.items!
                    .map((item) {
                      if (widget.isIconField && item is Map<String, dynamic>) {
                        return DropdownMenuItem<String>(
                          value: item["label"],
                          child: Row(
                            children: [
                              Image.asset(
                                item["icon"],
                                width: 24,
                                height: 24,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                item["label"],
                                style: const TextStyle(fontFamily: "Manrope"),
                              ),
                            ],
                          ),
                        );
                      } else if (item is String) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontFamily: "Manrope"),
                          ),
                        );
                      }
                      return null;
                    })
                    .whereType<DropdownMenuItem<String>>()
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.selectedItem = newValue;
                    widget.onChanged?.call(newValue!);
                  });
                },
              )
            : widget.isDateField
                ? TextFormField(
                    readOnly: true,
                    onTap: () {
                      widget.selectedStartDate != null
                          ? _selectStartDate(widget.controller)
                          : _selectStartDate(widget.controller);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return widget.validationMsg;
                      }
                      return null;
                    },
                    style: const TextStyle(
                        fontFamily: "Manrope", fontWeight: FontWeight.w500),
                    controller: widget.controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Color(0xff3b42ba),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16),
                      hintText: widget.hintText,
                      prefixIcon: widget.prefixIcon,
                    ),
                  )
                : widget.isTimeField
                    ? TextFormField(
                        readOnly: true,
                        onTap: () {
                          _selectTime(widget.controller);
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return widget.validationMsg;
                          }
                          return null;
                        },
                        style: const TextStyle(
                            fontFamily: "Manrope", fontWeight: FontWeight.w500),
                        controller: widget.controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Color(0xff3b42ba),
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16),
                          hintText: widget.hintText,
                          prefixIcon: widget.prefixIcon,
                        ),
                      )
                    : TextFormField(
                        controller: widget.controller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return widget.validationMsg;
                          }
                          return null;
                        },
                        style: const TextStyle(
                            fontFamily: "Manrope", fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                          hintText: widget.hintText,
                          prefixIcon: widget.prefixIcon,
                        ),
                      ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> _selectStartDate(TextEditingController? controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != widget.selectedStartDate) {
      setState(() {
        widget.selectedStartDate = pickedDate;
        controller!.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
      widget.onChanged?.call(pickedDate.toString());
    }
  }

  Future<void> _selectEndDate(TextEditingController? controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != widget.selectedEndDate) {
      setState(() {
        widget.selectedEndDate = pickedDate;
        controller!.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
      widget.onChanged?.call(pickedDate.toString());
    }
  }

  Future<void> _selectTime(TextEditingController? controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: widget.selectedTime ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });
    if (pickedTime != null && pickedTime != widget.selectedTime) {
      setState(() {
        widget.selectedTime = pickedTime;
        final hour =
            pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod;
        final formattedTime =
            "${hour.toString().padLeft(2, '0')} : ${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period.name.toUpperCase()}";
        controller!.text = formattedTime;
      });
      widget.onChanged?.call(pickedTime.toString());
    }
  }
}
