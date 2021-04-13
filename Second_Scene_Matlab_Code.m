close all
close all
clc
origine_table=[0,0.2,0.65];
cube_dimensions=[0.06,0.06,0.06];
width_offset=0.01;
length_offset=0.03;
end_test=1;
vrep=remApi('remoteApi');
vrep.simxFinish(-1);
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID>-1)
    disp('connected to remote API server');
    % object handles
    
    [res,j1]=vrep.simxGetOjectHandle(clientID,'ROBOTIQ_85_active1',vrep.simx_opmode_blocking);
    [res,j2]=vrep.simxGetOjectHandle(clientID,'ROBOTIQ_85_active2',vrep.simx_opmode_blocking);
    [res,kuka_target]=vrep.simxGetOjectHandle(clientID,'target',vrep.simx_opmode_blocking);
    
    % defining target positions here
    fposition1=[0.2,0.6,0.6,0,0,0]; % x,y,z,alpha,beta,gamma
    fposition2=[0.1,0,0.9,0,0,0];
    fposition3=[-0.12,-0.3,0.75,0,0,0]; % above pickup position
    fposition4=[-0.12,-0.3,0.65,0,0,0]; % pickup position
    fposition5=[0,0.2,0.75,0,0,0]; % above place position
    fposition6=[0,0.2,0.65,0,0,0]; % place position
    
    gripper(clientID,0,j1,j2); % open gripper
    pause(1.5); 
    moveL(clientID,kuka_target,fposition3,2); 
    
    while (end_test==0)
        [res,PSensor_distance,detectedPoint]=vrep.simxReadPromiximitySensor(clientID,Proximity_sensor,vrep.simx_opmode_blocking);
        moveL(clientID,kuka_target,fposition4,2);
        gripper(clientID,1,j1,j2); pause(2); % close gripper and pickup the cube
        moveL(clientID,kuka_target,fposition3,2);
        moveL(clientID,kuka_target,fposition5,2);
        moveL(clientID,kuka_target,fposition6,2);
        gripper(clientID,0,j1,j2); pause(1);
        moveL(clientID,kuka_target,fposition5,2);
        moveL(clientID,kuka_target,fposition3,2);
        % refresh the place position
        [end_test,fposition6,fposition5,fposition3]=pickandplace(origine_table,4,4,3,cube_dimension,width_offset,length_offset,fposition6,fposition5,fposition3);
    end
end

vrep.delete(); % call the destructor
disp('program ended');