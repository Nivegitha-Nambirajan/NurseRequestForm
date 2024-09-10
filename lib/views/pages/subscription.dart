import 'package:flutter/material.dart';
import 'package:nurse_enroll/model/subscription_plan.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int selectedIndex = 0; // Selected subscription index

  @override
  Widget build(BuildContext context) {
    final List<SubscriptionPlan> items = [
      SubscriptionPlan('1 Month', 'Basic plan',
          ['Weekly health check-ins', 'Monthly health check-ins'], 2419.00),
      SubscriptionPlan('3 Months', 'You save 10%',
          ['Daily health check-ins', 'Weekly health check-ins'], 6173.00),
      SubscriptionPlan('6 Months', 'You save 20%',
          ['Weekly health check-ins', 'Monthly health check-ins'], 8012.00),
      SubscriptionPlan('12 Months', 'You save 30%',
          ['Weekly health check-ins', 'Monthly health check-ins'], 10012.00)
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Subscription'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        value: index,
                                        groupValue: selectedIndex,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedIndex = value!;
                                          });
                                        },
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item.month,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Text(item.offer,
                                              style: const TextStyle(
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '₹ ${item.amount.toStringAsFixed(2)}',
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
                          const Divider(thickness: 1), // Separator line
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: item.description.map((desc) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Text(
                                      desc,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'View More',
                                  style: TextStyle(
                                      color: Color(0xff3b42ba),
                                      decoration: TextDecoration.underline,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity, // Full width button
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3b42ba),
                ),
                onPressed: () {
                  // Pass the selected plan back to the home page
                  Navigator.pop(context, items[selectedIndex]);
                },
                child: const Text(
                  "Select",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
