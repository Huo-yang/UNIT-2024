// __kernel void Conv1D(__global const float* vector_in,
//                     __global const float* filter_weight,
//                     __global const float* bias,
//                     int in_channel,
//                     int in_col,
//                     int kernel_size,
//                     __global float* vector_out)
// {
//     int out_channel_index = get_global_id(0);
//     int out_col_index = get_global_id(1);
//     int out_col = get_global_size(1);
//     int i; // in_channel range
//     int j; // kernel range
//     int filter_weight_head = in_channel * kernel_size * out_channel_index;
//     int out_index = out_channel_index * out_col + out_col_index;
//     for(i=0; i<in_channel; i++)
//     {
//         for(j=0; j<kernel_size; j++)
//         {
//             vector_out[out_index] += vector_in[i * in_col + out_col_index + j] * filter_weight[filter_weight_head + i * kernel_size + j];
//         }
//     }
//     vector_out[out_index] += bias[out_channel_index];
// }

__kernel void Conv1D(
    __global const float* vector_in,
    __global const float* filter_weight,
    __global const float* bias,
    int in_channel,
    int in_col,
    int kernel_size,
    int stride,  // 添加了stride参数
    __global float* vector_out)
{
    int out_channel_index = get_global_id(0);
    int out_col_index = get_global_id(1);
    int out_col = get_global_size(1);

    int i; // in_channel range
    int j; // kernel range

    int filter_weight_head = in_channel * kernel_size * out_channel_index;
    int out_index = out_channel_index * out_col + out_col_index;

    for (i = 0; i < in_channel; i++)
    {
        for (j = 0; j < kernel_size; j++)
        {
            vector_out[out_index] += vector_in[i * in_col + out_col_index * stride + j] * filter_weight[filter_weight_head + i * kernel_size + j];
        }
    }

    vector_out[out_index] += bias[out_channel_index];
}