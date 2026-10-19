import 'package:flutter/material.dart';

void main() {
  runApp(const ShrivastavaSewaApp());
}

class ShrivastavaSewaApp extends StatelessWidget {
  const ShrivastavaSewaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shrivastava Sewa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}

// ----------------- AUTH SCREEN -----------------
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.local_hospital_rounded,
                    size: 70,
                    color: Colors.teal,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Shrivastava Sewa',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isLogin ? 'Patient Login' : 'Naya Patient Registration',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 32),
                  if (!isLogin) ...[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Pura Naam (Full Name)',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Kripya apna naam enter karein';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextFormField(
                    controller: _emailPhoneController,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number ya Email',
                      prefixIcon: const Icon(Icons.contact_mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Kripya Email ya Mobile Number enter karein';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password kam se kam 6 characters ka hona chahiye';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      isLogin ? 'Login Karein' : 'Register Karein',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin
                          ? 'Naya account banana hai? Register karein'
                          : 'Pehle se account hai? Login karein',
                      style: const TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------- HOME PAGE -----------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shrivastava Sewa',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hamari Suvidhayein (Services)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildServiceCard(
                    context,
                    Icons.local_hospital,
                    'Doctor Consultation',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorListScreen(),
                        ),
                      );
                    },
                  ),
                  _buildServiceCard(
                    context,
                    Icons.medication,
                    'Dawaai (Medicine)',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Medicine store jald hi aayega!')),
                      );
                    },
                  ),
                  _buildServiceCard(
                    context,
                    Icons.biotech,
                    'Lab Tests',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lab test booking jald hi aayegi!')),
                      );
                    },
                  ),
                  _buildServiceCard(
                    context,
                    Icons.emergency,
                    'Emergency 24x7',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Emergency Helpline: 108 / 112')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    IconData icon,
    String title, {
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.teal),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------- DOCTOR LIST & BOOKING -----------------
class Doctor {
  final String name;
  final String specialty;
  final String experience;
  final int fee;
  final double rating;

  // Sudhar: Constructor ke aage 'const' add kiya
  const Doctor({
    required this.name,
    required this.specialty,
    required this.experience,
    required this.fee,
    required this.rating,
  });
}

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key});

  final List<Doctor> doctors = const [
    Doctor(
      name: 'Dr. Alok Verma',
      specialty: 'General Physician',
      experience: '10 saal ka anubhav',
      fee: 300,
      rating: 4.8,
    ),
    Doctor(
      name: 'Dr. Neha Sharma',
      specialty: 'Cardiologist (Hridya Rog)',
      experience: '12 saal ka anubhav',
      fee: 600,
      rating: 4.9,
    ),
    Doctor(
      name: 'Dr. Rajesh Patel',
      specialty: 'Pediatrician (Bachho ke Doctor)',
      experience: '8 saal ka anubhav',
      fee: 400,
      rating: 4.7,
    ),
    Doctor(
      name: 'Dr. Pooja Mishra',
      specialty: 'Dermatologist (Tawacha Rog)',
      experience: '6 saal ka anubhav',
      fee: 350,
      rating: 4.6,
    ),
  ];

  void _openBookingDialog(BuildContext context, Doctor doctor) {
    showDialog(
      context: context,
      builder: (ctx) => AppointmentDialog(doctor: doctor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Chunein'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doc = doctors[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.teal.shade100,
                    child: const Icon(Icons.person, size: 36, color: Colors.teal),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          doc.specialty,
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${doc.experience} • ₹${doc.fee}',
                          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.teal),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _openBookingDialog(context, doc),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: const Text('Book'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AppointmentDialog extends StatefulWidget {
  final Doctor doctor;
  const AppointmentDialog({super.key, required this.doctor});

  @override
  State<AppointmentDialog> createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<AppointmentDialog> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '10:00 AM';

  final List<String> slots = [
    '10:00 AM',
    '11:30 AM',
    '02:00 PM',
    '04:30 PM',
    '06:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Book Appointment\n${widget.doctor.name}', style: const TextStyle(fontSize: 18)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Specialty: ${widget.doctor.specialty}'),
            Text('Fees: ₹${widget.doctor.fee}'),
            const Divider(height: 24),
            const Text('Tarikh (Date):', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            OutlinedButton.icon(
              icon: const Icon(Icons.calendar_today, size: 18),
              label: Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
            ),
            const SizedBox(height: 14),
            const Text('Samay (Time Slot):', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: slots.map((slot) {
                final isSelected = selectedTime == slot;
                return ChoiceChip(
                  label: Text(slot),
                  selected: isSelected,
                  selectedColor: Colors.teal.shade200,
                  onSelected: (val) {
                    if (val) setState(() => selectedTime = slot);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Appointment Booked! (${widget.doctor.name} - $selectedTime)',
                ),
                backgroundColor: Colors.teal,
              ),
            );
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
