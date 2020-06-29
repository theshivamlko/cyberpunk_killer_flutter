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
  'NEON Pink',
  'NEON Purple',
  'NEON Glitch1',
  'NEON Glitch2',
  'NEON Glitch3',
  'NEON Glitch4',
  'NEON Glitch5',
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
