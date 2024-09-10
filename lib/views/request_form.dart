import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nurse_enroll/model/form_manager.dart';
import 'package:nurse_enroll/model/subscription_plan.dart';
import 'package:nurse_enroll/views/pages/subscription.dart';
import 'package:nurse_enroll/widgets/document_form.dart';
import 'package:nurse_enroll/widgets/form_fields.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NurseRequestForm extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final NurseRequestFormManager formManager;

  NurseRequestForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.formManager,
  }) : _formKey = formKey;

  @override
  State<NurseRequestForm> createState() => _NurseRequestFormState();
}

class _NurseRequestFormState extends State<NurseRequestForm> {
  String? selectedValue;
  SubscriptionPlan? selectedPlan;
  final List<String> daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<String> fullDaysOfWeek = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thur',
    'Fri',
    'Sat'
  ];

  void toggleDaySelection(int index) {
    String day = fullDaysOfWeek[index];
    setState(() {
      if (widget.formManager.selectedDays.contains(day)) {
        widget.formManager.selectedDays.remove(day);
      } else {
        widget.formManager.selectedDays.add(day);
      }
    });
  }

  bool _areAllDaysSelected() {
    return widget.formManager.selectedDays.length == fullDaysOfWeek.length;
  }

  void toggleAllDaysSelection() {
    setState(() {
      if (_areAllDaysSelected()) {
        widget.formManager.selectedDays.clear();
      } else {
        widget.formManager.selectedDays = List.from(fullDaysOfWeek);
      }
    });
  }

  String getSelectedDaysSummary() {
    if (widget.formManager.selectedDays.isEmpty) {
      return "No days selected.";
    } else {
      return "Will repeat every week on ${widget.formManager.selectedDays.join(', ')}.";
    }
  }

  void updateDuration(int hours) {
    setState(() {
      widget.formManager.duration = hours;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: const Icon(Icons.arrow_back)),
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  "Nurse Request Form",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontFamily: "Manrope"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FormFields(
            title: "Type of Care",
            hintText: "Type of Care",
            items: const [
              "Palliative and hospice Care",
              "Critical Care",
              "Physiotherapy",
              "Helping Nurse"
            ],
            selectedItem: widget.formManager.typeOfCare,
            onChanged: (value) {
              widget.formManager.typeOfCare = value;
            },
            validationMsg: "Please choose Type of Care",
          ),
          FormFields(
            title: "Type of Nursing Service Required",
            hintText: "Type of Nursing Service Required",
            items: const ["CNA", "RNP", "CCN", "Others"],
            selectedItem: widget.formManager.typeOfService,
            onChanged: (value) {
              widget.formManager.typeOfService = value;
            },
            validationMsg: "Please choose Type of Nursing Service Required",
          ),
          FormFields(
            title: "Number of Nurses Required",
            hintText: "Nurse Count",
            controller: widget.formManager.nurseCount,
            validationMsg: "Please enter Number of Nurses Required",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.44,
                  child: FormFields(
                    title: "Start Date",
                    hintText: "Choose",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 8),
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                    ),
                    isDateField: true,
                    controller: widget.formManager.startDateController,
                    onChanged: (value) {
                      widget.formManager.selectedStartDate =
                          DateTime.tryParse(value);
                      print("value :${widget.formManager.selectedStartDate}");
                    },
                    validationMsg: "Please choose Start Date",
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.44,
                  child: FormFields(
                    title: "End Date",
                    hintText: "Choose",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 8),
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                    ),
                    isDateField: true,
                    controller: widget.formManager.endDateController,
                    onChanged: (value) {
                      widget.formManager.selectedEndDate =
                          DateTime.tryParse(value);
                      print("value :${widget.formManager.selectedEndDate}");
                    },
                    validationMsg: "Please choose End Date",
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: FormFields(
                  title: "Start Time",
                  hintText: "Choose",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 8),
                    child: Icon(
                      Icons.access_time,
                      color: Colors.grey,
                    ),
                  ),
                  isTimeField: true,
                  controller: widget.formManager.startTimeController,
                  onChanged: (value) {
                    try {
                      widget.formManager.selectedTime = value;
                      print(
                          "Selected Time: ${widget.formManager.selectedTime!}");
                    } catch (e) {
                      print("Error parsing time: $e");
                    }
                  },
                  validationMsg: "Please choose Start time",
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: const Text(
                      "Duration",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: "Manrope"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.22,
                            child: TextFormField(
                              readOnly: true,
                              showCursor: false,
                              onTap: () => updateDuration(8),
                              style: const TextStyle(
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: widget.formManager.duration == 8
                                    ? const Color.fromARGB(255, 221, 221, 245)
                                    : Colors.transparent,
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
                                    horizontal: 20.0, vertical: 16.0),
                                hintText: "8 Hrs",
                              ),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.22,
                            child: TextFormField(
                              readOnly: true,
                              showCursor: false,
                              onTap: () => updateDuration(12),
                              style: const TextStyle(
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: widget.formManager.duration == 12
                                    ? const Color.fromARGB(255, 221, 221, 245)
                                    : Colors.transparent,
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
                                    horizontal: 20.0, vertical: 16.0),
                                hintText: "12 Hrs",
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.translate(
                offset: const Offset(-8, 0),
                child: Checkbox(
                  value: widget.formManager.repeatOnEvery,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.formManager.repeatOnEvery = value ?? false;
                    });
                  },
                  visualDensity:
                      VisualDensity.compact, // Reduces checkbox padding
                  checkColor:
                      const Color(0xff3b42ba), // Sets the checkmark color
                  activeColor: Colors
                      .white, // This ensures the background is white when selected
                  side: WidgetStateBorderSide.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return const BorderSide(
                          color:
                              Color(0xff3b42ba)); // Border color when selected
                    }
                    return const BorderSide(
                        color: Color(
                            0xff3b42ba)); // Border color when not selected
                  }),
                ),
              ),
              const Text(
                'Repeat on Every',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          if (widget.formManager.repeatOnEvery)
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5.0,
              runSpacing: 5.0,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                    backgroundColor: _areAllDaysSelected()
                        ? const Color.fromARGB(255, 221, 221, 245)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: _areAllDaysSelected()
                          ? const Color(0xff3b42ba)
                          : const Color.fromARGB(255, 199, 197, 197),
                    ), // Optional: Add border color
                  ),
                  onPressed: () => toggleAllDaysSelection(),
                  child: const Text(
                    "All Days",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    thickness: 2,
                    width: 10,
                    color: Colors.grey,
                  ),
                ),
                ...List.generate(daysOfWeek.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 15),
                          backgroundColor: widget.formManager.selectedDays
                                  .contains(fullDaysOfWeek[index])
                              ? const Color.fromARGB(255, 221, 221, 245)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(
                            color: widget.formManager.selectedDays
                                    .contains(fullDaysOfWeek[index])
                                ? const Color(0xff3b42ba)
                                : const Color.fromARGB(255, 199, 197, 197),
                          ), // Optional: Add border color
                        ),
                        onPressed: () => toggleDaySelection(index),
                        child: Text(
                          daysOfWeek[index],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          if (widget.formManager.repeatOnEvery)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.88,
                child: Text(
                  getSelectedDaysSummary(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          const SizedBox(height: 20),
          DocumentWidget(
            selectedFiles: widget.formManager.documents,
          ),
          const Text(
            "Additional Notes",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                fontFamily: "Manrope"),
          ),
          const SizedBox(height: 20),
          TextFormField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Add more instructions',
              hintStyle: const TextStyle(
                  fontFamily: "Manrope", fontWeight: FontWeight.normal),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide:
                    const BorderSide(color: Color(0xff3b42ba), width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Patient Information",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: "Manrope"),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: Color(0xff3b42ba),
                      ),
                    ),
                    TextSpan(
                      text: " Edit",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff3b42ba),
                          fontFamily: "Manrope"),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 211, 213, 250),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ishan Mistry',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 146, 151, 238),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '30 yrs',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.fiber_manual_record,
                            size: 8,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Male',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '+91 9876543210',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: const Text(
                        'No.11, Museum Rd, Governor Peta, Vijayawada, Andra Pradesh 520002, India',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          selectedPlan == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add Subscription",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: "Manrope"),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 211, 213, 250),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/Subscription_Icon.svg',
                                height: 60,
                                width: 60,
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: const Text(
                                  'Save upto 30% on your bookings with our subscription plans',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    side: const BorderSide(
                                      color: Color(0xff3b42ba),
                                      width: 2,
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SubscriptionPage()),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        selectedPlan = result;
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "Add subscription",
                                    style: TextStyle(
                                        color: Color(0xff3b42ba),
                                        fontFamily: "Manrope",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Subscription",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: "Manrope"),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubscriptionPage()),
                        );
                        if (result != null) {
                          setState(() {
                            selectedPlan = result;
                          });
                        }
                      },
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(selectedPlan!.month,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '₹ ${selectedPlan!.amount.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Divider(thickness: 1),
                              const Text(
                                "Plan will become effective after your payment",
                                style: TextStyle(
                                    color: Color.fromARGB(136, 100, 97, 97),
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
