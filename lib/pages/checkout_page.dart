import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Color primaryGreen = const Color(0xFF0B6E4F);
  
  // State Management
  String _selectedPaymentMethod = 'Bank Transfer'; 
  String _selectedCountry = 'USA';
  bool _isCreditCardExpanded = false; 
  bool _isBankTransferExpanded = true; 
  bool _isSaveAddress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      // --- Tombol NEXT di Bawah ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
            onPressed: () {
              // Navigasi atau logika selanjutnya
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 20),
                const Text(
                  "NEXT", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                ),
              ],
            ),
          ),
        ),
      ),
      
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeader(context),
            const SizedBox(height: 30),
            _buildStepper(),
            const SizedBox(height: 30),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  // 1. SECTION CREDIT CARD
                  _buildCreditCardSection(),
                  
                  // 2. SECTION BANK TRANSFER (DENGAN FORM & DROPDOWN)
                  _buildBankTransferSection(),
                  
                  // 3. VIRTUAL ACCOUNT
                  _buildPaymentOption(
                    title: 'Virtual Account',
                    value: 'Virtual Account',
                    trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                    onTapOverride: () {
                      setState(() {
                        _selectedPaymentMethod = 'Virtual Account';
                        _isCreditCardExpanded = false;
                        _isBankTransferExpanded = false;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  const Divider(thickness: 1, color: Color(0xFFF2F2F2)),
                  const SizedBox(height: 20),

                  // TOTAL PEMBAYARAN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Total Payment", 
                        style: TextStyle(fontSize: 18, color: Colors.grey.shade500, fontWeight: FontWeight.w500)
                      ),
                      const Text(
                        "\$158.0", 
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildBankTransferSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPaymentOption(
          title: 'Bank Transfer',
          value: 'Bank Transfer',
          trailing: Icon(
            _isBankTransferExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, 
            color: Colors.grey.shade400
          ),
          onTapOverride: () {
            setState(() {
              _selectedPaymentMethod = 'Bank Transfer';
              _isBankTransferExpanded = !_isBankTransferExpanded;
              if (_isBankTransferExpanded) _isCreditCardExpanded = false;
            });
          },
        ),
        if (_isBankTransferExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFieldLabel("Card Holder Name"),
                _buildTextField("Samuel Witwicky"),
                const SizedBox(height: 20),
                
                _buildFieldLabel("Card Number"),
                _buildTextField("1234 5678 9101 1121"),
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel("Month/Year"),
                          _buildTextField("Enter here"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel("CVV"),
                          _buildTextField("Enter here"),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                _buildFieldLabel("Country"),
                _buildDropdownField(),
                const SizedBox(height: 25),
                
                Row(
                  children: [
                    SizedBox(
                      height: 24, width: 24,
                      child: Checkbox(
                        value: _isSaveAddress,
                        activeColor: primaryGreen,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (val) => setState(() => _isSaveAddress = val!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Save shipping address", 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCountry,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: primaryGreen),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCountry = newValue!;
            });
          },
          items: <String>['USA', 'China', 'India']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCreditCardSection() {
    return Column(
      children: [
        _buildPaymentOption(
          title: 'Credit Card',
          value: 'Credit Card',
          trailing: Icon(
            _isCreditCardExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, 
            color: Colors.grey.shade400
          ),
          onTapOverride: () {
            setState(() {
              _selectedPaymentMethod = 'Credit Card';
              _isCreditCardExpanded = !_isCreditCardExpanded;
              if (_isCreditCardExpanded) _isBankTransferExpanded = false;
            });
          },
        ),
        if (_isCreditCardExpanded)
          Container(
            height: 190,
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: PageView(
              controller: PageController(viewportFraction: 0.9),
              padEnds: false,
              children: [
                _buildCard(
                  color1: const Color(0xFF431181),
                  color2: const Color(0xFFE89BA8),
                  name: "KEVIN HARD",
                ),
                _buildCard(
                  color1: const Color(0xFF2C2C2C),
                  color2: const Color(0xFF5A5A5A),
                  name: "KEVIN HARD",
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCard({required Color color1, required Color color2, required String name}) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [color1, color2], 
          begin: Alignment.bottomLeft, 
          end: Alignment.topRight
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Credit Card", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              Icon(Icons.circle, color: Colors.white.withOpacity(0.3), size: 30),
            ],
          ),
          const Text("1234 **** **** ****", style: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 2)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("04 / 25", style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text(name, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title, 
    required String value, 
    required Widget trailing, 
    VoidCallback? onTapOverride
  }) {
    bool isSelected = _selectedPaymentMethod == value;
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onTapOverride ?? () => setState(() => _selectedPaymentMethod = value),
        leading: Container(
          height: 24, width: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? primaryGreen : Colors.grey.shade400, 
              width: isSelected ? 7 : 2
            ),
          ),
        ),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: trailing,
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(label, style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryGreen)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 50, width: 50,
              decoration: const BoxDecoration(color: Color(0xFFF2F2F2), shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          const Text("Checkout", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Shipping A...", style: TextStyle(color: Colors.grey.shade400)),
            const Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Coupon A...", style: TextStyle(color: Colors.grey.shade400)),
          ],
        ),
        const SizedBox(height: 15),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 2, color: primaryGreen.withOpacity(0.2), margin: const EdgeInsets.symmetric(horizontal: 50)),
            Container(
              height: 20, width: 20,
              decoration: BoxDecoration(
                color: Colors.white, 
                shape: BoxShape.circle, 
                border: Border.all(color: primaryGreen, width: 4)
              ),
            ),
          ],
        ),
      ],
    );
  }
}