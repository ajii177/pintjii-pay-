
import 'package:flutter/material.dart';

void main() => runApp(const PintjiPay());

const blue = Color(0xFF1769FF);
const pale = Color(0xFFF2F6FF);

class PintjiPay extends StatelessWidget {
  const PintjiPay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PINTJI PAY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        scaffoldBackgroundColor: pale,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  final List<Map<String, dynamic>> transactions = [
    {'title': 'Top up demo', 'amount': '+Rp100.000'},
    {'title': 'Pembayaran demo', 'amount': '-Rp50.000'},
  ];

  final List<String> activityItems = [
    'Top up saldo',
    'Transfer sesama pengguna',
    'Transfer bank',
    'Tarik saldo',
    'Minta uang',
    'Riwayat transaksi',
  ];

  final List<String> investmentItems = [
    'Reksa dana pasar uang',
    'Reksa dana pendapatan tetap',
    'Reksa dana saham',
    'Simulasi keuntungan',
    'Kalkulator investasi',
    'Profil risiko',
    'Portofolio demo',
    'Edukasi investasi',
  ];

  final List<String> accountItems = [
    'Profil pengguna',
    'Keamanan dan PIN',
    'Pengaturan notifikasi',
    'Pusat bantuan',
    'Tentang PINTJI PAY',
  ];

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      dashboard(),
      menuPage('Aktivitas', activityItems),
      menuPage('Investasi', investmentItems),
      menuPage('Akun', accountItems),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'PINTJI PAY',
          style: TextStyle(
            color: blue,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => message('Belum ada notifikasi'),
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) {
          setState(() => tab = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long),
            label: 'Aktivitas',
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up),
            label: 'Investasi',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  Widget dashboard() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [blue, Color(0xFF58A0FF)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL SALDO DEMO',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 8),
              Text(
                'Rp1.250.000',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 18),
              Text(
                'PINTJI PAY WALLET',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Layanan utama',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.85,
          children: [
            service(Icons.add_card, 'Top up'),
            service(Icons.send, 'Transfer'),
            service(Icons.account_balance, 'Bank'),
            service(Icons.qr_code, 'QRIS'),
            service(Icons.phone_android, 'Pulsa & data'),
            service(Icons.bolt, 'Tagihan'),
            service(Icons.water_drop, 'PDAM'),
            service(Icons.health_and_safety, 'BPJS'),
            service(Icons.sports_esports, 'Voucher game'),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'Ringkasan keuangan demo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        summaryRow(Icons.arrow_downward, 'Uang masuk', 'Rp500.000'),
        summaryRow(Icons.arrow_upward, 'Uang keluar', 'Rp150.000'),
        const SizedBox(height: 18),
        const Text(
          'Transaksi terbaru',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        for (final item in transactions)
          Card(
            color: Colors.white,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: pale,
                child: Icon(Icons.receipt_long, color: blue),
              ),
              title: Text(item['title'] as String),
              trailing: Text(item['amount'] as String),
            ),
          ),
        const SizedBox(height: 12),
        const Text(
          'Mode demo: saldo dan transaksi bukan uang sungguhan.',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  Widget service(IconData icon, String label) {
    return InkWell(
      onTap: () => message('$label masih dalam mode demo'),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: blue, size: 27),
          ),
          const SizedBox(height: 7),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget summaryRow(IconData icon, String title, String amount) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: blue),
        title: Text(title),
        trailing: Text(
          amount,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget menuPage(String title, List<String> items) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        for (final item in items)
          Card(
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.circle_outlined, color: blue),
              title: Text(item),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => message('$item masih dalam mode demo'),
            ),
          ),
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Fitur simulasi. Integrasi layanan memerlukan backend '
            'dan penyedia resmi.',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
