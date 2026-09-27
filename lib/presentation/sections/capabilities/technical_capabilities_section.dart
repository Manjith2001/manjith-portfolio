import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/capabilities_data.dart';
import '../../../models/experience_model.dart';
import '../../widgets/section_header.dart';

class TechnicalCapabilitiesSection extends StatelessWidget {
  const TechnicalCapabilitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            tag: 'Engineering System',
            title: 'Technical Depth & Architecture',
            subtitle:
                'Delivering end-to-end commercial solutions: from robust Clean Architecture and '
                '9+ international payment gateways to native device features, mathematical calculation engines, and OTA pipelines.',
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad),
          const SizedBox(height: 64),
          
          LayoutBuilder(
            builder: (context, constraints) {
              if (width >= 1024) {
                return _buildDesktopLayout();
              } else {
                return _buildMobileTabletLayout();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    final caps = CapabilitiesData.capabilities;
    return Column(
      children: [
        // First 2: Wide Tablets
        Row(
          children: [
            Expanded(child: _CapabilitySurface(capability: caps[0], type: _SurfaceType.tablet)),
            const SizedBox(width: 24),
            Expanded(child: _CapabilitySurface(capability: caps[1], type: _SurfaceType.tablet)),
          ],
        ).animate().fadeIn().slideY(begin: 0.1),
        const SizedBox(height: 24),
        // Next 2: Medium Pods
        Row(
          children: [
            Expanded(child: _CapabilitySurface(capability: caps[2], type: _SurfaceType.pod)),
            const SizedBox(width: 24),
            Expanded(child: _CapabilitySurface(capability: caps[3], type: _SurfaceType.pod)),
          ],
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
        const SizedBox(height: 24),
        // Last 2: Compact Pills
        Row(
          children: [
            Expanded(child: _CapabilitySurface(capability: caps[4], type: _SurfaceType.pill)),
            const SizedBox(width: 24),
            Expanded(child: _CapabilitySurface(capability: caps[5], type: _SurfaceType.pill)),
          ],
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
      ],
    );
  }

  Widget _buildMobileTabletLayout() {
    return Column(
      children: CapabilitiesData.capabilities.map((cap) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _CapabilitySurface(capability: cap, type: _SurfaceType.tablet),
        );
      }).toList(),
    );
  }
}

enum _SurfaceType { tablet, pod, pill }

class _CapabilitySurface extends StatefulWidget {
  final CapabilityModel capability;
  final _SurfaceType type;

  const _CapabilitySurface({required this.capability, required this.type});

  @override
  State<_CapabilitySurface> createState() => _CapabilitySurfaceState();
}

class _CapabilitySurfaceState extends State<_CapabilitySurface> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    double borderRadius = widget.type == _SurfaceType.tablet ? 24 : (widget.type == _SurfaceType.pod ? 20 : 16);
    EdgeInsets padding = widget.type == _SurfaceType.tablet ? const EdgeInsets.all(40) : const EdgeInsets.all(24);
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered ? Matrix4.translationValues(0, -4, 0) : Matrix4.identity(),
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: _isHovered ? widget.capability.accentColor.withOpacity(0.5) : AppColors.border,
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: widget.capability.accentColor.withOpacity(0.15), blurRadius: 32, offset: const Offset(0, 16))]
              : [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 16, offset: const Offset(0, 8))],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surface,
              widget.capability.accentColor.withOpacity(0.05),
            ],
          ),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.type == _SurfaceType.tablet) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(),
          const SizedBox(width: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildDescription(),
                const SizedBox(height: 24),
                _buildTags(),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(),
          const SizedBox(height: 24),
          _buildHeader(),
          const SizedBox(height: 16),
          _buildDescription(),
          const SizedBox(height: 24),
          _buildTags(),
        ],
      );
    }
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.capability.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.capability.accentColor.withOpacity(0.2)),
      ),
      child: Icon(widget.capability.icon, color: widget.capability.accentColor, size: 32),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.capability.subtitle.toUpperCase(),
          style: AppTypography.mono(size: 11, color: widget.capability.accentColor, weight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          widget.capability.title,
          style: AppTypography.h3(size: 22, weight: FontWeight.w700, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.capability.description,
      style: AppTypography.body(size: 14, color: AppColors.textSecondary),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.capability.tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: widget.capability.accentColor.withOpacity(0.3)),
          ),
          child: Text(
            tag,
            style: AppTypography.mono(size: 11, color: AppColors.textPrimary),
          ),
        );
      }).toList(),
    );
  }
}
