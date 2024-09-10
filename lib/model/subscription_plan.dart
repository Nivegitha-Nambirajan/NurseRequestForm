import 'dart:ffi';

class SubscriptionPlan {
  final String month;
  final String offer;
  final List<String> description;
  final double amount;
  SubscriptionPlan(this.month, this.offer, this.description, this.amount);
}
