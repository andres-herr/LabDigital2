`timescale 1ns/1ns
`include "semaforo.v"

module tb_semaforo;

  reg  clk, reset;
  wire [1:0] luz;

  semaforo dut (
    .clk(clk),
    .reset(reset),
    .luz(luz)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("semaforo.vcd");
    $dumpvars(0, tb_semaforo);

    clk   = 0;
    reset = 1;
    #400 $finish; 
  end

endmodule
