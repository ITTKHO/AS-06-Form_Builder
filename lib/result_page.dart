import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> formData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Results'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Form Submission Results:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...formData.entries.map(
              (entry) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    entry.key.toUpperCase().replaceAll('_', ' '),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    _formatValue(entry.key, entry.value),
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Form'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันจัดรูปแบบค่าให้เหมาะสมกับประเภทข้อมูล
  String _formatValue(String key, dynamic value) {
    if (value == null) return 'Not provided';
    switch (key) {
      case 'travel_date_range':
        if (value is Map && value.containsKey('start') && value.containsKey('end')) {
          return '${value['start']?.toString().split(' ')[0]} to ${value['end']?.toString().split(' ')[0]}';
        }
        return value.toString();
      case 'appointment':
        return value.toString().split('.')[0]; // แสดงเฉพาะวันที่และเวลาหลัก
      case 'price_range':
        if (value is List && value.length == 2) {
          return '${value[0].toStringAsFixed(2)} - ${value[1].toStringAsFixed(2)} USD';
        }
        return value.toString();
      case 'interests':
      case 'skills':
        if (value is List) {
          return value.join(', ');
        }
        return value.toString();
      default:
        return value.toString();
    }
  }
}