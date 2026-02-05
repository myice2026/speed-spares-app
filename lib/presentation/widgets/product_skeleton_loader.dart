import 'package:flutter/material.dart';

class ProductSkeletonLoader extends StatefulWidget {
  final int itemCount;

  const ProductSkeletonLoader({
    Key? key,
    this.itemCount = 6,
  }) : super(key: key);

  @override
  State<ProductSkeletonLoader> createState() => _ProductSkeletonLoaderState();
}

class _ProductSkeletonLoaderState extends State<ProductSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _ShimmerBox(
                    width: 50,
                    height: 50,
                    animation: _animationController,
                    borderRadius: 8,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(
                          width: 150,
                          height: 16,
                          animation: _animationController,
                          borderRadius: 4,
                        ),
                        const SizedBox(height: 8),
                        _ShimmerBox(
                          width: 200,
                          height: 12,
                          animation: _animationController,
                          borderRadius: 4,
                        ),
                        const SizedBox(height: 8),
                        _ShimmerBox(
                          width: 80,
                          height: 14,
                          animation: _animationController,
                          borderRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  _ShimmerBox(
                    width: 20,
                    height: 20,
                    animation: _animationController,
                    borderRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final AnimationController animation;
  final double borderRadius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.animation,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.6, end: 1).animate(animation),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
