#include <iostream>
#include <vector>
#include <fstream>
#include <limits>
#include <cmath>
#include <algorithm>

#include "threadpool.hpp"

class histogram {
    float items;
    float bucket_size;
    std::vector<int> buckets;
public:
    histogram(const int num_buckets)
        : items(num_buckets), bucket_size(1.0/num_buckets), buckets(num_buckets,1) {}

    void add(const float val){
        const int idx = std::min((double)buckets.size() -1, floor(val / bucket_size));
        buckets[idx] += 1;
        items += 1.0;
    }

    float pr(float val) const{
        const int idx = std::min((double)buckets.size() -1, floor(val / bucket_size));
        return buckets[idx] / items;
    }
};

class NaiveBayes {
    const size_t img_size;
    std::vector<size_t> labels;
    std::vector<std::vector<float>> images;
    std::vector<std::vector<histogram>> dists;
    std::vector<std::vector<float>> test_set;
    mutable threadpool tp;

public:

    NaiveBayes(const size_t image_size)
        : img_size(image_size), images(50000), dists(10) {}
    
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

    void train(const size_t buckets, const size_t start, const size_t end){
        for(size_t i = 0; i < dists.size(); i++)
            dists[i] = std::vector<histogram>(img_size, buckets);

        for(size_t i = 0; i < images.size(); i++){
            if( i > start && i < end) continue;
            for(size_t j = 0; j < images[i].size(); j++){
                size_t label = labels[i];
                dists[label][j].add(images[i][j]);
            }
        }
    }
    
    size_t test_one(const size_t img_idx) const{
        std::vector<float> prob(10, log(0.1));
        for(size_t i = 0; i < 10; i++){
            for(size_t j = 0; j < img_size; j++){
                prob[i] += log(dists[i][j].pr(test_set[img_idx][j]));
            }
        }
        const size_t pred = std::distance(prob.cbegin(), std::max_element(prob.cbegin(), prob.cend()));
        return pred;
    }

    void test() const {
        std::cout << "Id,Prediction" << std::endl;
        for(size_t i = 0; i < test_set.size(); i++){
            const size_t label = test_one(i);
            std::cout << (i+1) << "," << label << std::endl;
        }
    }

    bool check_one(const size_t img_idx) const{
        std::vector<float> prob(10, log(0.1));
        for(size_t i = 0; i < 10; i++){
            for(size_t j = 0; j < img_size; j++){
                prob[i] += log(dists[i][j].pr(images[img_idx][j]));
            }
        }
        const size_t pred = std::distance(prob.cbegin(), std::max_element(prob.cbegin(), prob.cend()));
        return labels[img_idx] == pred;
    }

    float
    validate(const size_t start, const size_t end) const{
        float right = 0.0;
        const size_t N = (end - start);
        std::vector<std::future<bool>> futs;
        futs.reserve(N);
        for(size_t i = 0; i < images.size(); i++){
            if( i < start || i > end) continue;
            futs.emplace_back(tp.enqueue(&NaiveBayes::check_one, this, i));
            //check_one(i)
        } 
        for(auto& f : futs)
            right += f.get();
        
        return right / N;
    } 
};

int main(int argc, char* argv[]){
    std::ifstream data(argv[2]);

    NaiveBayes nb(2304);
    size_t loaded = nb.load_train(data);
    std::cerr << "loaded " << loaded << " examples" << std::endl;
    if(std::string(argv[1]) == "validate"){
        for(int i = 1; i < 100; i ++){
            float right = 0;
            const size_t step = 5000;
            for(int j = 0; j < 50000; j += step){
                nb.train(i, j, j + step);
                right += nb.validate(j, j + step);
            }
            std::cout << i << "," << (right / 10.0) << std::endl;
        }
    }
    else if(std::string(argv[1]) == "test"){
        std::ifstream test(argv[3]);
        loaded = nb.load_test(test);
        std::cerr << "loaded " << loaded << " test examples" << std::endl;
        nb.train(20,0,0);
        nb.test();
    }
    else{
        std::cout << "invalid option" << std::endl;
        return 2;
    }
    return 0;
}
