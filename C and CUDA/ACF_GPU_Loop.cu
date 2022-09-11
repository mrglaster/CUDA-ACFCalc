#include <cstdio>
#include <cinttypes>
#include <chrono>
#include <bitset>


#define SIGNAL_LENGTH_MIN 5
#define SIGNAL_LENGTH_MAX 64


__global__ void calculate_acf(uint64_t start_offset, uint64_t end, uint64_t *min_result_sidelobe_amp, uint64_t *result_signal, uint64_t n) {
    
    // Variable initialization
    __shared__ int8_t acf_container[SIGNAL_LENGTH_MAX];
    __shared__ uint8_t signal_binary[SIGNAL_LENGTH_MAX];
    __shared__ uint64_t result_sidelobe_amp;

    // Shift by signal
    size_t idx = threadIdx.x; 

    // Decimal Signal
    uint64_t signal_decimal = blockIdx.x + start_offset; 

    while (signal_decimal <= end) {
        
        // Resetting the amplitude and splitting the signal into bits
        result_sidelobe_amp = 0;
        signal_binary[n - idx - 1] = (signal_decimal >> idx) & 1; //0 -> -1
        __syncthreads();

        // Start of ACF calculation for each shift
        int8_t temp = 0;
   
        //We turn the signal from the form {0;1} into {-1;1} and calculate the ACF
        for (size_t i = 0; i < n - idx; i++)  temp += (signal_binary[i + idx]*2-1) * (signal_binary[i]*2-1);
        
  
        // Taking the ACF modulo
		    if(temp<0) temp*=(-1);
        acf_container[idx] = temp;

        //Sidelobe amplitude calculation
        if (idx != 0) atomicMax(reinterpret_cast<unsigned long long int*>(&result_sidelobe_amp), (unsigned long long)acf_container[idx]);
        __syncthreads();

        // Checking if the available sidesheet amplitude is the best
        if (idx == 0) {
          uint64_t old = atomicMin(reinterpret_cast<unsigned long long int*>(min_result_sidelobe_amp), (unsigned long long)result_sidelobe_amp);
          if (old >= result_sidelobe_amp) {
              *result_signal = signal_decimal;
          }
        }
        signal_decimal += gridDim.x;
        __syncthreads();
    }
}


int is_goodlen(int n){
    if(n<SIGNAL_LENGTH_MIN || n>=SIGNAL_LENGTH_MAX){ 
        printf("Wrong signal length!"); 
        return 0;
    } 
    return 1;
}


uint64_t get_start_byblen(int n) {
	return 1ULL << (n - 1);
}


uint64_t get_end_byblen(int n) {
	return (1ULL << n) - 1ULL;
}

int main() {
    
    //Creation and initial design of the .dat file
    ofstream result_file;
    result_file.open("signal_acf_calculation_results.dat",  std::ios_base::app);
    result_file<<"Signal Length"<<TM_SPACES<<"Signal"<<TM_SPACES<<"Signal Dec"<<TM_SPACES<<"ACF"<<TM_SPACES<<"Calculation time (mks)"<<'\n';

    int n;
    result_file.close();
    for(n=SIGNAL_LENGTH_MIN; n<SIGNAL_LENGTH_MAX; n++){
      result_file.open("signal_acf_calculation_results.dat",  std::ios_base::app);
      auto start_time = std::chrono::high_resolution_clock::now();
       if(n<10) result_file<<"       ";
       else result_file<<"      ";
       result_file<<n<<"               ";

        //Variable initialization
        uint64_t *gpu_temporary_sidelobe_amp;
        uint64_t *gpu_temporary_result_signal;
        uint64_t end = get_end_byblen(n);
        uint64_t start = get_start_byblen(n);
        uint64_t result_sidelobe_amp;
        uint64_t result_signal;

        //Allocate memory
        cudaMalloc((void**)&gpu_temporary_sidelobe_amp, sizeof(uint64_t));
        cudaMalloc((void**)&gpu_temporary_result_signal, sizeof(uint64_t));
        cudaMemset(gpu_temporary_sidelobe_amp, 0xFF, sizeof(uint64_t));

        //We calculate the best ACF for a signal of length n   
        calculate_acf<<<3071, n>>>(start, end, gpu_temporary_sidelobe_amp, gpu_temporary_result_signal, n);

        //We transfer data from the GPU to the CPU for further work
        cudaMemcpy(&result_sidelobe_amp, gpu_temporary_sidelobe_amp, sizeof(uint64_t), cudaMemcpyDeviceToHost);
        cudaMemcpy(&result_signal, gpu_temporary_result_signal, sizeof(uint64_t), cudaMemcpyDeviceToHost);

        //Preparing data for output and output itself
        std::bitset<SIGNAL_LENGTH_MAX> s(result_signal);
        auto end_time = std::chrono::high_resolution_clock::now();
        result_file<<s.to_string().c_str()<<"               "<<result_signal<<"                                             "<<result_sidelobe_amp<<"                                                  "<<(double)(std::chrono::duration_cast<std::chrono::microseconds>(end_time - start_time).count())<<'\n';
        result_file.close();
    }
    
    printf("Calculations done!");
    return 0;
}