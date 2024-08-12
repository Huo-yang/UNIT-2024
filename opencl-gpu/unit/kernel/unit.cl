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
    int stride,
    __global float* vector_out)
{
    int out_channel_index = get_global_id(0);
    int out_col_index = get_global_id(1);
    int out_col = get_global_size(1);
    int i;
    int j;
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
    int vector_out_index = get_global_id(0);
    int i;
    
    vector_out[vector_out_index] = 0;
    for(i = 0; i < vector_in_col; i++)
    {
        vector_out[vector_out_index] += vector_in[i] * weight[i + vector_in_col * vector_out_index];
    }
    vector_out[vector_out_index] += bias[vector_out_index];
}