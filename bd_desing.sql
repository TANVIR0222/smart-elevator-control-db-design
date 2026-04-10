// ১. Infrastructure
BuildingsName {
  id serial pk
  name varchar
  location_city varchar
  total_shafts int
  created_at timestamp default now()
  updated_at timestamp default now()
}

Zones {
  id serial pk
  building_id int fk
  zone_name varchar
  description text
  created_at timestamp default now()
  updated_at timestamp default now()
}

Floors {
  id serial pk
  building_id int fk
  zone_id int fk 
  floor_number int
  label varchar
  is_active boolean
  created_at timestamp default now()
  updated_at timestamp default now()
}

// ২. Elevator Hardware
Shafts {
  id serial pk
  building_id int fk
  zone_id int fk
  shaft_label varchar
  created_at timestamp default now()
  updated_at timestamp default now()
}

Elevators {
  id serial pk
  shaft_id int fk
  model_number varchar
  capacity_persons int
  max_weight_kg int
  installation_date date
  created_at timestamp default now()
  updated_at timestamp default now()
}

// ৩. Real-time Status
ElevatorStatus {
  elevator_id int pk, fk
  current_floor_id int fk
  direction varchar // up, down, idle
  door_status varchar // open, closed
  operating_mode varchar // active, maintenance, emergency
  last_ping_at timestamp
}

// History লগ (Analytics)
ElevatorStatusHistory {
  id serial pk
  elevator_id int fk
  floor_id int fk
  direction varchar
  door_status varchar
  operating_mode varchar
  recorded_at timestamp
}

// ৪. Access Mapping (Many-to-Many)
ElevatorFloorAccess {
  elevator_id int pk, fk
  floor_id int pk, fk
  can_stop boolean default true
  priority int default 1
  created_at timestamp default now()
}

// ৫. Requests
FloorRequests {
  id serial pk
  source_floor_id int fk
  destination_floor_id int fk
  direction varchar
  request_time timestamp
  status varchar // pending, assigned, completed, cancelled
  cancel_reason varchar
  created_at timestamp default now()
  updated_at timestamp default now()
}

// ৬. Assignment Layer
RideAssignments {
  id serial pk
  request_id int fk
  elevator_id int fk
  assigned_at timestamp
  completed_at timestamp
  status varchar // assigned, completed, failed
  created_at timestamp default now()
}

// ৭. Ride Logs
Rides {
  id serial pk
  elevator_id int fk
  request_id int fk
  from_floor_id int fk
  to_floor_id int fk
  start_time timestamp
  end_time timestamp
  total_weight_kg float
  created_at timestamp default now()
}

// ৮. Maintenance
MaintenanceRecords {
  id serial pk
  elevator_id int fk
  scheduled_date date
  completion_date date
  technician_id varchar
  action_taken text
  status varchar
  created_at timestamp default now()
  updated_at timestamp default now()
}

// Infrastructure
BuildingsName.id < Zones.building_id
BuildingsName.id < Floors.building_id
Zones.id < Floors.zone_id

// Hardware
BuildingsName.id < Shafts.building_id
Zones.id < Shafts.zone_id
Shafts.id < Elevators.shaft_id

// Status
Elevators.id - ElevatorStatus.elevator_id
Floors.id < ElevatorStatus.current_floor_id

// Status History
Elevators.id < ElevatorStatusHistory.elevator_id
Floors.id < ElevatorStatusHistory.floor_id

// Access Mapping
Elevators.id < ElevatorFloorAccess.elevator_id
Floors.id < ElevatorFloorAccess.floor_id

// Requests
Floors.id < FloorRequests.source_floor_id
Floors.id < FloorRequests.destination_floor_id

// Assignment
FloorRequests.id < RideAssignments.request_id
Elevators.id < RideAssignments.elevator_id

// Ride Logs
Elevators.id < Rides.elevator_id
FloorRequests.id < Rides.request_id
Floors.id < Rides.from_floor_id
Floors.id < Rides.to_floor_id

// Maintenance
Elevators.id < MaintenanceRecords.elevator_id