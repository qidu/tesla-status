# Tesla Status Skill for OpenClaw 🚗

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![OpenClaw Skill](https://img.shields.io/badge/OpenClaw-Skill-green.svg)](https://clawhub.ai)
[![Python 3.7+](https://img.shields.io/badge/Python-3.7+-blue.svg)](https://python.org)
[![TeslaMate API](https://img.shields.io/badge/TeslaMate-API-orange.svg)](https://github.com/qidu/teslamateapi)

A skill for checking Tesla vehicle status through TeslaMate API.

## Features

- **Real-time vehicle status** (battery, charging, climate, location)
- **Battery health monitoring** with degradation percentage
- **Recent trip history** with locations and distances
- **Vehicle details** (model, trim, VIN, color, specifications)
- **Wake vehicle command** (requires API token)

## Installation

### Prerequisites

1. **TeslaMate** - Self-hosted Tesla data logger
   ```bash
   # See: https://github.com/teslamate-org/teslamate
   ```

2. **TeslaMate API** - REST API for TeslaMate
   ```bash
   # See: https://github.com/qidu/teslamateapi
   ```

3. **Python dependencies**
   ```bash
   pip install requests
   ```

### Skill Installation

Clone or copy the skill files to your OpenClaw skills directory:

```bash
# Copy to your skills directory
cp -r tesla-status ~/.openclaw/skills/
```

## Usage

### Basic Commands

```bash
# Check vehicle status
tesla-status.sh status

# List all vehicles
tesla-status.sh cars

# Check battery health
tesla-status.sh battery

# Get vehicle details
tesla-status.sh details
```

### Python Script Usage

```bash
# Using the Python script
python3 tesla_status.py status
python3 tesla_status.py cars
python3 tesla_status.py battery
```

### Environment Variables

```bash
# Custom API host (default: http://localhost:8686)
export TESLAMATE_API_HOST="http://localhost:8080"

# API token for wake commands
export TESLAMATE_API_TOKEN="your-token-here"
```

## Files

- `SKILL.md` - Skill documentation with frontmatter
- `tesla_status.py` - Main Python script
- `tesla-status.sh` - Shell wrapper for quick commands
- `test_skill.sh` - Test script to verify functionality
- `example_usage.md` - Advanced usage examples

## Examples

### Example Output

```bash
$ tesla-status.sh status
Vehicle: Motor AAT
State: offline
Battery Level: 77%
Estimated Range: 370.04 km
Locked: True
Location: 39.95679, 116.302934
```

### Integration with OpenClaw

```bash
# From OpenClaw agent
~/.openclaw/skills/tesla-status/tesla-status.sh status

# Create alias
alias tesla='~/.openclaw/skills/tesla-status/tesla-status.sh'
tesla status
```

## Publishing to clawhub.ai

This skill meets all requirements for publishing to clawhub.ai:

### ✅ Skill Structure Requirements
- **YAML Frontmatter** - Includes `name`, `description`, `homepage`, `metadata`
- **Metadata** - Includes `emoji`, `requires`, `install` instructions
- **Clear Usage Guidelines** - "When to Use" and "When NOT to Use"
- **Examples** - Practical examples with expected output
- **Troubleshooting** - Common issues and solutions
- **Related Skills** - Mentions other relevant skills
- **API Documentation** - Lists endpoints used
- **Configuration Options** - Environment variables explained

### ✅ Technical Requirements
- **No `manifest.json` required** - Skills are defined by SKILL.md frontmatter
- **`.clawhub/origin.json`** - Added for registry tracking
- **Complete package.json** - Includes OpenClaw-specific metadata
- **Tested implementation** - Verified working with TeslaMate API
- **MIT License** - Open source licensing

### ✅ Publishing Checklist
1. **GitHub Repository** - Create public repository with all files
2. **clawhub.ai Submission** - Submit skill to registry
3. **Version Tagging** - Use semantic versioning (v1.0.0)
4. **Documentation** - Ensure README and SKILL.md are complete

## License

MIT License - See included files for details.

## Contributing

Feel free to submit issues or improvements via GitHub.

## Links

- **TeslaMate**: https://github.com/teslamate-org/teslamate
- **TeslaMate API**: https://github.com/qidu/teslamateapi
- **OpenClaw**: https://github.com/openclaw/openclaw
- **ClawHub**: https://clawhub.com
