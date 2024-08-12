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