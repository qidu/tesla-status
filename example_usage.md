# Tesla Status Skill - Usage Examples

## From OpenClaw

You can use this skill directly from OpenClaw by calling the scripts:

```bash
# Check if TeslaMate API is running
curl -s localhost:8686/api/v1/cars | jq

# List all Tesla vehicles
~/.openclaw/skills/tesla-status/tesla-status.sh cars

# Get vehicle status
~/.openclaw/skills/tesla-status/tesla-status.sh status

# Get battery health
~/.openclaw/skills/tesla-status/tesla-status.sh battery

# Get vehicle details
~/.openclaw/skills/tesla-status/tesla-status.sh details
```

## Python Script Examples

```python
#!/usr/bin/env python3
import sys
sys.path.insert(0, '/Users/chris/.openclaw/skills/tesla-status')

from tesla_status import get_cars, get_car_status, format_status

# Get all cars
cars = get_cars()
if cars:
    print(f"Found {len(cars)} cars")
    for car in cars:
        print(f"  - {car.get('name')} (ID: {car.get('car_id')})")

# Get status for car 1
status = get_car_status(1)
if status:
    print("\nCurrent Status:")
    print(format_status(status))
```

## Integration with Other Skills

You can combine this skill with other OpenClaw skills:

1. **Weather Skill** - Check weather at vehicle location
2. **Cron Skill** - Schedule regular status checks
3. **Message Skill** - Send status updates via WhatsApp/Telegram

## Sample Cron Job

Set up a daily status check at 8 AM:

```bash
# In OpenClaw cron
{
  "name": "Morning Tesla Status",
  "schedule": {
    "kind": "cron",
    "expr": "0 8 * * *",
    "tz": "Asia/Shanghai"
  },
  "payload": {
    "kind": "agentTurn",
    "message": "Check Tesla status and send me a summary"
  },
  "sessionTarget": "isolated",
  "delivery": {
    "mode": "announce",
    "channel": "whatsapp"
  }
}
```

## Alert Examples

Create alerts for specific conditions:

```bash
# Check if battery is low (<20%)
BATTERY_LEVEL=$(~/.openclaw/skills/tesla-status/tesla-status.sh status | grep "Battery Level" | cut -d: -f2 | tr -d '% ')
if [ "$BATTERY_LEVEL" -lt 20 ]; then
    echo "⚠️ Tesla battery is low: ${BATTERY_LEVEL}%"
fi

# Check if vehicle is unlocked
LOCKED=$(~/.openclaw/skills/tesla-status/tesla-status.sh status | grep "Locked" | cut -d: -f2 | tr -d ' ')
if [ "$LOCKED" = "False" ]; then
    echo "🔓 Tesla is unlocked!"
fi

# Check if sentry mode is off
SENTRY=$(~/.openclaw/skills/tesla-status/tesla-status.sh status | grep "Sentry Mode" | cut -d: -f2 | tr -d ' ')
if [ "$SENTRY" = "False" ]; then
    echo "🚨 Sentry mode is off"
fi
```

## Quick Reference

| Command | Description | Example Output |
|---------|-------------|----------------|
| `cars` | List vehicles | `Car ID: 1, Name: "Motor AAT", Model: Y` |
| `status` | Current status | `Battery: 77%, Range: 370km, Locked: True` |
| `battery` | Battery health | `Health: 99.14%, Max range: 498.87km` |
| `charge` | Charging info | `Plugged: False, State: disconnected` |
| `details` | Vehicle details | `Model: Y, Color: MidnightSilver, VIN: ...` |

## Troubleshooting

1. **API not responding**: Check if TeslaMate API is running on port 8686
2. **No data returned**: Vehicle might be asleep/offline
3. **Authentication error**: Set `TESLAMATE_API_TOKEN` for wake commands
4. **Python import error**: Install requests module: `pip install requests`