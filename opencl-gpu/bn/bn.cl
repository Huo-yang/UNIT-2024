__kernel void BatchNorm1D(
    __global const float* input,
    __global float* output,
    __global const float* scale,
    __global const float* shift,
    int batch_size,
    int channel_size,
    int width,
    __global const float* running_mean,
    __global const float* running_var,
    float epsilon)
{
    int idx = get_global_id(0);
    int channel_idx = idx / width;
    int width_idx = idx % width;

    float x = input[idx];
    float mu = running_mean[channel_idx];
    float sigma = sqrt(running_var[channel_idx] + epsilon);

    float norm = (x - mu) / sigma;
    output[idx] = norm * scale[channel_idx] + shift[channel_idx];
}