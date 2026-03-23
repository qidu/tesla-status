#!/bin/bash
# Package Tesla Status Skill for distribution

set -e

SKILL_NAME="tesla-status"
VERSION="1.0.0"
PACKAGE_DIR="${SKILL_NAME}-${VERSION}"
ZIP_FILE="${SKILL_NAME}-${VERSION}.zip"

echo "📦 Packaging Tesla Status Skill v${VERSION}..."

# Create package directory
mkdir -p "${PACKAGE_DIR}"

# Copy essential files
cp SKILL.md "${PACKAGE_DIR}/"
cp README.md "${PACKAGE_DIR}/"
cp tesla_status.py "${PACKAGE_DIR}/"
cp tesla-status.sh "${PACKAGE_DIR}/"
cp test_skill.sh "${PACKAGE_DIR}/"
cp example_usage.md "${PACKAGE_DIR}/"
cp package.json "${PACKAGE_DIR}/"
cp LICENSE "${PACKAGE_DIR}/"
cp CHANGELOG.md "${PACKAGE_DIR}/"
cp requirements.txt "${PACKAGE_DIR}/"
cp .gitignore "${PACKAGE_DIR}/"
cp PUBLISHING_CHECKLIST.md "${PACKAGE_DIR}/"

# Make scripts executable
chmod +x "${PACKAGE_DIR}/tesla_status.py"
chmod +x "${PACKAGE_DIR}/tesla-status.sh"
chmod +x "${PACKAGE_DIR}/test_skill.sh"

# Create zip file
echo "📁 Creating ${ZIP_FILE}..."
zip -r "${ZIP_FILE}" "${PACKAGE_DIR}"

# Create tarball
echo "📦 Creating ${PACKAGE_DIR}.tar.gz..."
tar -czf "${PACKAGE_DIR}.tar.gz" "${PACKAGE_DIR}"

# Clean up
rm -rf "${PACKAGE_DIR}"

echo ""
echo "✅ Packaging complete!"
echo ""
echo "📁 Package files created:"
echo "   - ${ZIP_FILE}"
echo "   - ${PACKAGE_DIR}.tar.gz"
echo ""
echo "📋 Files included in package:"
echo "   - SKILL.md (main documentation)"
echo "   - README.md (user guide)"
echo "   - tesla_status.py (main Python script)"
echo "   - tesla-status.sh (shell wrapper)"
echo "   - test_skill.sh (test script)"
echo "   - example_usage.md (usage examples)"
echo "   - package.json (metadata)"
echo "   - LICENSE (MIT License)"
echo "   - CHANGELOG.md (version history)"
echo "   - requirements.txt (Python deps)"
echo "   - .gitignore (git rules)"
echo "   - PUBLISHING_CHECKLIST.md (this file)"
echo ""
echo "🚀 Ready for distribution!"
echo ""
echo "To publish on clawhub.ai:"
echo "1. Create GitHub repository"
echo "2. Push these files to GitHub"
echo "3. Submit to clawhub.ai"
echo "4. Share with OpenClaw community!"