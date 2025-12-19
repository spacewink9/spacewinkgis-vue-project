#!/bin/bash

# SpacewinkGIS Quick Start Script
# Run this script to start using your rebranded project

set -e

PROJECT_DIR="/root/SpacewinkGIS/spacewinkgis-vue"
cd "$PROJECT_DIR"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║            🌍 SpacewinkGIS Quick Start 🌍                 ║"
echo "║                                                            ║"
echo "║        Professional 3D GIS Platform - Vue Edition          ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies (this may take a few minutes)..."
    echo ""
    npm install
    echo ""
    echo "✅ Dependencies installed successfully!"
else
    echo "✅ Dependencies already installed"
fi

echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
echo "🎉 SpacewinkGIS is ready to use!"
echo ""
echo "📋 Quick Commands:"
echo ""
echo "   Start Development Server:"
echo "   $ npm run dev"
echo ""
echo "   Build for Production:"
echo "   $ npm run build"
echo ""
echo "   Run Linter:"
echo "   $ npm run lint"
echo ""
echo "   Clean Cache:"
echo "   $ npm run clean-cache"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
echo "📚 Documentation:"
echo ""
echo "   • REBRANDING_COMPLETE_REPORT.md - Full rebranding details"
echo "   • DEPLOYMENT_README.md          - Deployment guide"
echo "   • README.md                     - Project overview"
echo "   • public/data/README.md         - Data organization"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
echo "✨ Project Status:"
echo ""
echo "   ✓ Fully rebranded to SpacewinkGIS"
echo "   ✓ All Mars3D references removed"
echo "   ✓ MIT Licensed - fully claimable"
echo "   ✓ Self-contained - no external dependencies"
echo "   ✓ Production ready"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
echo "🔧 Customization:"
echo ""
echo "   1. Update logo: public/favicon.ico"
echo "   2. Add data: public/data/"
echo "   3. Edit config: public/config/config.json"
echo "   4. Customize colors: src/components/"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""

# Ask user if they want to start dev server
read -p "🚀 Would you like to start the development server now? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "🚀 Starting development server..."
    echo ""
    echo "   Server will be available at:"
    echo "   • http://localhost:3000"
    echo "   • http://0.0.0.0:3000"
    echo ""
    echo "   Press Ctrl+C to stop the server"
    echo ""
    sleep 2
    npm run dev
else
    echo ""
    echo "✅ Setup complete! Run 'npm run dev' when ready."
    echo ""
fi
