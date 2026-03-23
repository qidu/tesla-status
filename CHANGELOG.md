# Changelog

## v1.0.0 (2026-03-23)

### Added
- Initial release of Tesla Status Skill
- Python script (`tesla_status.py`) with full functionality
- Shell wrapper (`tesla-status.sh`) for quick commands
- Test script (`test_skill.sh`) for verification
- Complete documentation (`SKILL.md`, `README.md`)
- Example usage scenarios (`example_usage.md`)
- Package metadata (`package.json`)
- MIT License (`LICENSE`)

### Features
- Get vehicle status (battery, charging, climate, location)
- List all Tesla vehicles registered in TeslaMate
- Check battery health with degradation percentage
- Get current charging session information
- View vehicle details (model, trim, VIN, specifications)
- Wake vehicle command (requires API token)
- Support for multiple vehicles via car ID parameter
- Environment variable configuration

### Requirements
- TeslaMate API running locally (default port 8686)
- Python 3 with `requests` module
- curl for shell wrapper alternative