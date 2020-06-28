import 'dart:io' as io;


List mainOptions = [
  {
    "title": "Filters",
    "image":
        "https://r1.ilikewallpaper.net/iphone-wallpapers/download/82917/cyberpunk-2077-gameart-4k-iphone-wallpaper-ilikewallpaper_com.jpg",
    "options": ["Gallery", "Camera"]
  },
  {
    "title": "Wallpaper",
    "image":
        "https://r1.ilikewallpaper.net/iphone-wallpapers/download/82917/cyberpunk-2077-gameart-4k-iphone-wallpaper-ilikewallpaper_com.jpg",
    "options": ["Wallpapers"]
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
  'NEON Draw',
  'Sketch'
];

String saveFolderName = "CyberPunk_Killer";

io.Directory appDocDir = io.Directory('/storage/emulated/0/$saveFolderName');

