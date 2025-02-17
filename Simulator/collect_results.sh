#!/bin/bash
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT
sudo killall -9 roscore
sudo killall -9 rosmaster
rosnode kill --all
docker exec -u root djoko bash -c ". activate robostackenv; source devel/setup.bash; roslaunch habitat_interface simple.launch" &
docker exec -u root djoko bash -c ". activate habitat; cd /habitat-lab; python examples/play_irl_agent.py --cfg habitat-lab/habitat/config/benchmark/multi_agent/hssd_fetch_human_social_nav_irl.yaml --disable-inverse-kinematics" &
echo "Should start publishing features"
# docker exec -u root djoko bash -c ". activate robostackenv; source devel/setup.bash; rosrun habitat_interface pub_feat.py"
# docker exec -u root sin bash -c "cd /home/tribhi; source /opt/ros/kinetic/setup.bash; python test_traj_rank_cloud.py" 