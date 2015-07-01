#include <iostream>
#include <vector>
#include <fstream>
#include <limits>
#include <cmath>
#include <algorithm>

#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

void dilate_one(cv::Mat& grid){
    cv::Size sz = grid.size();
    cv::Mat sc_copy = grid.clone();

    for(int i = 0; i < sz.height; i++){
        for(int j = 0; j < sz.width; j++){
            if(grid.at<uchar>(i,j) == 1){
                if(i < sz.height -1)
                    sc_copy.at<uchar>(i+1,j) = 0;
                if(i > 0)
                    sc_copy.at<uchar>(i-1,j) = 0;
                if(j < sz.width -1)
                    sc_copy.at<uchar>(i,j+1) = 0;
                if(j > 0)
                    sc_copy.at<uchar>(i,j-1) = 0;
                if(i > 0 && j > 0)
                    sc_copy.at<uchar>(i-1,j-1) = 0;
                if(i < sz.height -1 && j < sz.width -1)
                    sc_copy.at<uchar>(i+1,j+1) = 0;
                if(i > 0 && j < sz.width -1)
                    sc_copy.at<uchar>(i-1,j+1) = 0;
                if(i < sz.height -1 && j > 0)
                    sc_copy.at<uchar>(i+1,j-1) = 0;
            }
        }
    }
    grid = sc_copy;
}

const size_t img_size = 2304;

std::vector<size_t> labels(50000);
std::vector<std::vector<float>> images(50000);
std::vector<std::vector<float>> test_set;

size_t load_train(std::ifstream& data){
    size_t id, label;
    while(data.good()){
        data >> id >> label; // st
        images[id -1].resize(img_size);
        for(size_t i = 0; i < img_size; i++){
            data >> images[id -1][i];
        }
        labels.push_back(label);
    }
    return id;
}

size_t load_test(std::ifstream& data){
    test_set = std::vector<std::vector<float>>(20000);
    size_t id;
    while(data.good()){
        data >> id; // st
        test_set[id -1].resize(img_size);
        for(size_t i = 0; i < img_size; i++){
            data >> test_set[id -1][i];
        }
    }
    return id;
}

int main(int argc, char* argv[]){
    std::ifstream data(argv[1]);

    size_t loaded = load_train(data);
    std::cerr << "loaded " << loaded << " examples" << std::endl;
    for(size_t i = 0; i < images.size(); i++){
        cv::Mat m(48, 48, CV_32FC1, (void*) images[i].data());
        m.convertTo(m, CV_8UC1, 256);
//        cv::Canny(m, m, 5000, 5000, 5, false);
        cv::Laplacian(m, m, CV_8UC1);//CV_32FC1);
        //dilate_one(m);
        cv::imshow("X", m);
        char x = cv::waitKey();
        if(x == 'x') break;
    }
    return 0;
}
