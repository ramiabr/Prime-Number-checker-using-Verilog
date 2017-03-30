
////////////////////////////////////////////////////////////////////////////////
//
// ABSTRACT :
// 	hardware to check if given number is prime number 
//
//	Input Ports   Size              Description
//      ===========   ====              ============
//	input_no 	10		Input number which needs to be tested 
//	clock		1		System clock 
//	reset_n		1		Active low reset 
//	input_valid	1		This signal goes high to indicate the valid bits in input_no 

//      Output Ports   Size              Description
//      ===========   ====              ============  	
// 	result_ready	1		Goes high when result is valid 
// 	is_prime	1		1 - given number is prime, 0 - given number is odd 
//
//
////////////////////////////////////////////////////////////////////////////////


module prime (input_no, clock, reset_n, input_valid, result_ready, is_prime); 

	parameter rst_state    = 'd0;
	parameter test_state   = 'd1;
	parameter result_state = 'd2;	
	
	parameter true  = 1; 
	parameter false = 0;
	
	// Ports
	input [9:0] input_no;
	input clock, reset_n, input_valid;
	
	output reg result_ready; 
	output reg is_prime;


	// Other variables required for the computation 
	reg [1:0] state;
	//output reg [10:0] i;
	reg [10:0] i;
	reg [9:0] no;
	
	
	
	// State Machine 
	always @ (posedge clock or negedge reset_n)  begin 
		// Reset state 
		if(! reset_n) begin 
			result_ready <= false;
			is_prime <= false;	
			state <= rst_state;
		end 
		// Still reset state, but determine if next state is going to be 
		else if(state == rst_state) begin 			
			result_ready <= false;
			is_prime <= false;	
			i = 5;
			
			// If input is valid go to testing state, otherwise stay in reset state 
			if(input_valid == 1) begin
				state <= test_state;
				no <= input_no;
			end
			else 
				state <= rst_state;
						
		end	
		else if(state == test_state) begin 
		
			// If number equal to 0 or 1, result is ready and input is not prime  
			if(no == 0 || no == 1) begin 
				result_ready <= true;
				is_prime <= false;
				state <= rst_state;			
			end

			// If number equal to 2 or 3, then result is ready and input is prime 							
			else if(no == 2 || no == 3) begin 
				result_ready <= true;
				is_prime <= true;			
				state <= rst_state;
			end							

			// If number % 2 or number % 3 ==0, then result is ready and can be output 			
			else if(no % 2 == 0 || no % 3 == 0) begin 
				result_ready <= true;
				is_prime <= false;	
				state <= rst_state;						
			end 
			
			// Else test dividing the number from i 
			else begin 
				if(i * i <= no) begin 
        				if(no % i == 0 || no % (i+2) == 0) begin 
        					result_ready <= true;
        					is_prime <= false;	
        					state <= rst_state;						
        				end
        				else begin 
        					state <= test_state;
        				end
				
					i = i + 6;
				end else begin 
					result_ready <= true; 
					is_prime <= true;
					state <= rst_state;				
				end
			end				
		end 
	end


endmodule 


