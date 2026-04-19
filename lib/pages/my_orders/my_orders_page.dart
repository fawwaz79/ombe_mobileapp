import 'package:flutter/material.dart';
import 'package:ombe/pages/order_detail_page.dart';
import 'package:ombe/pages/order_tracking_page.dart';
import 'package:ombe/pages/checkout_page.dart';


class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  int selectedFilterIndex = 0; 
  final List<String> filters = ["All", "On Delivery", "Done"];
  final Color primaryGreen = const Color(0xFF0B6E4F);

  String searchQuery = "";

  List<Map<String, dynamic>> _getCurrentTabData() {
    if (selectedFilterIndex == 0) {
      return [
        {'image': 'assets/lemon-tea.jpg', 'title': 'Sweet Lemon Indonesian Tea', 'price': 5.8, 'qty': 2},
        {'image': 'assets/latte.webp', 'title': 'Hot Cappuccino Latte with Mocha', 'price': 8.6, 'qty': 1},
        {'image': 'assets/arabica.jpeg', 'title': 'Arabica Latte Ombe Coffee', 'price': 5.8, 'qty': 2},
      ];
    } else if (selectedFilterIndex == 1) {
      return [
        {'image': 'assets/arabica.jpeg', 'title': 'Original Hot Coffee', 'price': 5.8, 'qty': 2},
        {'image': 'assets/lemon-tea.jpg', 'title': 'Hot Cappucino Latte with Mocha', 'price': 5.8, 'qty': 2},
        {'image': 'assets/latte.webp', 'title': 'Arabica Latte Ombe Coffee', 'price': 5.8, 'qty': 2},
      ];
    } else {
      return [
        {'image': 'assets/latte.webp', 'title': 'Sweet Lemon Indonesian Tea', 'price': 5.8, 'qty': 2},
        {'image': 'assets/arabica.jpeg', 'title': 'Original Hot Coffee', 'price': 5.8, 'qty': 2},
        {'image': 'assets/lemon-tea.jpg', 'title': 'Sweet Lemon Indonesian Tea', 'price': 5.8, 'qty': 2},
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentData = _getCurrentTabData();

    List<Map<String, dynamic>> filteredData = currentData.where((item) {
      final title = (item['title']?.toString() ?? "").toLowerCase();
      final searchLower = searchQuery.toLowerCase();
      return title.contains(searchLower);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          onPressed: () {
              // Navigasi menuju halaman Order Tracking yang baru dibuat
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CheckoutPage()),
              );
            },
            child: const Text(
              "PLACE ORDER",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              const SizedBox(height: 20),

              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const Text(
                    "Orders",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 50,
                    width: 50,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.more_vert),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ✅ SEARCH BAR (Teks mepet kiri, posisi tengah vertikal)
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center, // Tengah secara vertikal
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 12),
                    isCollapsed: true, 
                    hintText: "Search Order ID or Product",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none, 
                    suffixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ✅ FILTER CHIPS (Dimulai dari kiri)
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.center, // Meratakan tombol ke sisi kiri
                  spacing: 12, 
                  children: List.generate(filters.length, (index) {
                    bool isActive = selectedFilterIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilterIndex = index;
                          searchQuery = ""; 
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        decoration: BoxDecoration(
                          color: isActive ? primaryGreen : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: primaryGreen),
                        ),
                        child: Text(
                          filters[index],
                          style: TextStyle(
                            color: isActive ? Colors.white : primaryGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 28),

              // ✅ TAMPILAN JIKA KOSONG ATAU ADA DATA
              Expanded(
                child: filteredData.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Nothing found",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final item = filteredData[index];
                          
                          return OrderItem(
                            image: item['image']?.toString() ?? '',
                            title: item['title']?.toString() ?? 'Unknown',
                            price: (item['price'] as num?)?.toDouble() ?? 0.0,
                            qty: (item['qty'] as int?) ?? 1,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final int qty;

  const OrderItem({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.qty,
  });

  @override
  Widget build(BuildContext context) {
    final total = price * qty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OrderDetailPage()),
          );
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 90, height: 90, color: Colors.grey.shade200, child: const Icon(Icons.image),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$$price",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${qty}x",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "\$${total.toStringAsFixed(1)}", 
                        style: const TextStyle(
                          color: Color(0xFF0B6E4F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}