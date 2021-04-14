 vrep=remApi('remoteApi');
 vrep.simxFinish(-1);
 clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
 if (clientID>-1)
     disp('Connected');
     
     [returnCode,detectionState,detectedPoint,~,~]=vrep.simxReadProximitySensor(clientID,Front_Sensor,vrep.simx_opmode_streaming);
     
     % Handle
     
     [returnCode,Left_Motor] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',vrep.simx_opmode_blocking);
     [returnCode,Front_Sensor] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_ultrasonicSensor5',vrep.simx_opmode_blocking);
     [returnCode,camera] = vrep.simxGetObjectHandle(clientID,'Vision_sensor',vrep.simx_opmode_blocking);  
     
     % Other Code
     [returnCode,resolution,image] = vrep.simxGetVisionSensorImage2(clientID,camera,0,vrep.simx_opmode_streaming);   
     [returnCode] = vrep.simxSetJointTargetVelocity(clientID,Left_Motor,0.1,vrep.simx_opmode_blocking); 
        
     tic
        for i=1:50
            
            [returnCode,detectionState,detectedPoint,~,~]=vrep.simxReadProximitySensor(clientID,Front_Sensor,vrep.simx_opmode_buffer);
            [returnCode,resolution,image] = vrep.simxGetVisionSensorImage2(clientID,camera,0,vrep.simx_opmode_buffer);   
            disp(toc)
            imshow(image)
            % disp(norm(detectedPoint));
            pause(0.1);
            
        end
        
     [returnCode] = vrep.simxSetJointTargetVelocity(clientID,Left_Motor,0,vrep.simx_opmode_blocking);
 
     vrep.simxFinish(-1);
 end
 vrep.delete(); 
            