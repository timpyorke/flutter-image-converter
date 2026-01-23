import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/const/app_dimensions.dart';
import 'package:flutter_image_converters/core/widgets/glass_container.dart';
import 'package:flutter_image_converters/presentation/models/image_data.dart';
import 'package:flutter_image_converters/presentation/views/resize/widgets/info_row.dart';

class ResetImageInfo extends StatelessWidget {
  const ResetImageInfo({super.key, required this.imageData});

  final ImageData? imageData;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      borderRadius: AppDimensions.radiusL,
      child: Column(
        spacing: AppDimensions.spacingS,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(label: 'Name', value: imageData?.name ?? ''),
          InfoRow(
            label: 'Dimensions',
            value: imageData?.dimensionsDisplay ?? '',
          ),
          InfoRow(
            label: 'Format',
            value: imageData?.format?.toUpperCase() ?? '',
          ),
          InfoRow(label: 'Size', value: imageData?.sizeDisplay ?? ''),
        ],
      ),
    );
  }
}
