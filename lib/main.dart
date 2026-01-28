import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration_form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _sex = 'male';
  bool _machineLearning = false;
  bool _fullStack = false;
  bool _mobileApplication = false;
  double _tution = 900.90;
  String _userNameError = '';
  String _passwordError = '';
  bool _Submitted = false;
  bool _isPasswordVisible = false;

  void _validateAndSubmit() {
    setState(() {
      _userNameError = '';
      _passwordError = '';
      _Submitted = false;

      if (_usernameController.text.length != 10) {
        _userNameError = 'Username must be exactly 10 characters long';
      }
      if (_passwordController.text.length < 6) {
        _passwordError = 'Password must be at least 6 characters long';
      }
      if (_userNameError.isEmpty && _passwordError.isEmpty) {
        _Submitted = true;
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _Submitted = false;
      });
    });
  }

  void _clearForm() {
    setState(() {
      _usernameController.clear();
      _passwordController.clear();
      _sex = 'male';
      _machineLearning = false;
      _fullStack = false;
      _mobileApplication = false;
      _tution = 900.90;
      _Submitted = false;
      _userNameError = '';
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
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: _userNameError.isNotEmpty ? _userNameError : null,
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
            Row(
              children: [
                Radio<String>(
                  value: 'male',
                  groupValue: _sex,
                  onChanged: (value) {
                    setState(() {
                      _sex = value!;
                    });
                  },
                ),
                const Text('Male'),
                Radio<String>(
                  value: 'female',
                  groupValue: _sex,
                  onChanged: (value) {
                    setState(() {
                      _sex = value!;
                    });
                  },
                ),
                const Text('Female'),
              ],
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
            if (_Submitted)
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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}