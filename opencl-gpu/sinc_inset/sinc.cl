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