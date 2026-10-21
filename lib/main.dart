
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaundryCare',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const LaundryPage(),
    );
  }
}

class LaundryPage extends StatefulWidget {
  const LaundryPage({super.key});

  @override
  State<LaundryPage> createState() => _LaundryPageState();
}

class _LaundryPageState extends State<LaundryPage> {
  final namaController = TextEditingController();
  final beratController = TextEditingController();

  final List<Map<String, dynamic>> pesanan = [];

  final int hargaPerKg = 7000;

  @override
  void dispose() {
    namaController.dispose();
    beratController.dispose();
    super.dispose();
  }

  void tambahPesanan() {
    String nama = namaController.text.trim();
    double? berat = double.tryParse(
      beratController.text.replaceAll(',', '.'),
    );

    if (nama.isEmpty || berat == null || berat <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi nama dan berat cucian dengan benar.'),
        ),
      );
      return;
    }

    setState(() {
      pesanan.add({
        'nama': nama,
        'berat': berat,
        'total': (berat * hargaPerKg).round(),
        'status': 'Diproses',
      });

      namaController.clear();
      beratController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pesanan berhasil ditambahkan.')),
    );
  }

  void ubahStatus(int index) {
    setState(() {
      pesanan[index]['status'] =
          pesanan[index]['status'] == 'Diproses'
              ? 'Selesai'
              : 'Diproses';
    });
  }

  String rupiah(int nilai) {
    return 'Rp ${nilai.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    int totalPesanan = pesanan.length;
    int pesananSelesai = pesanan
        .where((item) => item['status'] == 'Selesai')
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LaundryCare'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Pencatatan Laundry',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Catat pesanan dan pantau cucian pelanggan.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(Icons.local_laundry_service,
                        color: Colors.blue, size: 30),
                    const SizedBox(height: 6),
                    Text(
                      '$totalPesanan',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Total Pesanan'),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.check_circle,
                        color: Colors.green, size: 30),
                    const SizedBox(height: 6),
                    Text(
                      '$pesananSelesai',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Selesai'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            'Tambah Pesanan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: namaController,
            decoration: const InputDecoration(
              labelText: 'Nama pelanggan',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: beratController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Berat cucian (kg)',
              prefixIcon: Icon(Icons.scale_outlined),
              border: OutlineInputBorder(),
              suffixText: 'kg',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),

          const SizedBox(height: 8),

          Builder(
            builder: (context) {
              double berat = double.tryParse(
                    beratController.text.replaceAll(',', '.'),
                  ) ??
                  0;

              return Text(
                'Perkiraan biaya: ${rupiah((berat * hargaPerKg).round())}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: tambahPesanan,
              icon: const Icon(Icons.add),
              label: const Text('Simpan Pesanan'),
            ),
          ),

          const SizedBox(height: 25),
          const Text(
            'Daftar Pesanan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          if (pesanan.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Belum ada pesanan laundry.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),

          ...List.generate(pesanan.length, (index) {
            final item = pesanan[index];
            final selesai = item['status'] == 'Selesai';

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        selesai ? Colors.green.shade100 : Colors.blue.shade100,
                    child: Icon(
                      selesai ? Icons.check : Icons.local_laundry_service,
                      color: selesai ? Colors.green : Colors.blue,
                    ),
                  ),
                  title: Text(
                    item['nama'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${item['berat']} kg • ${rupiah(item['total'])}\n'
                    'Status: ${item['status']}',
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    tooltip: 'Ubah status',
                    icon: Icon(
                      selesai ? Icons.undo : Icons.check_circle_outline,
                    ),
                    onPressed: () => ubahStatus(index),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
