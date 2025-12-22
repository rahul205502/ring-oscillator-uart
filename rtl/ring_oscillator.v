`timescale 1ns/1ps

module ring_oscillator( output op);
    
    wire [6:0]w;

    (* keep = "true" *) not (w[0],w[6]);
    (* keep = "true" *) not (w[1],w[0]);
    (* keep = "true" *) not (w[2],w[1]);
    (* keep = "true" *) not (w[3],w[2]);
    (* keep = "true" *) not (w[4],w[3]);
    (* keep = "true" *) not (w[5],w[4]);
    (* keep = "true" *) not (w[6],w[5]);
    assign op = w[6];
    
endmodule