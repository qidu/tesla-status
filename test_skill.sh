#!/bin/bash
# Test script for Tesla Status Skill

echo "=== Testing Tesla Status Skill ==="
echo ""

echo "1. Testing 'tesla-status.sh cars':"
echo "----------------------------------"
./tesla-status.sh cars
echo ""

echo "2. Testing 'tesla-status.sh status':"
echo "------------------------------------"
./tesla-status.sh status
echo ""

echo "3. Testing 'tesla-status.sh details':"
echo "-------------------------------------"
./tesla-status.sh details
echo ""

echo "4. Testing 'tesla-status.sh battery':"
echo "--------------------------------------"
./tesla-status.sh battery
echo ""

echo "5. Testing 'tesla-status.sh charge':"
echo "-------------------------------------"
./tesla-status.sh charge
echo ""

echo "=== Testing Python script ==="
echo ""

echo "6. Testing Python script 'tesla_status.py cars':"
echo "------------------------------------------------"
python3 tesla_status.py cars
echo ""

echo "7. Testing Python script 'tesla_status.py status':"
echo "--------------------------------------------------"
python3 tesla_status.py status
echo ""

echo "=== Skill created successfully! ==="
echo ""
echo "To use this skill in OpenClaw, you can:"
echo "1. Call the scripts directly: ./tesla-status.sh status"
echo "2. Use from any directory: python3 ~/.openclaw/skills/tesla-status/tesla_status.py status"
echo "3. Create an alias: alias tesla='~/.openclaw/skills/tesla-status/tesla-status.sh'"
echo ""
echo "Available commands:"
echo "  cars    - List all Tesla vehicles"
echo "  status  - Get detailed status for a car"
echo "  battery - Get battery health information"
echo "  charge  - Get current charging information"
echo "  details - Get vehicle details"
echo "  wake    - Send wake-up command (requires API_TOKEN)"