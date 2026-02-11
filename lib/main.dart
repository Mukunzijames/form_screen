import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration_form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Regex: valid email with @ and domain (e.g. user@example.com)
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Regex: at least one digit
  final RegExp _passwordNumberRegex = RegExp(r'[0-9]');

  // Regex: at least one special symbol
  final RegExp _passwordSymbolRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\/~`]');

  String _sex = 'male';
  bool _machineLearning = false;
  bool _fullStack = false;
  bool _mobileApplication = false;
  double _tution = 900.90;
  String _emailError = '';
  String _passwordError = '';
  bool _submitted = false;
  bool _isPasswordVisible = false;

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(email)) {
      return 'Enter a valid email (e.g. user@example.com)';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!_passwordNumberRegex.hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (!_passwordSymbolRegex.hasMatch(password)) {
      return 'Password must contain at least one symbol (!@#\$%^&* etc.)';
    }
    return null;
  }

  void _validateAndSubmit() {
    setState(() {
      _emailError = '';
      _passwordError = '';
      _submitted = false;

      final emailError = _validateEmail(_emailController.text);
      if (emailError != null) {
        _emailError = emailError;
      }

      final passwordError = _validatePassword(_passwordController.text);
      if (passwordError != null) {
        _passwordError = passwordError;
      }

      if (_emailError.isEmpty && _passwordError.isEmpty) {
        _submitted = true;
      }
    });

    if (_submitted) {
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _submitted = false;
          });
        }
      });
    }
  }

  void _clearForm() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _sex = 'male';
      _machineLearning = false;
      _fullStack = false;
      _mobileApplication = false;
      _tution = 900.90;
      _submitted = false;
      _emailError = '';
      _passwordError = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'user@example.com',
                errorText: _emailError.isNotEmpty ? _emailError : null,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _passwordError.isNotEmpty ? _passwordError : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            const Text('Sex'),
            RadioGroup<String>(
              groupValue: _sex,
              onChanged: (value) {
                setState(() {
                  _sex = value!;
                });
              },
              child: Row(
                children: [
                  Radio<String>(value: 'male'),
                  const Text('Male'),
                  Radio<String>(value: 'female'),
                  const Text('Female'),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Courses Interested In:'),
            CheckboxListTile(
              title: const Text('Machine Learning'),
              value: _machineLearning,
              onChanged: (value) {
                setState(() {
                  _machineLearning = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Full Stack'),
              value: _fullStack,
              onChanged: (value) {
                setState(() {
                  _fullStack = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Mobile Application'),
              value: _mobileApplication,
              onChanged: (value) {
                setState(() {
                  _mobileApplication = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text('Tution Fee:'),
            Slider(
              value: _tution,
              min: 500.0,
              max: 2000.0,
              divisions: 15,
              label: _tution.toStringAsFixed(2),
              onChanged: (value) {
                setState(() {
                  _tution = value;
                });
              },
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _validateAndSubmit,
                  child: const Text('Submit'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _clearForm,
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            if (_submitted)
              const Text(
                'Form Submitted Successfully!',
                style: TextStyle(color: Colors.green, fontSize: 16.0),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}