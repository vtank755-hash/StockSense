-- StockSense Seed Data
-- ============================================
USE stocksense;

-- ============================================
-- ADMIN USER (password: Admin@123)
-- ============================================
INSERT INTO users (full_name, email, phone, password, role, department) VALUES
('Admin User', 'admin@stocksense.com', '+91-9876543210', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', 'Management'),
('Rajesh Kumar', 'rajesh@stocksense.com', '+91-9876543211', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'inventory_manager', 'Inventory'),
('Priya Sharma', 'priya@stocksense.com', '+91-9876543212', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'warehouse_staff', 'Warehouse');

-- ============================================
-- CATEGORIES
-- ============================================
INSERT INTO categories (name, description) VALUES
('Raw Materials', 'Basic materials used in production'),
('Finished Goods', 'Completed products ready for sale'),
('Components', 'Parts and sub-assemblies'),
('Office Supplies', 'Office consumables and stationery'),
('Packaging', 'Packaging materials and supplies');

-- ============================================
-- WAREHOUSES
-- ============================================
INSERT INTO warehouses (name, code, address, city, state) VALUES
('Main Warehouse', 'WH-MAIN', '123 Industrial Area, Sector 5', 'Mumbai', 'Maharashtra'),
('Secondary Warehouse', 'WH-SEC', '456 Commerce Park, Phase 2', 'Pune', 'Maharashtra');

-- ============================================
-- LOCATIONS
-- ============================================
INSERT INTO locations (warehouse_id, name, code, type, capacity) VALUES
(1, 'Rack A', 'WH-MAIN-RA', 'rack', 5000),
(1, 'Rack B', 'WH-MAIN-RB', 'rack', 5000),
(1, 'Production Floor', 'WH-MAIN-PF', 'floor', 10000),
(1, 'Storage Area', 'WH-MAIN-SA', 'zone', 20000),
(1, 'Loading Dock', 'WH-MAIN-LD', 'zone', 3000),
(2, 'Rack A', 'WH-SEC-RA', 'rack', 3000),
(2, 'Rack B', 'WH-SEC-RB', 'rack', 3000),
(2, 'Main Floor', 'WH-SEC-MF', 'floor', 8000);

-- ============================================
-- SUPPLIERS
-- ============================================
INSERT INTO suppliers (name, email, phone, address, contact_person) VALUES
('Steel Corp India', 'sales@steelcorp.in', '+91-2234567890', 'Plot 12, MIDC Andheri', 'Amit Patel'),
('WoodWorks Ltd', 'info@woodworks.in', '+91-2234567891', '78 Timber Lane, Thane', 'Suresh Mehta'),
('PackRight Solutions', 'orders@packright.in', '+91-2234567892', '34 Packaging Hub, Navi Mumbai', 'Neha Gupta'),
('ElectroParts Co', 'supply@electroparts.in', '+91-2234567893', '56 Electronics Market, Pune', 'Vikram Singh'),
('ChemSupply India', 'bulk@chemsupply.in', '+91-2234567894', '90 Chemical Zone, Raigad', 'Anita Desai');

-- ============================================
-- CUSTOMERS
-- ============================================
INSERT INTO customers (name, email, phone, address, contact_person) VALUES
('BuildMart Construction', 'purchase@buildmart.in', '+91-2244567890', '22 Builder Avenue, Mumbai', 'Rahul Joshi'),
('FurniCraft Studios', 'orders@furnicraft.in', '+91-2244567891', '15 Design Street, Pune', 'Meera Nair'),
('TechAssembly Pvt Ltd', 'procurement@techassembly.in', '+91-2244567892', '88 Tech Park, Hinjewadi', 'Karan Malhotra'),
('GreenPack Exports', 'imports@greenpack.in', '+91-2244567893', '44 Export Zone, JNPT', 'Divya Reddy'),
('HomeStyle Retail', 'buying@homestyle.in', '+91-2244567894', '67 Retail Mall, Bandra', 'Sanjay Kapoor');

-- ============================================
-- PRODUCTS
-- ============================================
INSERT INTO products (name, sku, category_id, unit_of_measure, reorder_level, description, weight) VALUES
('Steel Rods (10mm)', 'STL-ROD-10', 1, 'kg', 50, 'Mild steel rods 10mm diameter', 1.000),
('Steel Plates (5mm)', 'STL-PLT-05', 1, 'kg', 30, 'Mild steel plates 5mm thickness', 1.000),
('Aluminum Sheets', 'ALU-SHT-01', 1, 'kg', 20, 'Aluminum sheets 2mm thickness', 1.000),
('Oak Plywood', 'WD-PLY-OAK', 1, 'pcs', 15, 'Premium oak plywood 8x4 feet', 25.000),
('Pine Lumber', 'WD-LBR-PIN', 1, 'pcs', 20, 'Pine lumber planks 6 feet', 12.000),
('Office Chair - Ergonomic', 'FG-CHR-ERG', 2, 'pcs', 10, 'Ergonomic office chair with lumbar support', 15.000),
('Standing Desk', 'FG-DSK-STD', 2, 'pcs', 5, 'Adjustable height standing desk', 35.000),
('Bookshelf - 5 Tier', 'FG-BKS-5T', 2, 'pcs', 8, '5-tier wooden bookshelf', 22.000),
('Filing Cabinet', 'FG-FLC-3D', 2, 'pcs', 6, '3-drawer metal filing cabinet', 28.000),
('Conference Table', 'FG-CNF-TBL', 2, 'pcs', 3, '10-seater conference table', 80.000),
('Screws Box (100pc)', 'CMP-SCR-100', 3, 'box', 25, 'Box of 100 wood screws', 0.500),
('Hinges Set', 'CMP-HNG-SET', 3, 'pcs', 30, 'Door hinge set (2 pieces)', 0.300),
('Drawer Slides', 'CMP-DRS-01', 3, 'pcs', 20, 'Ball bearing drawer slides 18 inch', 0.800),
('Cabinet Handles', 'CMP-HDL-01', 3, 'pcs', 40, 'Stainless steel cabinet handles', 0.150),
('A4 Paper Ream', 'OFF-PPR-A4', 4, 'pcs', 15, 'A4 size paper ream 500 sheets', 2.500),
('Printer Ink Cartridge', 'OFF-INK-BK', 4, 'pcs', 5, 'Black ink cartridge for HP printer', 0.200),
('Bubble Wrap Roll', 'PKG-BBL-50', 5, 'roll', 10, 'Bubble wrap roll 50 meters', 3.000),
('Cardboard Box (Large)', 'PKG-BOX-LG', 5, 'pcs', 50, 'Large shipping cardboard box', 0.800),
('Packing Tape', 'PKG-TPE-01', 5, 'roll', 20, 'Brown packing tape 100m roll', 0.400),
('Stretch Film', 'PKG-STR-01', 5, 'roll', 8, 'Pallet stretch film 500mm', 4.000);

-- ============================================
-- PRODUCT STOCK
-- ============================================
INSERT INTO product_stock (product_id, warehouse_id, location_id, quantity) VALUES
(1, 1, 1, 200),   -- Steel Rods in Main WH, Rack A
(2, 1, 1, 150),   -- Steel Plates in Main WH, Rack A
(3, 1, 2, 80),    -- Aluminum Sheets in Main WH, Rack B
(4, 1, 4, 45),    -- Oak Plywood in Main WH, Storage
(5, 1, 4, 60),    -- Pine Lumber in Main WH, Storage
(6, 1, 3, 25),    -- Office Chair in Main WH, Production Floor
(7, 1, 3, 12),    -- Standing Desk in Main WH, Production Floor
(8, 1, 3, 18),    -- Bookshelf in Main WH, Production Floor
(9, 1, 2, 15),    -- Filing Cabinet in Main WH, Rack B
(10, 1, 3, 4),    -- Conference Table in Main WH, Production Floor
(11, 1, 1, 120),  -- Screws in Main WH, Rack A
(12, 1, 1, 85),   -- Hinges in Main WH, Rack A
(13, 1, 2, 45),   -- Drawer Slides in Main WH, Rack B
(14, 1, 2, 100),  -- Cabinet Handles in Main WH, Rack B
(15, 1, 4, 30),   -- A4 Paper in Main WH, Storage
(16, 1, 4, 8),    -- Printer Ink in Main WH, Storage
(17, 2, 6, 25),   -- Bubble Wrap in Sec WH, Rack A
(18, 2, 6, 75),   -- Cardboard Box in Sec WH, Rack A
(19, 2, 7, 40),   -- Packing Tape in Sec WH, Rack B
(20, 2, 7, 12),   -- Stretch Film in Sec WH, Rack B
-- Some products in secondary warehouse too
(1, 2, 8, 50),    -- Steel Rods in Sec WH
(6, 2, 8, 10),    -- Office Chair in Sec WH
(11, 2, 6, 60);   -- Screws in Sec WH

-- ============================================
-- REORDER RULES
-- ============================================
INSERT INTO reorder_rules (product_id, warehouse_id, min_stock, max_stock, reorder_qty) VALUES
(1, 1, 50, 500, 100),
(2, 1, 30, 300, 75),
(3, 1, 20, 200, 50),
(6, 1, 10, 50, 15),
(7, 1, 5, 30, 10),
(11, 1, 25, 200, 50),
(15, 1, 15, 100, 25),
(17, 2, 10, 50, 15),
(18, 2, 50, 200, 50);

-- ============================================
-- SAMPLE RECEIPTS
-- ============================================
INSERT INTO receipts (reference, supplier_id, warehouse_id, location_id, status, scheduled_date, completed_date, notes, created_by) VALUES
('REC-2026-001', 1, 1, 1, 'done', '2026-09-20', '2026-09-20 10:30:00', 'Monthly steel supply', 1),
('REC-2026-002', 2, 1, 4, 'done', '2026-09-21', '2026-09-21 14:15:00', 'Plywood order delivery', 1),
('REC-2026-003', 3, 2, 6, 'ready', '2026-09-25', NULL, 'Packaging materials restock', 2),
('REC-2026-004', 4, 1, 2, 'waiting', '2026-09-28', NULL, 'Component order - Q4 batch', 2),
('REC-2026-005', 1, 1, 1, 'draft', '2026-10-01', NULL, 'Next month steel order', 1);

INSERT INTO receipt_items (receipt_id, product_id, expected_qty, received_qty) VALUES
(1, 1, 100, 100),
(1, 2, 75, 75),
(2, 4, 25, 25),
(2, 5, 30, 30),
(3, 17, 15, 15),
(3, 18, 50, 50),
(4, 13, 25, 0),
(4, 14, 50, 0),
(5, 1, 150, 0),
(5, 2, 100, 0);

-- ============================================
-- SAMPLE DELIVERIES
-- ============================================
INSERT INTO deliveries (reference, customer_id, warehouse_id, location_id, status, scheduled_date, completed_date, notes, created_by) VALUES
('DEL-2026-001', 1, 1, 1, 'done', '2026-09-19', '2026-09-19 16:00:00', 'Steel delivery to BuildMart', 1),
('DEL-2026-002', 2, 1, 3, 'done', '2026-09-22', '2026-09-22 11:30:00', 'Furniture order for FurniCraft', 2),
('DEL-2026-003', 3, 1, 2, 'packing', '2026-09-26', NULL, 'Component shipment to TechAssembly', 2),
('DEL-2026-004', 4, 2, 6, 'picking', '2026-09-27', NULL, 'Packaging supplies for GreenPack', 1),
('DEL-2026-005', 5, 1, 3, 'draft', '2026-09-30', NULL, 'HomeStyle retail order', 1);

INSERT INTO delivery_items (delivery_id, product_id, ordered_qty, delivered_qty, picked, packed) VALUES
(1, 1, 30, 30, 1, 1),
(1, 2, 20, 20, 1, 1),
(2, 6, 5, 5, 1, 1),
(2, 8, 3, 3, 1, 1),
(3, 13, 10, 0, 1, 0),
(3, 14, 25, 0, 1, 0),
(4, 17, 5, 0, 0, 0),
(4, 18, 20, 0, 0, 0),
(5, 7, 2, 0, 0, 0),
(5, 10, 1, 0, 0, 0);

-- ============================================
-- SAMPLE TRANSFERS
-- ============================================
INSERT INTO transfers (reference, source_warehouse_id, source_location_id, dest_warehouse_id, dest_location_id, status, scheduled_date, completed_date, notes, created_by) VALUES
('TRF-2026-001', 1, 4, 1, 3, 'done', '2026-09-18', '2026-09-18 09:00:00', 'Move lumber to production', 2),
('TRF-2026-002', 1, 1, 2, 8, 'done', '2026-09-20', '2026-09-20 15:00:00', 'Transfer steel to secondary warehouse', 1),
('TRF-2026-003', 1, 2, 1, 5, 'waiting', '2026-09-27', NULL, 'Move items to loading dock for shipment', 2);

INSERT INTO transfer_items (transfer_id, product_id, quantity) VALUES
(1, 5, 10),
(2, 1, 50),
(3, 9, 5);

-- ============================================
-- SAMPLE ADJUSTMENTS
-- ============================================
INSERT INTO adjustments (reference, warehouse_id, location_id, status, reason, adjustment_date, completed_date, created_by) VALUES
('ADJ-2026-001', 1, 1, 'done', 'Monthly physical count - minor discrepancy', '2026-09-15', '2026-09-15 17:00:00', 1),
('ADJ-2026-002', 1, 3, 'done', 'Damaged items found during inspection', '2026-09-22', '2026-09-22 12:00:00', 2);

INSERT INTO adjustment_items (adjustment_id, product_id, system_qty, physical_qty, difference) VALUES
(1, 12, 88, 85, -3),
(2, 6, 27, 25, -2);

-- ============================================
-- SAMPLE STOCK LEDGER
-- ============================================
INSERT INTO stock_ledger (product_id, warehouse_id, location_id, movement_type, reference_type, reference_id, reference_code, previous_stock, movement_qty, new_stock, notes, user_id, created_at) VALUES
(1, 1, 1, 'receipt', 'receipt', 1, 'REC-2026-001', 100, 100, 200, 'Steel rods received from Steel Corp', 1, '2026-09-20 10:30:00'),
(2, 1, 1, 'receipt', 'receipt', 1, 'REC-2026-001', 75, 75, 150, 'Steel plates received from Steel Corp', 1, '2026-09-20 10:30:00'),
(4, 1, 4, 'receipt', 'receipt', 2, 'REC-2026-002', 20, 25, 45, 'Oak plywood received', 1, '2026-09-21 14:15:00'),
(5, 1, 4, 'receipt', 'receipt', 2, 'REC-2026-002', 30, 30, 60, 'Pine lumber received', 1, '2026-09-21 14:15:00'),
(1, 1, 1, 'delivery', 'delivery', 1, 'DEL-2026-001', 230, -30, 200, 'Steel rods delivered to BuildMart', 1, '2026-09-19 16:00:00'),
(2, 1, 1, 'delivery', 'delivery', 1, 'DEL-2026-001', 170, -20, 150, 'Steel plates delivered to BuildMart', 1, '2026-09-19 16:00:00'),
(6, 1, 3, 'delivery', 'delivery', 2, 'DEL-2026-002', 30, -5, 25, 'Chairs delivered to FurniCraft', 2, '2026-09-22 11:30:00'),
(8, 1, 3, 'delivery', 'delivery', 2, 'DEL-2026-002', 21, -3, 18, 'Bookshelves delivered to FurniCraft', 2, '2026-09-22 11:30:00'),
(5, 1, 4, 'transfer_out', 'transfer', 1, 'TRF-2026-001', 70, -10, 60, 'Lumber moved to production floor', 2, '2026-09-18 09:00:00'),
(5, 1, 3, 'transfer_in', 'transfer', 1, 'TRF-2026-001', 0, 10, 10, 'Lumber received at production floor', 2, '2026-09-18 09:00:00'),
(1, 1, 1, 'transfer_out', 'transfer', 2, 'TRF-2026-002', 250, -50, 200, 'Steel transferred to secondary warehouse', 1, '2026-09-20 15:00:00'),
(1, 2, 8, 'transfer_in', 'transfer', 2, 'TRF-2026-002', 0, 50, 50, 'Steel received at secondary warehouse', 1, '2026-09-20 15:00:00'),
(12, 1, 1, 'adjustment', 'adjustment', 1, 'ADJ-2026-001', 88, -3, 85, 'Physical count discrepancy', 1, '2026-09-15 17:00:00'),
(6, 1, 3, 'adjustment', 'adjustment', 2, 'ADJ-2026-002', 27, -2, 25, 'Damaged items written off', 2, '2026-09-22 12:00:00');

-- ============================================
-- SAMPLE MOVE HISTORY
-- ============================================
INSERT INTO move_history (product_id, product_name, sku, movement_type, quantity, from_warehouse, from_location, to_warehouse, to_location, reference_code, status, user_id, user_name, created_at) VALUES
(1, 'Steel Rods (10mm)', 'STL-ROD-10', 'receipt', 100, NULL, NULL, 'Main Warehouse', 'Rack A', 'REC-2026-001', 'done', 1, 'Admin User', '2026-09-20 10:30:00'),
(2, 'Steel Plates (5mm)', 'STL-PLT-05', 'receipt', 75, NULL, NULL, 'Main Warehouse', 'Rack A', 'REC-2026-001', 'done', 1, 'Admin User', '2026-09-20 10:30:00'),
(4, 'Oak Plywood', 'WD-PLY-OAK', 'receipt', 25, NULL, NULL, 'Main Warehouse', 'Storage Area', 'REC-2026-002', 'done', 1, 'Admin User', '2026-09-21 14:15:00'),
(5, 'Pine Lumber', 'WD-LBR-PIN', 'receipt', 30, NULL, NULL, 'Main Warehouse', 'Storage Area', 'REC-2026-002', 'done', 1, 'Admin User', '2026-09-21 14:15:00'),
(1, 'Steel Rods (10mm)', 'STL-ROD-10', 'delivery', 30, 'Main Warehouse', 'Rack A', NULL, NULL, 'DEL-2026-001', 'done', 1, 'Admin User', '2026-09-19 16:00:00'),
(2, 'Steel Plates (5mm)', 'STL-PLT-05', 'delivery', 20, 'Main Warehouse', 'Rack A', NULL, NULL, 'DEL-2026-001', 'done', 1, 'Admin User', '2026-09-19 16:00:00'),
(6, 'Office Chair - Ergonomic', 'FG-CHR-ERG', 'delivery', 5, 'Main Warehouse', 'Production Floor', NULL, NULL, 'DEL-2026-002', 'done', 2, 'Rajesh Kumar', '2026-09-22 11:30:00'),
(8, 'Bookshelf - 5 Tier', 'FG-BKS-5T', 'delivery', 3, 'Main Warehouse', 'Production Floor', NULL, NULL, 'DEL-2026-002', 'done', 2, 'Rajesh Kumar', '2026-09-22 11:30:00'),
(5, 'Pine Lumber', 'WD-LBR-PIN', 'transfer', 10, 'Main Warehouse', 'Storage Area', 'Main Warehouse', 'Production Floor', 'TRF-2026-001', 'done', 2, 'Rajesh Kumar', '2026-09-18 09:00:00'),
(1, 'Steel Rods (10mm)', 'STL-ROD-10', 'transfer', 50, 'Main Warehouse', 'Rack A', 'Secondary Warehouse', 'Main Floor', 'TRF-2026-002', 'done', 1, 'Admin User', '2026-09-20 15:00:00'),
(12, 'Hinges Set', 'CMP-HNG-SET', 'adjustment', -3, 'Main Warehouse', 'Rack A', 'Main Warehouse', 'Rack A', 'ADJ-2026-001', 'done', 1, 'Admin User', '2026-09-15 17:00:00'),
(6, 'Office Chair - Ergonomic', 'FG-CHR-ERG', 'adjustment', -2, 'Main Warehouse', 'Production Floor', 'Main Warehouse', 'Production Floor', 'ADJ-2026-002', 'done', 2, 'Rajesh Kumar', '2026-09-22 12:00:00');

-- ============================================
-- SAMPLE ALERTS
-- ============================================
INSERT INTO alerts (type, product_id, warehouse_id, message) VALUES
('low_stock', 10, 1, 'Conference Table stock is low (4 pcs). Reorder level: 3 pcs.'),
('low_stock', 16, 1, 'Printer Ink Cartridge stock is low (8 pcs). Reorder level: 5 pcs.'),
('low_stock', 7, 1, 'Standing Desk stock is approaching reorder level (12 pcs). Reorder level: 5 pcs.'),
('pending_receipt', NULL, 1, 'Receipt REC-2026-004 is waiting for component delivery.'),
('pending_delivery', NULL, 2, 'Delivery DEL-2026-004 is in picking stage.');
