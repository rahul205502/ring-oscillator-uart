`timescale 1ns/1ps

module ring_oscillator(input en, output op);
    
    (* KEEP = "true", DONT_TOUCH = "true" *)
    wire [6:0] w;
            
//    (* KEEP = "true", DONT_TOUCH = "true" *)
//    LUT1 #(.INIT(2'b01)) inv0 (.I0(fb), .O(w0));
//    (* KEEP = "true", DONT_TOUCH = "true" *)
//    LUT1 #(.INIT(2'b01)) inv1 (.I0(w0), .O(w1));
//    (* KEEP = "true", DONT_TOUCH = "true" *)
//    LUT1 #(.INIT(2'b01)) inv2 (.I0(w1), .O(w2));
//    (* KEEP = "true", DONT_TOUCH = "true" *)
//    LUT1 #(.INIT(2'b01)) inv3 (.I0(w2), .O(w3));
//    (* KEEP = "true", DONT_TOUCH = "true" *)
//    LUT1 #(.INIT(2'b01)) inv4 (.I0(w3), .O(w4));
//    (* KEEP = "true", DONT_TOUCH = "true" *)
//    LUT1 #(.INIT(2'b01)) inv5 (.I0(w4), .O(w5));
//    (* KEEP = "true", DONT_TOUCH = "true" *)
//    LUT1 #(.INIT(2'b01)) inv6 (.I0(w5), .O(w6));

    assign w[0] = (en) ? ~w[6] : 1'b0;
    assign w[1] = ~w[0];
    assign w[2] = ~w[1];
    assign w[3] = ~w[2];
    assign w[4] = ~w[3];
    assign w[5] = ~w[4];
    assign w[6] = ~w[5];
    
    assign op = w[6];
    
endmodule
