## Simulator setup: 
Code For Habitat-ROS interface with Humans walking around 

Installation:
1. Before you build the simulation docker file, make sure you have downloaded the submodules (Save them to local repositories that will get mounted to your docker image). Here is the git repo for each:

- habitat-lab: git clone -b dev https://github.com/UMich-CURLY/habitat-lab.git habitat-lab
- ORCA-Algorithm: git clone -b main https://github.com/UMich-CURLY/ORCA.git ORCA-Algorithm
- habitat-sim: git clone --branch v0.3.0 https://github.com/facebookresearch/habitat-sim.git habitat-sim
- habitat_ros_interface: git clone -b v0.3 https://github.com/UMich-CURLY/habitat_ros_interface.git habitat_ros_interface
- dataset: cd habitat-sim; python -m utils/datasets_download.py --uids hssd-hab hab3-episodes habitat_humanoids hab3_bench_assets

2. Next we need to build the Dockerfile:

docker build -t sim .

3. Launch the docker using the launch_docker.sh script. If you have all the submodules clones properly it will mount them all.
4. Next we need to build all the packages inside the docker container:

'''
". activate habitat; cd habitat-sim; pip install -r requirements.txt; python setup.py install --bullet"
". activate habitat; cd habitat-lab; pip install -e habitat-lab/"
". activate habitat; cd habitat-lab; pip install -e habitat-baselines/"
". activate robostackenv; cd /home/catkin_ws; catkin_make"
'''

5. To test if everything you want to run the following three in separate terminals:
'''
   ". activate habitat; python examples/play_rvo_agent.py --cfg habitat-lab/habitat/config/benchmark/multi_agent/hssd_fetch_human_social_nav_irl.yaml --disable-inverse-kinematics"
   ". activate robostackenv; roslaunch habitat_interface simple.launch"
   ". activate robostackenv; roslaunch habitat_interface map_only.launch"

'''

Visualize everything in RVIZ; This will have the agents running using ORCA crossing a door. 
   
## Inverse Reinforcement Learning Setup 


