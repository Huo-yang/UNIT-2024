__kernel void Add1D(
    __global const float *a, 
    __global const float *b,
    __global float *reasult)
{
    int gid = get_global_id(0);
    reasult[gid] = a[gid] + b[gid];
}

__kernel void Add2D(
    __global const float *a, 
    __global const float *b,
    int width,
    __global float *reasult)
{
    int row = get_global_id(0);
    int col = get_global_id(1);
    reasult[col * width + row] = a[col * width + row] + b[col * width + row];
}

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

    vector_out[out_index] = 0;

    for (i = 0; i < in_channel; i++)
    {
        for (j = 0; j < kernel_size; j++)
        {
            vector_out[out_index] += vector_in[i * in_col + out_col_index * stride + j] * filter_weight[filter_weight_head + i * kernel_size + j];
        }
    }

    vector_out[out_index] += bias[out_channel_index];
}

__kernel void BatchNorm1D2DIM(
    __global const float* vector_in,
    __global const float* mean,
    __global const float* var,
    __global const float* gamma,
    __global const float* beta,
    __global float* vector_out)
{
    int channel_index = get_global_id(0);
    int col_index = get_global_id(1);
    int col_size = get_global_size(1);

    vector_out[channel_index * col_size + col_index] = gamma[channel_index] * (vector_in[channel_index * col_size + col_index] - mean[channel_index]) / sqrt(var[channel_index] + 1e-5) + beta[channel_index];
}

__kernel void BatchNorm1D1DIM(
    __global const float* vector_in,
    __global const float* mean,
    __global const float* var,
    __global const float* gamma,
    __global const float* beta,
    __global float* vector_out)
{
    int channel_index = get_global_id(0);

    vector_out[channel_index] = gamma[channel_index] * (vector_in[channel_index] - mean[channel_index]) / sqrt(var[channel_index] + 1e-5) + beta[channel_index];
}

__kernel void ReLU(__global const float* vector_in,
                    __global float* vector_out)
{
    int vector_index = get_global_id(0);
    float result = (vector_in[vector_index] > 0) ? vector_in[vector_index] : 0;
    vector_out[vector_index] = result;
}

__kernel void SELU(__global const float* vector_in,
                  __global float* vector_out)
{
    int vector_index = get_global_id(0);
    float alpha = 1.6732632423543772848170429916717;
    float scale = 1.0507009873554804934193349852946;

    float inner_exp = vector_in[vector_index] * alpha;
    float exp_result = exp(inner_exp);
    float max_value = max(0.0f, vector_in[vector_index]);
    float min_value = min(0.0f, (exp_result - 1.0f) * alpha);

    vector_out[vector_index] = scale * (max_value + min_value);
}

__kernel void FC(__global const float* vector_in,
                    __global const float* weight,
                    __global const float* bias,
                    const int vector_in_col,
                    __global float* vector_out)
{
    int vector_out_index = get_global_id(0); // 输出的index
    int i;
    
    vector_out[vector_out_index] = 0;
    for(i = 0; i < vector_in_col; i++)
    {
        vector_out[vector_out_index] += vector_in[i] * weight[i + vector_in_col * vector_out_index];
    }
    vector_out[vector_out_index] += bias[vector_out_index];
}

__kernel void Linear(__global const short* vector_in,
                    const int offset,
                    const int inset_times,
                    __global short* vector_out)
{
    int vector_out_group = get_global_id(0); // 输出的index
    int i;
    int x0 = vector_out_group + offset;
    int x1 = vector_out_group + offset + 1;
    float result = 0;
    vector_out[vector_out_group * inset_times] = vector_in[x0];
    for(i = 1; i < inset_times; i++)
    {
        result = vector_in[x0] + ((float)(vector_in[x1] - vector_in[x0])) * (((float)i) / ((float)inset_times));
        vector_out[vector_out_group * inset_times + i] = (short)result;
    }
}

__kernel void Sinc(__global const short* vector_in,
                    const int count_num,
                    const int inset_times,
                    __global short* vector_out)
{
    int vector_out_index = get_global_id(0); // 输出的index
    int i;
    float sinc_result = 0;
    float result = 0;
    for(i = 0; i < count_num; i++)
    {
        float det_x;
        det_x = (count_num / 2 - 1) - i + ((float)(vector_out_index % inset_times)) / ((float)inset_times);
        if(det_x == 0) sinc_result = 1;
        else sinc_result = sin(M_PI*det_x) / (M_PI * det_x);
        result += ((float)vector_in[i + vector_out_index / inset_times]) * sinc_result;
    }
    vector_out[vector_out_index] = (short)result;
}