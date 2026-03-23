#!/usr/bin/env python3
"""
Tesla Status Skill - Query Tesla vehicle status via TeslaMate API
"""

import os
import sys
import json
import requests
from datetime import datetime

# Default API endpoint
API_BASE_URL = os.environ.get('TESLAMATE_API_HOST', 'http://localhost:8686')
API_TOKEN = os.environ.get('TESLAMATE_API_TOKEN', None)

def get_cars():
    """Get list of all Tesla vehicles"""
    try:
        response = requests.get(f"{API_BASE_URL}/api/v1/cars")
        if response.status_code == 200:
            data = response.json()
            cars = data.get('data', {}).get('cars', [])
            return cars
        else:
            print(f"Error: {response.status_code}")
            return None
    except Exception as e:
        print(f"Error fetching cars: {e}")
        return None

def get_car_status(car_id=1):
    """Get detailed status for a specific car"""
    try:
        response = requests.get(f"{API_BASE_URL}/api/v1/cars/{car_id}/status")
        if response.status_code == 200:
            data = response.json()
            status = data.get('data', {}).get('status', {})
            return status
        else:
            print(f"Error: {response.status_code}")
            return None
    except Exception as e:
        print(f"Error fetching status: {e}")
        return None

def get_battery_health(car_id=1):
    """Get battery health information"""
    try:
        response = requests.get(f"{API_BASE_URL}/api/v1/cars/{car_id}/battery-health")
        if response.status_code == 200:
            data = response.json()
            return data.get('data', {})
        else:
            print(f"Error: {response.status_code}")
            return None
    except Exception as e:
        print(f"Error fetching battery health: {e}")
        return None

def get_current_charge(car_id=1):
    """Get current charging information"""
    try:
        response = requests.get(f"{API_BASE_URL}/api/v1/cars/{car_id}/charges/current")
        if response.status_code == 200:
            data = response.json()
            return data.get('data', {})
        else:
            print(f"Error: {response.status_code}")
            return None
    except Exception as e:
        print(f"Error fetching current charge: {e}")
        return None

def wake_car(car_id=1):
    """Send wake-up command to vehicle"""
    if not API_TOKEN:
        print("Error: API_TOKEN not set. Cannot send wake command.")
        return None
    
    headers = {'Authorization': f'Bearer {API_TOKEN}'}
    try:
        response = requests.post(f"{API_BASE_URL}/api/v1/cars/{car_id}/wake_up", headers=headers)
        if response.status_code == 200:
            data = response.json()
            return data.get('data', {})
        else:
            print(f"Error: {response.status_code}")
            return None
    except Exception as e:
        print(f"Error sending wake command: {e}")
        return None

def format_status(status):
    """Format status data for human-readable output"""
    if not status:
        return "No status data available"
    
    output = []
    
    # Basic info
    output.append(f"Vehicle: {status.get('display_name', 'Unknown')}")
    output.append(f"State: {status.get('state', 'Unknown')}")
    if status.get('state_since'):
        output.append(f"State since: {status.get('state_since')}")
    output.append(f"Odometer: {status.get('odometer', 0)} km")
    
    # Battery
    battery = status.get('battery_details', {})
    if battery:
        output.append(f"Battery Level: {battery.get('battery_level', 0)}%")
        output.append(f"Estimated Range: {battery.get('est_battery_range', 0)} km")
        output.append(f"Rated Range: {battery.get('rated_battery_range', 0)} km")
    
    # Charging
    charging = status.get('charging_details', {})
    if charging:
        output.append(f"Plugged In: {charging.get('plugged_in', False)}")
        output.append(f"Charging State: {charging.get('charging_state', 'Unknown')}")
        if charging.get('charger_power', 0) > 0:
            output.append(f"Charging Power: {charging.get('charger_power', 0)} kW")
    
    # Climate
    climate = status.get('climate_details', {})
    if climate:
        output.append(f"Climate On: {climate.get('is_climate_on', False)}")
        output.append(f"Inside Temp: {climate.get('inside_temp', 0)}°C")
        output.append(f"Outside Temp: {climate.get('outside_temp', 0)}°C")
    
    # Location
    geodata = status.get('car_geodata', {})
    if geodata.get('latitude') and geodata.get('longitude'):
        output.append(f"Location: {geodata.get('latitude')}, {geodata.get('longitude')}")
        if geodata.get('geofence'):
            output.append(f"Geofence: {geodata.get('geofence')}")
    
    # Car status
    car_status = status.get('car_status', {})
    if car_status:
        output.append(f"Locked: {car_status.get('locked', True)}")
        output.append(f"Sentry Mode: {car_status.get('sentry_mode', False)}")
        output.append(f"Windows Open: {car_status.get('windows_open', False)}")
        output.append(f"Doors Open: {car_status.get('doors_open', False)}")
    
    return "\n".join(output)

def main():
    """Main function to handle command-line arguments"""
    if len(sys.argv) < 2:
        print("Usage: tesla_status.py <command> [car_id]")
        print("Commands: cars, status, battery, charge, wake, details")
        sys.exit(1)
    
    command = sys.argv[1]
    car_id = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    
    if command == 'cars':
        cars = get_cars()
        if cars:
            print(f"Found {len(cars)} cars:")
            for car in cars:
                print(f"  Car ID: {car.get('car_id')}")
                print(f"  Name: {car.get('name')}")
                print(f"  Model: {car.get('car_details', {}).get('model')}")
                print(f"  VIN: {car.get('car_details', {}).get('vin')}")
                print()
        else:
            print("No cars found or error occurred")
    
    elif command == 'status':
        status = get_car_status(car_id)
        if status:
            print(format_status(status))
        else:
            print(f"Could not get status for car {car_id}")
    
    elif command == 'battery':
        battery = get_battery_health(carimag_id)
        if battery:
            print(json.dumps(battery, indent=2))
        else:
            print(f"Could not get battery health for car {car_id}")
    
    elif command == 'charge':
        charge = get_current_charge(car_id)
        if charge:
            print(json.dumps(charge, indent=2))
        else:
            print(f"Could not get current charge for car {car_id}")
    
    elif command == 'wake':
        result = wake_car(car_id)
        if result:
            print(f"Wake command sent successfully for car {car_id}")
            print(json.dumps(result, indent=2))
        else:
            print(f"Could not send wake command for car {car_id}")
    
    elif command == 'details':
        cars = get_cars()
        if cars:
            for car in cars:
                if car.get('car_id') == car_id:
                    print(f"Car ID: {car.get('car_id')}")
                    print(f"Name: {car.get('name')}")
                    print(f"Model: {car.get('car_details', {}).get('model')}")
                    print(f"Trim: {car.get('car_details', {}).get('trim_badging')}")
                    print(f"VIN: {car.get('car_details', {}).get('vin')}")
                    print(f"Exterior Color: {car.get('car_exterior', {}).get('exterior_color')}")
                    print(f"Wheel Type: {car.get('car_exterior', {}).get('wheel_type')}")
                    break
            else:
                print(f"Car {car_id} not found")
        else:
            print("Could not fetch car details")
    
    else:
        print(f"Unknown command: {command}")
        sys.exit(1)

if __name__ == '__main__':
    main()