-- init.sql
-- イベントモデルへの挿入
INSERT INTO yourapp_eventmodel (eventName, packageName, componentName, nodeViewId, nodeAddress, images, detail)
VALUES 
('Event1', 'com.example.package1', 'Component1', 'ViewId1', 'Address1', 'example_image1.jpg', 'This is a detail for Event 1'),
('Event2', 'com.example.package2', 'Component2', 'ViewId2', 'Address2', 'example_image2.jpg', 'This is a detail for Event 2'),
('Event3', 'com.example.package3', 'Component3', 'ViewId3', 'Address3', 'example_image3.jpg', 'This is a detail for Event 3');

-- 一般ユーザーの挿入
INSERT INTO auth_user (username, email, password, is_superuser, is_staff, is_active, date_joined)
VALUES 
('normal_user', 'user@example.com', crypt('userpassword', gen_salt('bf')), false, false, true, NOW()),
('akinari', 'akinari@example.com', crypt('akinari19911119', gen_salt('bf')), false, false, true, NOW());