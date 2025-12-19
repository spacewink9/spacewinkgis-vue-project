# SpacewinkGIS Local Data Directory

This directory contains local data assets for SpacewinkGIS.

## Structure:
- `/terrain` - Terrain data (elevation)
- `/tile` - Tile map data
- `/file/geojson` - GeoJSON vector data
- `/file/kml` - KML/KMZ data
- `/file/czml` - CZML animation data
- `/3dtiles` - 3D Tiles models
- `/gltf` - GLTF/GLB 3D models
- `/img` - Image assets

## Usage:
Place your data files in the appropriate directories.
The config.json file is configured to use these local paths.

All data should be relative to this directory and accessible
via the /data URL path.
