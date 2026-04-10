# Smart Elevator Control System (ERD Design)

## Project Overview

This project represents a **scalable and production-ready database design** for a smart elevator control platform used in large infrastructures such as:

- Corporate buildings
- Shopping malls
- Airports
- Hospitals
- High-rise residential complexes

The system is designed to manage **multiple elevators across multiple buildings**, ensuring efficient movement, real-time monitoring, and operational tracking.

---

## System Capabilities

The platform supports:

- Multiple buildings management
- Floor and zone-based organization
- Multiple elevators per building
- Elevator-to-floor mapping (many-to-many)
- Real-time floor request handling
- Smart ride assignment
- Live elevator status monitoring
- Ride logging for analytics
- Maintenance tracking

---

## 🏗️ Database Design Structure

### 1. Infrastructure

- `buildings` → Stores building information
- `zones` → Logical grouping for optimization (e.g., High-rise, Parking)
- `floors` → Floors belonging to buildings and zones

---

### 2. Elevator Hardware

- `shafts` → Physical elevator shafts
- `elevators` → Elevator units with capacity and configuration

---

### 3. Real-Time Status

- `elevator_status` → Current state (live tracking)
- `elevator_status_history` → Historical movement logs

---

### 4. Access Control

- `elevator_floor_access` → Defines which elevators serve which floors

---

### 5. Request & Assignment Flow

- `floor_requests` → User-generated requests (source → destination)
- `ride_assignments` → Assigns elevators to requests

---

### 6. Ride Tracking

- `rides` → Logs completed trips for analytics

---

### 7. Maintenance

- `maintenance_records` → Tracks elevator maintenance history

---

## Request Lifecycle

```text
User Request → floor_requests
            → ride_assignments
            → rides (completed trip)
```

---

## 🔗 Key Relationships

- One building → many floors, zones, shafts
- One shaft → one elevator
- Elevators ↔ Floors → many-to-many
- Requests → Assignments → Rides
- Elevator → Status (1:1 live tracking)
- Elevator → Maintenance (history tracking)

---

## ⚡ Design Highlights

- Separation of **real-time vs historical data**
- Scalable architecture for high-traffic systems
- Supports **zone-based elevator optimization**
- Decoupled request → assignment → ride flow
- Analytics-ready structure

---

## Example Queries Supported

- How many buildings are in the system?
- How many elevators exist in a building?
- Which floors belong to which building?
- Which elevator served a request?
- How many rides did an elevator complete today?
- Which elevator handled the most requests?
- Which requests are still pending?
- Maintenance history per elevator

---

## Future Enhancements

- AI-based elevator dispatch system
- Real-time queue optimization (Redis/Kafka)
- IoT sensor integration
- Predictive maintenance
- Energy usage tracking

---

## Author

This project is designed as a **real-world system design practice** focusing on scalable backend architecture and infrastructure-level problem solving.

---

## ⭐ Support

If you find this project useful, consider giving it a ⭐ on GitHub!
