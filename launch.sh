container_name=$1
xhost +local:
XAUTH=/home/tribhi/.docker.xauth
touch $XAUTH
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi
docker run -it --net=host\
    --user=$(id -u) \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="USER=$USER" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="${PWD}/habitat-lab:/habitat-lab" \
    --volume="${PWD}/habitat_ros_interface:/home/catkin_ws/src/habitat_ros_interface" \
    --volume="${PWD}/habitat-sim:/habitat-sim" \
    --volume="${PWD}/Python-RVO2:/Python-RVO2" \
    --volume="${PWD}/CrowdNav:/CrowdNav" \
    --volume="${PWD}/ORCA-algorithm:/ORCA-algorithm" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    -v "/etc/passwd:/etc/passwd:rw" \
    --privileged \
    --gpus all \
    --security-opt seccomp=unconfined \
    --name=${container_name} \
    habicrowd:latest
