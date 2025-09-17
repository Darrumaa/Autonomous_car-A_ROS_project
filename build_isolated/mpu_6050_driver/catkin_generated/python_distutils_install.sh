#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/self/Saxxophone_500/src/mpu_6050_driver"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/self/Saxxophone_500/install_isolated/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/self/Saxxophone_500/install_isolated/lib/python2.7/dist-packages:/home/self/Saxxophone_500/build_isolated/mpu_6050_driver/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/self/Saxxophone_500/build_isolated/mpu_6050_driver" \
    "/usr/bin/python2" \
    "/home/self/Saxxophone_500/src/mpu_6050_driver/setup.py" \
     \
    build --build-base "/home/self/Saxxophone_500/build_isolated/mpu_6050_driver" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/self/Saxxophone_500/install_isolated" --install-scripts="/home/self/Saxxophone_500/install_isolated/bin"
