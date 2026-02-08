import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PublishProductView extends StatefulWidget {
  const PublishProductView({super.key});

  @override
  State<PublishProductView> createState() => _PublishProductViewState();
}

class _PublishProductViewState extends State<PublishProductView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();

  // State
  String? _selectedCategory;
  final List<String> _categories = [
    'Frenos',
    'Motor',
    'Suspensión',
    'Carrocería',
    'Llantas',
    'Interior',
    'Electrónica',
    'Fluidos'
  ];

  bool _isLoading = false;

  void _handlePublish() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() => _isLoading = false);

      // Show Success Message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            '¡Tu repuesto ha sido publicado y ya es visible en la tienda!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green[700],
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Return to Profile
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color kBackgroundColor = Color(0xFF121212);
    const Color kSurfaceColor = Color(0xFF1E1E1E);
    const Color kPrimaryRed = Color(0xFFEC7E94);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Text(
          "Publicar Repuesto",
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo Upload Area (Simulated)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kSurfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey[800]!,
                    width: 2,
                    style: BorderStyle
                        .solid, // Dotted simulation handled by content visual
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Simulación: Foto subida correctamente")));
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined,
                            size: 48, color: Colors.grey[600]),
                        const SizedBox(height: 12),
                        Text(
                          "Toca para subir foto del repuesto",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title
              _buildLabel("Título del Repuesto"),
              TextFormField(
                controller: _titleCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: _buildInputDecoration(
                    "Ej: Pastillas de Freno Brembo", kSurfaceColor),
                validator: (value) => value == null || value.isEmpty
                    ? 'Por favor ingresa un título'
                    : null,
              ),
              const SizedBox(height: 20),

              // Price & Category Row
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Precio"),
                        TextFormField(
                          controller: _priceCtrl,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration:
                              _buildInputDecoration("\$0.00", kSurfaceColor),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Requerido'
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Categoría"),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          dropdownColor: kSurfaceColor,
                          style: const TextStyle(color: Colors.white),
                          decoration: _buildInputDecoration(
                              "Seleccionar", kSurfaceColor),
                          items: _categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => _selectedCategory = val),
                          validator: (value) =>
                              value == null ? 'Requerido' : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Description
              _buildLabel("Descripción"),
              TextFormField(
                controller: _descCtrl,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
                decoration: _buildInputDecoration(
                    "Describe el estado, compatibilidad y detalles...",
                    kSurfaceColor),
                validator: (value) => value == null || value.isEmpty
                    ? 'Por favor añade una descripción'
                    : null,
              ),
              const SizedBox(height: 40),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _isLoading ? null : _handlePublish,
                  style: FilledButton.styleFrom(
                    backgroundColor: kPrimaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          "PUBLICAR AHORA",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, Color fillColor) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[600]),
      filled: true,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEC7E94), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
