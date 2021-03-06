# devops_course

1.Create 2 servers with S1 - ubuntu/focal64 and  S2 - centos/8
2.Create hosts.yml file and define:
  ubuntu host group for S1
  centos host group for S2
  linux host group which include ubuntu and centos groups
  
  ![image](https://user-images.githubusercontent.com/18323106/114423723-20212000-9bc0-11eb-9a68-7a33af76dde2.png)
  
3. Create a folder for groups variables. Create folders for ubuntu, centos and linux groups. Add variables for ssh user and ssh key to skip it in the command line.

  ![image](https://user-images.githubusercontent.com/18323106/114423823-39c26780-9bc0-11eb-8c59-4052bcfd9559.png)

  Variables:
  
  ![image](https://user-images.githubusercontent.com/18323106/114423896-4ba40a80-9bc0-11eb-9c4b-f4793e4fb14b.png)

4.For ubuntu centos groups create a variable group_hw20 with values ZONE_1 and ZONE_2 respectively.

  ![image](https://user-images.githubusercontent.com/18323106/114424018-68404280-9bc0-11eb-8570-c7e238b4a6c0.png)

В целом эта инфраструктура работает, хосты пингуются, переменные подтягиваются, группы определяются.

![image](https://user-images.githubusercontent.com/18323106/114424388-ba816380-9bc0-11eb-8771-7d7a503cb7fa.png)


5.Create hw201 role. Add next features to this role. All options should be set as variables:
  Install [git,docker,python3] in one task using loop
  Create user hw20 with /bin/sh and home folder /opt/hw20.
  Create an option to weather add or not user to sudoers group(when condition)
    - В этом пункте не смог сделать условие по sudoers group.
  As user hw20 pull any public git repo to /opt/hw20/
  
  ![image](https://user-images.githubusercontent.com/18323106/114425191-835f8200-9bc1-11eb-80e3-cd8274db9469.png)

6. Create hw202 role. Add next features to this role. All options should be set as variables:

  ![image](https://user-images.githubusercontent.com/18323106/114897510-f9f6bc80-9e19-11eb-9cc8-e2b52c958432.png)


  a. Add the ability to copy local files to any location.
    ![image](https://user-images.githubusercontent.com/18323106/114897603-11ce4080-9e1a-11eb-9ab4-37398c5dda79.png)

  b. Install curl from deb(ubuntu) and rpm(centos) packages which located in the role under file folder. 
    ![image](https://user-images.githubusercontent.com/18323106/114897656-1eeb2f80-9e1a-11eb-926c-ad6da90eb70e.png)

  c. Add ability to set permissions for these files.
    ![image](https://user-images.githubusercontent.com/18323106/114897765-39bda400-9e1a-11eb-9cc6-3856ab8fdcf6.png)

  d.Template. Create a file /HW20_FILE_INFO with content of a variable group_hw20
    ![image](https://user-images.githubusercontent.com/18323106/114897816-46da9300-9e1a-11eb-8bd3-bf81a6d0663f.png)



![image](https://user-images.githubusercontent.com/18323106/114897336-cddb3b80-9e19-11eb-8110-f053cdd210ac.png)
