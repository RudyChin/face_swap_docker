#!/bin/bash
mkdir data
wget http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2
wget https://github.com/YuvalNirkin/face_segmentation/releases/download/0.9/face_seg_fcn8s.zip
wget https://github.com/YuvalNirkin/face_swap/releases/download/0.9/3dmm_cnn_resnet_101.zip
mv shape_predictor_68_face_landmarks.dat.bz2 data/
mv face_seg_fcn8s.zip data/
mv 3dmm_cnn_resnet_101.zip data/
cd data/
bunzip2 shape_predictor_68_face_landmarks.dat.bz2
unzip -a face_seg_fcn8s.zip
unzip -a 3dmm_cnn_resnet_101.zip
