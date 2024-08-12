__kernel void ReLU(__global const float* vector_in,
                    __global float* vector_out)
{
    int vector_index = get_global_id(0);
    float result = (vector_in[vector_index] > 0) ? vector_in[vector_index] : 0;
    vector_out[vector_index] = result;
}