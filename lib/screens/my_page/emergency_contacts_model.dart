import 'package:flutter/material.dart';

class EmergencyContact {
  final String name;
  final String phoneNumber;
  final Color? backgroundColor;

  EmergencyContact({
    required this.name,
    required this.phoneNumber,
    this.backgroundColor,
  });
}