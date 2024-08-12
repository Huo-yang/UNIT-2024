__kernel void FC(__global const float* vector_in,
                    __global const float* weight,
                    __global const float* bias,
                    const int vector_in_col,
                    __global float* vector_out)
{
    int vector_out_index = get_global_id(0); // 输出的index
    int i;
    for(i = 0; i < vector_in_col; i++)
    {
        vector_out[vector_out_index] += vector_in[i] * weight[i + vector_in_col * vector_out_index];
    }
    vector_out[vector_out_index] += bias[vector_out_index];
}

// 1 * n  输入      m * n  权重              bias                   输出为 m                    (pytorch)
/*
0 1 2 3             0 6 12 18             0, 1, 2, 3, 4, 5          84, 91, 98, 105, 112, 119
                    1 7 13 19
                    2 8 14 20
                    3 9 15 21
                    4 10 16 22
                    5 11 17 23
*/