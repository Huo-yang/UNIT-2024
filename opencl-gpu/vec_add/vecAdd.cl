__kernel void Add1D(global const float *a, 
                        global const float *b,
                        global float *reasult)
                        {
                            int gid = get_global_id(0);
                            reasult[gid] = a[gid] + b[gid];
                        }

__kernel void Add2D(__global const float *a, 
                    __global const float *b,
                    __global float *reasult)
                        {
                            int row = get_global_id(0);
                            int col = get_global_id(1);
                            int col_size = get_global_size(1);
                            reasult[row * col_size + col] = a[row * col_size + col] + b[row * col_size + col];
                        }