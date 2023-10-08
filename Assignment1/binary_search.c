#include <stdio.h>
float fp32_to_bf16(float x)                 
{
    float y = x;
    int *p = (int *) &y;
    unsigned int exp = *p & 0x7F800000;
    unsigned int man = *p & 0x007FFFFF;
    if (exp == 0 && man == 0)
        return x;
    if (exp == 0x7F800000)
        return x;
    float r = x;
    int *pr = (int *) &r;
    *pr &= 0xFF800000; 

    r /= 0x100;
    y = x + r;
    *p &= 0xFFFF0000;
    return y;
}

float binary_search(float low, float high, float target) {
    low = fp32_to_bf16(low);
    high = fp32_to_bf16(high);
    target = fp32_to_bf16(target);
    while (low <= high) {
        float mid = low + (high - low) / 2;
        if (mid == target) {
            return mid;
        }

        if (mid < target) {
            low = mid;
        }
        else {
            high = mid;
        }
    }
    return -1;
}

int main(){
    float test_case1_x= 0.1;
    float test_case1_ub = 10.0; 
    float test_case1_lb = 0.001;
    float test_case2_x= 100.0;
    float test_case2_ub = 256.0; 
    float test_case2_lb = 10.0;
    float test_case3_x= 0.563;
    float test_case3_ub = 1.0; 
    float test_case3_lb = 0.01;
    printf("%f\n",binary_search(test_case1_lb, test_case1_ub, test_case1_x));
    printf("%f\n",binary_search(test_case2_lb, test_case2_ub, test_case2_x));
    printf("%f\n",binary_search(test_case3_lb, test_case3_ub, test_case3_x));

    return 0;
}