import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/widgets/glass_container.dart';
import 'package:flutter_image_converters/models/image_data.dart';
import 'package:flutter_image_converters/views/resize/widgets/info_row.dart';

class ResetImageInfo extends StatelessWidget {
  const ResetImageInfo({super.key, required this.imageData});

  final ImageData imageData;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(label: 'Name', value: imageData.name ?? 'Unknown'),
          InfoRow(label: 'Dimensions', value: imageData.dimensionsDisplay),
          InfoRow(
            label: 'Format',
            value: imageData.format?.toUpperCase() ?? 'Unknown',
          ),
          InfoRow(label: 'Size', value: imageData.sizeDisplay),
        ],
      ),
    );
  }
}
