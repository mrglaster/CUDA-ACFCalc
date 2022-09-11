#include <iostream>
#include <cmath>
#include <fstream>
#include <ctime>

using namespace std;
void go_to_bins(int n, double* signal);
double find_premax(double* signal, int n);

double* acf_func_demo(double* signal, int n) {
    double* acf = new double[n];
    for (int i = 0; i < n; i++) {
        int k = 0;
        acf[i] = 0.0;
        for (int j = 0; j < n; j++) {
            if (i + j < n) {
                k++;
                acf[i] += signal[i + j] * signal[j];

            }
        }
    }
    return acf;
    delete[] acf;
}


int main() {
    int time = clock(), times = time;
    times = clock() - time;
    ofstream fw("calc_results1.txt", std::ofstream::out);

    //Maximum signal length
    int end = 14;

    //Enumeration of signal lengths
    for (int j = 5; j < end; j++) {
        
        //min_acf[0] - signal, min_acf[1] - ACF value
        int min_acf[2] = { 0, 9999999 };
        
        int size = j;
        double* signal = new double[size];
        int now_acf;
        int l1 = pow(2, size);
        int l0 = pow(2, size - 1);
        for (int i = l0; i < l1; i++) {
            go_to_bins(i, signal);

            double* acf = acf_func_demo(signal, size);
            now_acf = find_premax(acf, size);
            if (min_acf[1] >= now_acf) {
                min_acf[1] = now_acf;
                min_acf[0] = i;
            }
            delete[] acf;
        }


        times = clock() - time;


        fw << "signal = " << min_acf[0] << " size = " << size << " acf = " << min_acf[1] << " time = " << times << "ms\n";
        delete[] signal;
    }
    
    
    
}

void go_to_bins(int n, double* signal) {
    int size = int(log2(n)) + 1;
    for (int i = 0; i < size; i++) {
        signal[i] = n >> i & 1;
        if (signal[i] == 0)
            signal[i] = -1;
    }
}


double find_premax(double* signal, int n) {
    int temp = 0;
    int curmax = 0;
    for (int i = 0; i < n; i++) {
        if (abs(signal[i]) >= curmax) {
            temp = curmax;
            curmax = abs(signal[i]);
        }
        if (abs(signal[i]) > temp && abs(signal[i]) < curmax) temp = abs(signal[i]);
    }
    return temp;
}