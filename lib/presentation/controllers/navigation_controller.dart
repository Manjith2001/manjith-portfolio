import 'package:flutter/material.dart';

import '../../models/project_model.dart';

class NavigationController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final GlobalKey heroKey = GlobalKey();
  final GlobalKey clientsKey = GlobalKey();
  final GlobalKey appsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey capabilitiesKey = GlobalKey();
  final GlobalKey shorebirdKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  String _activeSection = 'hero';
  String get activeSection => _activeSection;

  bool _isScrolled = false;
  bool get isScrolled => _isScrolled;

  ProjectModel? _selectedProject;
  ProjectModel? get selectedProject => _selectedProject;

  int _selectedScreenshotIndex = 0;
  int get selectedScreenshotIndex => _selectedScreenshotIndex;

  bool _isLightboxOpen = false;
  bool get isLightboxOpen => _isLightboxOpen;

  NavigationController() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = scrollController.offset;
    final scrolled = offset > 50;
    if (scrolled != _isScrolled) {
      _isScrolled = scrolled;
      notifyListeners();
    }
  }

  void scrollToSection(GlobalKey key, {String? sectionName}) {
    if (sectionName != null) {
      _activeSection = sectionName;
      notifyListeners();
    }

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  void openProjectDetail(ProjectModel project) {
    _selectedProject = project;
    _selectedScreenshotIndex = 0;
    notifyListeners();
  }

  void closeProjectDetail() {
    _selectedProject = null;
    _isLightboxOpen = false;
    notifyListeners();
  }

  void openLightbox(int index) {
    _selectedScreenshotIndex = index;
    _isLightboxOpen = true;
    notifyListeners();
  }

  void closeLightbox() {
    _isLightboxOpen = false;
    notifyListeners();
  }

  void nextScreenshot() {
    if (_selectedProject != null && _selectedProject!.screenshots.isNotEmpty) {
      _selectedScreenshotIndex =
          (_selectedScreenshotIndex + 1) % _selectedProject!.screenshots.length;
      notifyListeners();
    }
  }

  void previousScreenshot() {
    if (_selectedProject != null && _selectedProject!.screenshots.isNotEmpty) {
      _selectedScreenshotIndex =
          (_selectedScreenshotIndex -
              1 +
              _selectedProject!.screenshots.length) %
          _selectedProject!.screenshots.length;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }
}
