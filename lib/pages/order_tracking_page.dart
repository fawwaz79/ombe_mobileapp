import 'package:flutter/material.dart';
import 'package:ombe/pages/order_detail_page.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  final Color primaryGreen = const Color(0xFF0B6E4F);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      
      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black87),
          ),
        ),
        title: const Text(
          "Order Details",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black87),
          ),
        ],
      ),

      body: Stack(
        children: [
          // 1. GAMBAR PETA STATIS DI ATAS
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.40, 
            child: Image.asset(
              'assets/maps.png', 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.blueGrey.shade100,
                child: const Center(
                  child: Text("Gambar peta belum ada", style: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
          ),

          // 2. WHITE SHEET YANG BISA DI-SCROLL NAIK
          DraggableScrollableSheet(
            initialChildSize: 0.65, 
            minChildSize: 0.65,     
            maxChildSize: 0.95,     
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    )
                  ]
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      // --- DRAG HANDLE ---
                      const SizedBox(height: 12),
                      Container(
                        height: 5,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // --- INFO KURIR ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage('assets/kurir.webp'),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Courir",
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "Hawkins Ochouv",
                                    style: TextStyle(
                                      fontSize: 18, 
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade200),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              ),
                              child: Icon(Icons.phone, color: primaryGreen),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // --- INFO LOKASI & STATUS ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on, color: primaryGreen, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Corner St.",
                                    style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                                  ),
                                  Text(
                                    "Franklin Avenue 23574",
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: primaryGreen,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "On Delivery",
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Divider(thickness: 1, height: 1),
                      const SizedBox(height: 20),

                      // --- HEADER LIST ITEM ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "5 Items",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down_outlined, color: primaryGreen, size: 28),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // --- 5 LIST ITEM PESANAN ---
                      ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildTrackingItem(
                            context,
                            image: 'assets/lemon-tea.jpg',
                            title: 'Sweet Lemon Indonesian Tea',
                            price: '\$8.6',
                            qty: '1x',
                            total: '\$8.6',
                          ),
                          _buildTrackingItem(
                            context,
                            image: 'assets/latte.webp',
                            title: 'Hot Cappuccino Latte with Mocha',
                            price: '\$5.8',
                            qty: '2x',
                            total: '\$11.6',
                          ),
                          _buildTrackingItem(
                            context,
                            image: 'assets/arabica.jpeg',
                            title: 'Arabica Latte Ombe Coffee',
                            price: '\$5.8',
                            qty: '2x',
                            total: '\$11.6',
                          ),
                          _buildTrackingItem(
                            context,
                            image: 'assets/arabica.jpeg',
                            title: 'Original Hot Coffee',
                            price: '\$5.8',
                            qty: '2x',
                            total: '\$11.6',
                          ),
                          _buildTrackingItem(
                            context,
                            image: 'assets/latte.webp',
                            title: 'Hot Cappuccino Latte with Mocha',
                            price: '\$8.6',
                            qty: '1x',
                            total: '\$8.6',
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 40), 
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ✅ FUNGSI HELPER YANG BENAR
  Widget _buildTrackingItem(
    BuildContext context, {
    required String image,
    required String title,
    required String price,
    required String qty,
    required String total,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80, height: 80, color: Colors.grey.shade200, child: const Icon(Icons.image),
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
                        price,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        qty,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        total,
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