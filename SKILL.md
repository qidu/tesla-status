---
name: tesla-status
alias:
  - my-testla
  - tesla-vehicle
  - my-car
description: "Query Tesla vehicle status and information via TeslaMate API. Get real-time battery level, charging status, location, climate control, and vehicle health. Requires a running TeslaMate API instance."
homepage: https://github.com/qidu/teslamateapi
metadata:
  {
    "openclaw":
      {
        "emoji": "🚗",
        "requires": { "bins": ["curl", "python3"] },
        "install":
          [
            {
              "id": "pip-requests",
              "kind": "pip",
              "packages": ["requests"],
              "label": "Install Python requests module",
            },
          ],
      },
  }
---

# Tesla Status Skill

Query Tesla vehicle status and information via TeslaMate API.

## When to Use

✅ **USE this skill when:**

- User asks "Tesla status" or "check my Tesla"
- Want to know battery level, range, or charging status
- Need vehicle location or recent trips
- Checking if vehicle is locked/climate is on
- Monitoring battery health and vehicle efficiency

## When NOT to Use

❌ **DON'T use this skill when:**

- Direct Tesla API access is needed (use Tesla's official API)
- Vehicle commands beyond wake-up (use Tesla app or other tools)
- Historical data analysis beyond recent drives
- Real-time vehicle control (unlocking, starting climate, etc.)

## Prerequisites

- **TeslaMate** - Self-hosted data logger ([GitHub](https://github.com/teslamate-org/teslamate))
- **TeslaMate API** - REST API for TeslaMate ([GitHub](https://github.com/qidu/teslamateapi))
- **Python 3** with `requests` module installed

## Quick Start

1. **Install Python requests module:**
   ```bash
   pip install requests
   ```

2. **Ensure TeslaMate API is running:**
   ```bash
   curl http://localhost:8686/api/v1/cars
   ```

3. **Check your Tesla status:**
   ```bash
   ~/.openclaw/skills/tesla-status/tesla-status.sh status
   ```

## Commands

### Get All Cars
```bash
tesla cars
```
Lists all Tesla vehicles registered in TeslaMate with basic details.

### Get Car Status
```bash
tesla status [car_id]
```
Gets detailed status including battery, charging, climate, location, and security status. Defaults to car ID 1.

### Get Battery Health
```bash
tesla battery [car_id]
```
Gets detailed battery health metrics including degradation percentage, max range, and capacity.

### Get Current Charge
```bash
tesla charge [car_id]
```
Gets current charging session information (if vehicle is charging).

### Get Vehicle Details
```bash
tesla details [car_id]
```
Gets vehicle specifications including model, trim, VIN, color, and wheel type.

### Wake Vehicle
```bash
tesla wake [car_id]
```
Sends a wake-up command to bring the vehicle online (requires `TESLAMATE_API_TOKEN`).

## Examples

### Basic Status Check
```bash
tesla status
```
Output:
```
Vehicle: Motor AAT
State: offline
Battery Level: 77%
Estimated Range: 370.04 km
Locked: True
Location: 39.95679, 116.302934
```

### List All Vehicles
```bash
tesla cars
```
Output:
```
Found 1 cars:
  Car ID: 1
  Name: "Motor AAT"
  Model: Y
  VIN: LRWYGCEK5PC179877
```

### Battery Health Check
```bash
tesla battery
```
Output (JSON):
```json
{
  "battery_health": {
    "max_range": 498.87,
    "current_range": 494.82,
    "battery_health_percentage": 99.14
  }
}
```

## Configuration

### API Host
By default, the skill connects to `http://localhost:8686`. To change:
```bash
export TESLAMATE_API_HOST="http://localhost:8080"
```

### API Token (for wake commands)
```bash
export TESLAMATE_API_TOKEN="your-api-token-here"
```

### Car ID
Default is car ID 1. Specify different car:
```bash
tesla status 2
```

## API Endpoints Used

| Endpoint | Description |
|----------|-------------|
| `GET /api/v1/cars` | List all vehicles |
| `GET /api/v1/cars/:CarID/status` | Detailed vehicle status |
| `GET /api/v1/cars/:CarID/battery-health` | Battery health metrics |
| `GET /api/v1/cars/:CarID/charges/current` | Current charging session |
| `POST /api/v1/cars/:CarID/wake_up` | Wake vehicle command |

## Troubleshooting

### "No cars found"
- Check TeslaMate API is running: `curl http://localhost:8686/api/healthz`
- Verify TeslaMate is collecting data from your vehicle

### "Vehicle is offline"
- This is normal when vehicle is parked/asleep
- Use `tesla wake` to bring it online (requires token)

### "Python requests module missing"
- Install: `pip install requests` or `pip3 install requests`

### "API token required"
- Set `TESLAMATE_API_TOKEN` environment variable
- Token must be configured in TeslaMate API

## Notes

- **Real-time data:** Vehicle must be online/awake for fresh data
- **Cached data:** Shows last known state when vehicle is asleep
- **Location accuracy:** May show last known location when offline
- **Battery health:** Calculated from TeslaMate historical data
- **Security:** API token required for wake commands only

## Related Skills

- **apple-reminders** - For scheduling Tesla-related reminders
- **cron** - For automated regular status checks
- **weather** - Check weather at vehicle location
