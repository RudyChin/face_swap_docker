#!/bin/bash
mkdir models
mkdir output
wget http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2
wget https://github.com/YuvalNirkin/face_segmentation/releases/download/0.9/face_seg_fcn8s.zip
mv shape_predictor_68_face_landmarks.dat.bz2 models/
mv face_seg_fcn8s.zip models/
cd models/
bunzip2 shape_predictor_68_face_landmarks.dat.bz2
unzip -a face_seg_fcn8s.zip
