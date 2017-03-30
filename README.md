                              Verilog Module to check if given number is Prime
                              
                              
The module has 4 inputs, clock should be connected with clock signal. Input_no[9:0] is the number checked for prime, whenever input_no contains valid data input_valid should be triggered high for one clock cycle. Once the state machine changes its state from reset to test data any changes to input_no or input_valid will not processed until result_ready goes high, because that’s when the prime module has completed computation and ready to take next data. When reset_n signal is going low the whole module is set to reset state of the state machine. The output will be ready in second clock cycle or input_no * input_no clock cycles. Whenever the output contains valid data the result_ready goes high.