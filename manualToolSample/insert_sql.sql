-- イベントモデルへの挿入
INSERT INTO boardapp_eventmodel (eventName, packageName, componentName, nodeViewId, nodeAddress, images, detail)
VALUES 
('Event1', 'com.example.package1', 'Component1', 'ViewId1', 'Address1', 'example_image1.jpg', 'This is a detail for Event 1'),
('Event2', 'com.example.package2', 'Component2', 'ViewId2', 'Address2', 'example_image2.jpg', 'This is a detail for Event 2'),
('Event3', 'com.example.package3', 'Component3', 'ViewId3', 'Address3', 'example_image3.jpg', 'This is a detail for Event 3');