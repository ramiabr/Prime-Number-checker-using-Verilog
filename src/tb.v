module tb;
	// input_no, clock, reset_n, input_valid, result_ready, is_prime	
	
	reg [9:0] input_no;
	reg clock, reset_n, input_valid; 
	wire result_ready, is_prime; 
	wire [10:0] i;
	reg is_prime_result;
	reg [31:0] j;
	
	prime x1 (input_no, clock, reset_n, input_valid, result_ready, is_prime);
	
	
	always 
		# 2 clock = ~ clock;
	
	
	initial begin 
		clock = 0; reset_n = 1; input_valid = 0; input_no = 0;
		
		# 3
		reset_n = 0;
		
		#4
		reset_n = 1;
		
		
		#1
		while(input_no <= 1022) begin 
			input_valid = 1;
			
			#4
			input_valid = 0;
			
			j = input_no * 4;
			
			#j
			input_no = input_no + 1;
		end
		
		#1
		input_valid = 1; 
		
		#4
		input_valid = 0;
		
		
		
		#1024
		$finish;
	end

	// Response Checker 
	always @ (posedge result_ready) begin 
		#2
		is_prime_result = check_prime(input_no);
		
		if(is_prime != is_prime_result)
			$display("Input: %d, FAIL, Hardware: %b, Function: %b", input_no, is_prime, is_prime_result);
			//$display("%d, %b, %b, FAIL", input_no, is_prime, is_prime_result);
		else 
			$display("Input: %d, PASS, Hardware: %b, Function: %b", input_no, is_prime, is_prime_result);
			//$display("%d, %b, %b, PASS", input_no, is_prime, is_prime_result);		
	
	end


	function check_prime; 
		input [9:0] no; 
		reg [31:0] i;
		reg done;
		
		begin 
			done = 1;
			
			if(no <= 1) 
				check_prime = 0;
			else if(no == 2 || no == 3)
				check_prime = 1;
			else if(no % 2 == 0 || no % 3 == 0) 
				check_prime = 0;
			else 
				done = 0;
					
			i = 5; 
			
			while(i*i <= no) begin 
				if(no % i == 0 || no % (i+2) == 0)  begin 
					check_prime = 0;
					done = 1;
				end
				
				i = i + 6;			
			end
			if(done == 0) 
				check_prime = 1;
		end
	endfunction
endmodule
