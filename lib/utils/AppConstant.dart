import 'dart:io' as io;

List mainOptions = [
  {
    "title": "Image Filters",
    "image":
        "https://navoki.com/samples/cyberpunk-killer/images/filters-min.jpg",
  },
  {
    "title": "Wallpapers",
    "image":
        "https://navoki.com/samples/cyberpunk-killer/images/wallpapers-min.jpg",
  },
];

List filterCategory = [
  'Pink',
  'Yellow',
  'Green',
  'Sketch_Black',
  'Sketch_Green',
  'Sketch_Pink',
  'NEON_Glitch1',
  'NEON_Glitch2',
  'NEON_Glitch3',
  'NEON_Glitch4',
  'NEON_Glitch5',
  'Background1',
  'Background2',
  'Background3',
  'Overlay1',
  'Overlay2',
  'Overlay3',
  'Overlay4',
  'Overlay5'
];

String saveFolderName = "CyberPunk_Killer";

io.Directory appDocDir = io.Directory('/storage/emulated/0/$saveFolderName');
