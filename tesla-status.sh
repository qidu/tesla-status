#!/bin/bash
# Tesla Status Skill - Shell wrapper

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Default car ID
CAR_ID=1

# Parse arguments
COMMAND="$1"
if [ -n "$2" ]; then
    CAR_ID="$2"
fi

case "$COMMAND" in
    "cars")
        curl -s "localhost:8686/api/v1/cars" | python3 -c "
import json, sys
data = json.load(sys.stdin)
cars = data.get('data', {}).get('cars', [])
print(f'Found {len(cars)} cars:')
for car in cars:
    print(f'  Car ID: {car.get(\"car_id\", \"N/A\")}')
    print(f'  Name: \"{car.get(\"name\", \"N/A\")}\"')
    print(f'  Model: {car.get(\"car_details\", {}).get(\"model\", \"N/A\")}')
    print(f'  VIN: {car.get(\"car_details\", {}).get(\"vin\", \"N/A\")}')
    print()
"
        ;;
    "status")
        curl -s "localhost:8686/api/v1/cars/$CAR_ID/status" | python3 -c "
import json, sys
data = json.load(sys.stdin)
status = data.get('data', {}).get('status', {})

if status:
    print(f'Vehicle: {status.get(\"display_name\", \"Unknown\")}')
    print(f'State: {status.get(\"state\", \"Unknown\")}')
    if status.get('state_since'):
        print(f'State since: {status.get(\"state_since\")}')
    print(f'Odometer: {status.get(\"odometer\", 0)} km')
    
    battery = status.get('battery_details', {})
    if battery:
        print(f'Battery Level: {battery.get(\"battery_level\", 0)}%')
        print(f'Estimated Range: {battery.get(\"est_battery_range\", 0)} km')
        print(f'Rated Range: {battery.get(\"rated_battery_range\", 0)} km')
    
    charging = status.get('charging_details', {})
    if charging:
        print(f'Plugged In: {charging.get(\"plugged_in\", False)}')
        print(f'Charging State: {charging.get(\"charging_state\", \"Unknown\")}')
        if charging.get('charger_power', 0) > 0:
            print(f'Charging Power: {charging.get(\"charger_power\", 0)} kW')
    
    climate = status.get('climate_details', {})
    if climate:
        print(f'Climate On: {climate.get(\"is_climate_on\", False)}')
        print(f'Inside Temp: {climate.get(\"inside_temp\", 0)}°C')
        print(f'Outside Temp: {climate.get(\"outside_temp\", 0)}°C')
    
    car_status = status.get('car_status', {})
    if car_status:
        print(f'Locked: {car_status.get(\"locked\", True)}')
        print(f'Sentry Mode: {car_status.get(\"sentry_mode\", False)}')
        print(f'Windows Open: {car_status.get(\"windows_open\", False)}')
        print(f'Doors Open: {car_status.get(\"doors_open\", False)}')
else:
    print('No status data available')
"
        ;;
    "battery")
        curl -s "localhost:8686/api/v1/cars/$CAR_ID/battery-health" | jq -r '.data' || echo "Could not get battery health"
        ;;
    "charge")
        curl -s "localhost:8686/api/v1/cars/$CAR_ID/charges/current" | jq -r '.data' || echo "Could not get current charge"
        ;;
    "details")
        curl -s "localhost:8686/api/v1/cars" | python3 -c "
import json, sys
data = json.load(sys.stdin)
cars = data.get('data', {}).get('cars', [])
for car in cars:
    if car.get('car_id') == $CAR_ID:
        print(f'Car ID: {car.get(\"car_id\", \"N/A\")}')
        print(f'Name: \"{car.get(\"name\", \"N/A\")}\"')
        print(f'Model: {car.get(\"car_details\", {}).get(\"model\", \"N/A\")}')
        print(f'Trim: {car.get(\"car_details\", {}).get(\"trim_badging\", \"N/A\")}')
        print(f'VIN: {car.get(\"car_details\", {}).get(\"vin\", \"N/A\")}')
        print(f'Exterior Color: {car.get(\"car_exterior\", {}).get(\"exterior_color\", \"N/A\")}')
        print(f'Wheel Type: {car.get(\"car_exterior\", {}).get(\"wheel_type\", \"N/A\")}')
        break
else:
    print(f'Car $CAR_ID not found')
"
        ;;
    "test")
        echo "Testing TeslaMate API connection..."
        curl -v "localhost:8686/api/v1/cars"
        ;;
    *)
        echo "Usage: tesla-status.sh <command> [car_id]"
        echo "Commands:"
        echo "  cars      - List all Tesla vehicles"
        echo "  status    - Get detailed status for a car (default: car 1)"
        echo "  battery   - Get battery health information"
        echo "  charge    - Get current charging information"
        echo "  details   - Get vehicle details"
        echo "  test      - Test API connection"
        echo ""
        echo "Examples:"
        echo "  tesla-status.sh status"
        echo "  tesla-status.sh status 1"
        echo "  tesla-status.sh cars"
        ;;
esac