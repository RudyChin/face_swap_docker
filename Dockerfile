FROM bvlc/caffe:cpu
MAINTAINER Rudy Chin <tingwuc@andrew.cmu.edu>

# Install some dependencies
RUN apt-get update && apt-get install -y \
		bc \
		build-essential \
		cmake \
		curl \
		g++ \
		gfortran \
		git \
		libffi-dev \
		libfreetype6-dev \
		libhdf5-dev \
		libjpeg-dev \
		liblcms2-dev \
		libopenblas-dev \
		liblapack-dev \
		libpng12-dev \
		libssl-dev \
		libtiff5-dev \
		libwebp-dev \
		libzmq3-dev \
		nano \
		pkg-config \
		python-dev \
		software-properties-common \
		unzip \
		vim \
		wget \
		zlib1g-dev \
		qt5-default \
		libvtk6-dev \
		zlib1g-dev \
		libjpeg-dev \
		libwebp-dev \
		libpng-dev \
		libtiff5-dev \
		libjasper-dev \
		libopenexr-dev \
		libgdal-dev \
		libdc1394-22-dev \
		libavcodec-dev \
		libavformat-dev \
		libswscale-dev \
		libtheora-dev \
		libvorbis-dev \
		libxvidcore-dev \
		libx264-dev \
		yasm \
		libopencore-amrnb-dev \
		libopencore-amrwb-dev \
		libv4l-dev \
		libxine2-dev \
		libtbb-dev \
		libeigen3-dev \
		python-dev \
		python-tk \
		python-numpy \
		python3-dev \
		python3-tk \
		python3-numpy \
		ant \
		default-jdk \
		doxygen \
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/* && \
# Link BLAS library to use OpenBLAS using the alternatives mechanism (https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)
	update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3

# Install pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
	python get-pip.py && \
	rm get-pip.py

# Add SNI support to Python
RUN pip --no-cache-dir install \
		pyopenssl \
		ndg-httpsclient \
		pyasn1

# Install useful Python packages using apt-get to avoid version incompatibilities with Tensorflow binary
# especially numpy, scipy, skimage and sklearn (see https://github.com/tensorflow/tensorflow/issues/2034)
RUN apt-get update && apt-get install -y \
		python-numpy \
		python-scipy \
		python-h5py \
		python-matplotlib \
		python-sklearn \
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

# Install other useful Python packages using pip
RUN pip --no-cache-dir install --upgrade ipython && \
	pip --no-cache-dir install \
		Cython \
		ipykernel \
		jupyter \
		path.py \
		Pillow \
		pygments \
		six \
		sphinx \
		wheel \
		zmq \
		&& \
	python -m ipykernel.kernelspec

# Install OpenCV
RUN git clone https://github.com/opencv/opencv_contrib.git /root/opencv_contrib && \
    git clone --depth 1 https://github.com/opencv/opencv.git /root/opencv && \
	cd /root/opencv && \
	mkdir build && \
	cd build && \
	cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON -DOPENCV_EXTRA_MODULES_PATH=/root/opencv_contrib/modules .. && \
	make -j"$(nproc)"  && \
	make install && \
	ldconfig && \
	echo 'ln /dev/null /dev/raw1394' >> ~/.bashrc

# Install GLEW
RUN apt-get update && apt-get install -y libglew-dev
    
# Install boost
RUN apt-get update && apt-get install -y libboost-all-dev 

# DLIB
RUN git clone https://github.com/davisking/dlib /root/dlib && \
    cd /root/dlib && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j"$(nproc)" && \
    make install && \
    ldconfig

# VSAL
RUN git clone https://github.com/RudyChin/vsal.git /root/vsal && \
    cd /root/vsal && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_STANDARD=14 .. && \
    make -j"$(nproc)" && \
    make install && \
    ldconfig

RUN apt-get update && apt-get install -y autoconf libtool

RUN git clone https://github.com/google/protobuf.git /root/protobuf && \
    cd /root/protobuf && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local && \
    make -j"$(nproc)" && \
    make install && \
    ldconfig

# Find Face Landmarks
RUN git clone https://github.com/YuvalNirkin/find_face_landmarks.git /root/find_face_landmarks && \
    cd /root/find_face_landmarks && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_STANDARD=14 .. && \
    make -j"$(nproc)" && \
    make install && \
    ldconfig

RUN cd /opt/caffe && \
    protoc src/caffe/proto/caffe.proto --cpp_out=. && \
    mkdir include/caffe/proto && \
    mv src/caffe/proto/caffe.pb.h include/caffe/proto

# Face Segmentation
RUN git clone https://github.com/YuvalNirkin/face_segmentation.git /root/face_segmentation && \
    cd /root/face_segmentation && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_STANDARD=14 .. && \
    make -j"$(nproc)" && \
    make install && \
    ldconfig

RUN apt-get update && apt-get install -y libhdf5-cpp-11

# Face Swap
RUN git clone https://github.com/RudyChin/face_swap.git /root/face_swap && \
    cd /root/face_swap && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_STANDARD=14 .. && \
    make -j"$(nproc)" && \
    make install && \
    ldconfig

# OpenGL-Docker
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git \
  libgl1-mesa-dri \
  menu \
  net-tools \
  openbox \
  python-pip \
  sudo \
  supervisor \
  tint2 \
  x11-xserver-utils \
  x11vnc \
  xinit \
  xserver-xorg-video-dummy \
  xserver-xorg-input-void \
  websockify && \
  rm -f /usr/share/applications/x11vnc.desktop && \
  apt-get remove -y python-pip && \
  wget https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && \
  pip install supervisor-stdout && \
  apt-get -y clean

COPY etc/skel/.xinitrc /etc/skel/.xinitrc

RUN useradd -m -s /bin/bash user
USER user

RUN cp /etc/skel/.xinitrc /home/user/
USER root
RUN echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user

RUN git clone https://github.com/kanaka/noVNC.git /opt/noVNC && \
  cd /opt/noVNC && \
  git checkout 6a90803feb124791960e3962e328aa3cfb729aeb && \
  ln -s vnc_auto.html index.html

# noVNC (http server) is on 6080, and the VNC server is on 5900
EXPOSE 6080 5900

COPY etc /etc
COPY usr /usr

ENV DISPLAY :0

WORKDIR /root

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]