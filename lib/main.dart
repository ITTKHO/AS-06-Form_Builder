//AS-06
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'result_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Builder Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/form': (context) => const FormScreen(),
        '/result': (context) => const ResultScreen(),
      },
    );
  }
}

// Home page
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/form');
              },
              child: const Text('Go to Form'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/result', arguments: <String, dynamic>{});
              },
              child: const Text('View Results'),
            ),
          ],
        ),
      ),
    );
  }
}

// หน้าจอฟอร์ม
class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comprehensive Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FormBuilderTextField: Username
              FormBuilderTextField(
                name: 'username',
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Please enter your username'),
                  FormBuilderValidators.match(r'^[a-zA-Z0-9_]{3,20}$', errorText: 'Invalid username format'),
                  FormBuilderValidators.minLength(3, errorText: 'Username must be at least 3 characters'),
                  FormBuilderValidators.maxLength(20, errorText: 'Username must not exceed 20 characters'),
                ]),
              ),
              const SizedBox(height: 16),

              // FormBuilderTextField: Email
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Please enter your email'),
                  FormBuilderValidators.email(errorText: 'Please enter a valid email'),
                ]),
              ),
              const SizedBox(height: 16),

              // FormBuilderTextField: Password
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Please enter your password'),
                  FormBuilderValidators.minLength(8, errorText: 'Password must be at least 8 characters'),
                  FormBuilderValidators.match(
                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
                    errorText: 'Password must be at least 8 characters with 1 uppercase, 1 lowercase, 1 number, and 1 special character',
                  ),
                ]),
              ),
              const SizedBox(height: 16),

             
              // FormBuilderCheckbox: Accept Terms
              FormBuilderCheckbox(
                name: 'accept_terms',
                title: const Text('Accept Terms and Conditions'),
                validator: FormBuilderValidators.equal(true, errorText: 'You must accept the terms'),
              ),
              const SizedBox(height: 16),

              // FormBuilderCheckboxGroup: Interests
              FormBuilderCheckboxGroup<String>(
                name: 'interests',
                decoration: const InputDecoration(labelText: 'Interests'),
                options: const [
                  FormBuilderFieldOption(value: 'reading', child: Text('Reading')),
                  FormBuilderFieldOption(value: 'gaming', child: Text('Gaming')),
                  FormBuilderFieldOption(value: 'traveling', child: Text('Traveling')),
                ],
                validator: FormBuilderValidators.minLength(1, errorText: 'Select at least one interest'),
              ),
              const SizedBox(height: 16),

              // FormBuilderChoiceChip: User Type
              FormBuilderChoiceChip<String>(
                name: 'user_type',
                decoration: const InputDecoration(labelText: 'User Type'),
                options: const [
                  FormBuilderChipOption(value: 'student', child: Text('Student')),
                  FormBuilderChipOption(value: 'professional', child: Text('Professional')),
                  FormBuilderChipOption(value: 'other', child: Text('Other')),
                ],
                validator: FormBuilderValidators.required(errorText: 'Please select a user type'),
              ),
              const SizedBox(height: 16),

              // FormBuilderDateRangePicker: Travel Date Range
              FormBuilderDateRangePicker(
                name: 'travel_date_range',
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                decoration: const InputDecoration(
                  labelText: 'Travel Date Range',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(errorText: 'Please select a date range'),
              ),
              const SizedBox(height: 16),

              // FormBuilderDateTimePicker: Appointment
              FormBuilderDateTimePicker(
                name: 'appointment',
                inputType: InputType.both,
                decoration: const InputDecoration(
                  labelText: 'Appointment Date and Time',
                  border: OutlineInputBorder(),
                ),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                validator: FormBuilderValidators.required(errorText: 'Please select an appointment date and time'),
              ),
              const SizedBox(height: 16),

              // FormBuilderDropdown: Country
              FormBuilderDropdown<String>(
                name: 'country',
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'usa', child: Text('USA')),
                  DropdownMenuItem(value: 'canada', child: Text('Canada')),
                  DropdownMenuItem(value: 'thailand', child: Text('Thailand')),
                ],
                validator: FormBuilderValidators.required(errorText: 'Please select a country'),
              ),
              const SizedBox(height: 16),

              // FormBuilderFilterChip: Skills
              FormBuilderFilterChip<String>(
                name: 'skills',
                decoration: const InputDecoration(labelText: 'Skills'),
                options: const [
                  FormBuilderChipOption(value: 'coding', child: Text('Coding')),
                  FormBuilderChipOption(value: 'design', child: Text('Design')),
                  FormBuilderChipOption(value: 'management', child: Text('Management')),
                ],
                validator: FormBuilderValidators.minLength(1, errorText: 'Select at least one skill'),
              ),
              const SizedBox(height: 16),

              // FormBuilderRadioGroup: Gender
              FormBuilderRadioGroup<String>(
                name: 'gender',
                decoration: const InputDecoration(labelText: 'Gender'),
                options: const [
                  FormBuilderFieldOption(value: 'male', child: Text('Male')),
                  FormBuilderFieldOption(value: 'female', child: Text('Female')),
                  FormBuilderFieldOption(value: 'other', child: Text('Other')),
                ],
                validator: FormBuilderValidators.required(errorText: 'Please select a gender'),
              ),
              const SizedBox(height: 16),

             

              // FormBuilderSlider: Satisfaction Score
              FormBuilderSlider(
                name: 'satisfaction',
                min: 0.0,
                max: 10.0,
                divisions: 10,
                initialValue: 5.0,
                decoration: const InputDecoration(labelText: 'Satisfaction Score'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Please select a satisfaction score'),
                  FormBuilderValidators.min(5, errorText: 'Satisfaction must be at least 5'),
                  FormBuilderValidators.max(10, errorText: 'Satisfaction must be at most 10'),
                ]),
              ),
              const SizedBox(height: 16),

              // FormBuilderSwitch: Notifications
              FormBuilderSwitch(
                name: 'notifications',
                title: const Text('Enable Notifications'),
                initialValue: true,
                validator: FormBuilderValidators.equal(true, errorText: 'Notifications must be enabled'),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    final formData = _formKey.currentState!.value;
                    Navigator.pushNamed(
                      context,
                      '/result',
                      arguments: formData,
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// หน้าจอแสดงผลลัพธ์
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  // Static history list
  static final List<Map<String, dynamic>> _history = [];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? formData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Add new submission to history if present and not empty
    if (formData != null && formData.isNotEmpty) {
      _history.add(Map<String, dynamic>.from(formData));
    }

    final hasHistory = _history.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Form Results')),
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
            if (hasHistory)
              ..._history.asMap().entries.map((historyEntry) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Submission #${historyEntry.key + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ...historyEntry.value.entries.map(
                    (entry) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
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
                  const SizedBox(height: 12),
                ],
              ))
            else
              const Center(
                child: Text(
                  'No data submitted yet.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Form'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatValue(String key, dynamic value) {
    if (value == null) return 'Not provided';
    switch (key) {
      case 'travel_date_range':
        if (value is Map && value.containsKey('start') && value.containsKey('end')) {
          return '${value['start']?.toString().split(' ')[0]} to ${value['end']?.toString().split(' ')[0]}';
        }
        return value.toString();
      case 'appointment':
        return value.toString().split('.')[0];
      
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