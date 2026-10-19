import 'package:flutter/material.dart';

void main() {
  runApp(const ShrivastavaSewaApp());
}

// Global booking list taaki screens ke beech data share ho sake
List<AppointmentRecord> userAppointments = [];

class AppointmentRecord {
  final String id;
  final String doctorName;
  final String specialty;
  final int fee;
  final DateTime date;
  final String time;

  AppointmentRecord({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.fee,
    required this.date,
    required this.time,
  });
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
        actions: [
          IconButton(
            tooltip: 'Meri Appointments',
            icon: const Icon(Icons.event_note, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyAppointmentsScreen(),
                ),
              );
            },
          ),
        ],
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MedicineStoreScreen(),
                        ),
                      );
                    },
                  ),
                  _buildServiceCard(
                    context,
                    Icons.biotech,
                    'Lab Tests',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LabTestListScreen(),
                        ),
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
            userAppointments.add(
              AppointmentRecord(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                doctorName: widget.doctor.name,
                specialty: widget.doctor.specialty,
                fee: widget.doctor.fee,
                date: selectedDate,
                time: selectedTime,
              ),
            );

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

// ----------------- MERI APPOINTMENTS & CANCEL -----------------
class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  void _cancelAppointment(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Appointment Cancel Karein?'),
        content: Text(
          'Kya aap sach mein ${userAppointments[index].doctorName} ke sath appointment cancel karna chahte hain?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Nahi'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                userAppointments.removeAt(index);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment safaltapoorvak cancel ho gayi hai!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Haan, Cancel Karein'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meri Appointments'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: userAppointments.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: 70, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  const Text(
                    'Abhi koi appointment booked nahi hai.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: userAppointments.length,
              itemBuilder: (context, index) {
                final appt = userAppointments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              appt.doctorName,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.teal.shade50,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Confirmed',
                                style: TextStyle(
                                  color: Colors.teal.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          appt.specialty,
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                        ),
                        const Divider(height: 18),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month, size: 16, color: Colors.teal),
                            const SizedBox(width: 6),
                            Text('${appt.date.day}/${appt.date.month}/${appt.date.year}'),
                            const SizedBox(width: 16),
                            const Icon(Icons.access_time, size: 16, color: Colors.teal),
                            const SizedBox(width: 6),
                            Text(appt.time),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                            ),
                            icon: const Icon(Icons.cancel_outlined, size: 16),
                            label: const Text('Cancel Appointment'),
                            onPressed: () => _cancelAppointment(index),
                          ),
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

// ----------------- LAB TESTS & BOOKING -----------------
class LabTest {
  final String title;
  final String description;
  final int price;
  final String reportTime;
  final bool fastingRequired;

  const LabTest({
    required this.title,
    required this.description,
    required this.price,
    required this.reportTime,
    required this.fastingRequired,
  });
}

class LabTestListScreen extends StatelessWidget {
  const LabTestListScreen({super.key});

  final List<LabTest> tests = const [
    LabTest(
      title: 'Complete Blood Count (CBC)',
      description: 'Hemoglobin, WBC, Platelet count aur infections ki jaanch',
      price: 299,
      reportTime: '12 Ghante',
      fastingRequired: false,
    ),
    LabTest(
      title: 'Diabetes Screen (HbA1c + Sugar)',
      description: 'Pichhle 3 mahine ka average sugar level test',
      price: 450,
      reportTime: '24 Ghante',
      fastingRequired: true,
    ),
    LabTest(
      title: 'Lipid Profile (Cholesterol)',
      description: 'Hridya (Heart) ki suraksha aur cholesterol jaanch',
      price: 550,
      reportTime: '24 Ghante',
      fastingRequired: true,
    ),
    LabTest(
      title: 'Full Body Health Checkup',
      description: '60+ mahatvapurna body parameters ki complete testing',
      price: 1199,
      reportTime: '24 to 36 Ghante',
      fastingRequired: true,
    ),
    LabTest(
      title: 'Thyroid Profile (T3, T4, TSH)',
      description: 'Thyroid gland hormone balance aur metabolism jaanch',
      price: 399,
      reportTime: '18 Ghante',
      fastingRequired: false,
    ),
  ];

  void _openBookingSheet(BuildContext context, LabTest test) {
    final addressCtrl = TextEditingController();
    DateTime selectedDate = DateTime.now().add(const Duration(days: 1));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 18,
                right: 18,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book Home Sample Collection',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    test.title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text('Price: ₹${test.price} (Free Sample Pickup)'),
                  const Divider(height: 20),
                  const Text('Sample Pickup Date:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_today, size: 16),
                    label: Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 14)),
                      );
                      if (picked != null) {
                        setModalState(() => selectedDate = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: addressCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Ghar ka Address (Home Address)',
                      hintText: 'Colony, Street, City enter karein',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        if (addressCtrl.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Kripya apna address enter karein')),
                          );
                          return;
                        }
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Lab Test Book Ho Gaya! Lab technician sample collect karne aayega.',
                            ),
                            backgroundColor: Colors.teal,
                          ),
                        );
                      },
                      child: const Text('Confirm Test Booking'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Tests & Health Packages'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: tests.length,
        itemBuilder: (context, index) {
          final t = tests[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          t.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '₹${t.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.description,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        'Report: ${t.reportTime}',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        t.fastingRequired ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                        size: 16,
                        color: t.fastingRequired ? Colors.orange.shade800 : Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        t.fastingRequired ? 'Fasting Zaroori' : 'No Fasting',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: t.fastingRequired ? Colors.orange.shade800 : Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      icon: const Icon(Icons.add_task, size: 18),
                      label: const Text('Book Test'),
                      onPressed: () => _openBookingSheet(context, t),
                    ),
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

// ----------------- MEDICINE STORE & ORDER -----------------
class Medicine {
  final String name;
  final String category;
  final int price;

  const Medicine({
    required this.name,
    required this.category,
    required this.price,
  });
}

class MedicineStoreScreen extends StatefulWidget {
  const MedicineStoreScreen({super.key});

  @override
  State<MedicineStoreScreen> createState() => _MedicineStoreScreenState();
}

class _MedicineStoreScreenState extends State<MedicineStoreScreen> {
  final List<Medicine> medicines = const [
    Medicine(name: 'Paracetamol 650mg', category: 'Bukhar / Dard', price: 30),
    Medicine(name: 'Azithromycin 500mg', category: 'Antibiotic', price: 120),
    Medicine(name: 'Cetirizine 10mg', category: 'Sardi / Allergy', price: 25),
    Medicine(name: 'Pantoprazole 40mg', category: 'Gas / Acidity', price: 75),
    Medicine(name: 'Vitamin C + Zinc', category: 'Immunity Booster', price: 90),
    Medicine(name: 'Cough Syrup 100ml', category: 'Khansi', price: 85),
  ];

  final Map<int, int> cart = {};

  int get totalPrice {
    int sum = 0;
    cart.forEach((index, qty) {
      sum += medicines[index].price * qty;
    });
    return sum;
  }

  int get totalItems {
    int count = 0;
    cart.forEach((_, qty) => count += qty);
    return count;
  }

  void _showCheckoutDialog() {
    final addressController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delivery Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kul Dawaai: $totalItems packet'),
            Text('Kul Rashi: ₹$totalPrice', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Delivery Address enter karein',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                cart.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order Successfully Place Ho Gaya! Dawaai jaldi deliver hogi.'),
                  backgroundColor: Colors.teal,
                ),
              );
            },
            child: const Text('Order Confirm Karein'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shrivastava Medical Store'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          final med = medicines[index];
          final qty = cart[index] ?? 0;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.teal.shade50,
                    child: const Icon(Icons.medication_outlined, color: Colors.teal),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          med.name,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          med.category,
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${med.price}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (qty == 0)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          cart[index] = 1;
                        });
                      },
                      child: const Text('Add'),
                    )
                  else
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.teal),
                          onPressed: () {
                            setState(() {
                              if (qty > 1) {
                                cart[index] = qty - 1;
                              } else {
                                cart.remove(index);
                              }
                            });
                          },
                        ),
                        Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, color: Colors.teal),
                          onPressed: () {
                            setState(() {
                              cart[index] = qty + 1;
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: totalItems > 0
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, -2))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$totalItems Item(s)', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                      Text('₹$totalPrice', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: _showCheckoutDialog,
                    child: const Text('Order Now'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
