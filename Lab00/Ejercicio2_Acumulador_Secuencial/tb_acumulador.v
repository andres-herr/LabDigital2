`timescale 1ns/1ns
`include "acumulador.v"

module tb_acumulador;

  reg        clk, reset, start, cancel;
  reg  [1:0] group;
  reg  [3:0] x;
  wire [5:0] acc;

  acumulador dut (
    .clk(clk),
    .start(start),
    .reset(reset),
    .cancel(cancel),
    .group(group),
    .x(x),
    .acc(acc)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("acumulador.vcd");
    $dumpvars(0, tb_acumulador);

    clk    = 0;
    reset  = 1;
    start  = 0;
    cancel = 0;
    group  = 2'b00;
    x      = 4'd0;

    #12 reset = 0;

    // ---- Caso 1: group=00 -> sumar x 3 veces ----
    x     = 4'd5;
    group = 2'b00;
    #10 start = 1;
    #10 start = 0;
    #60;

    // ---- Caso 2: group=01 -> sumar x 4 veces ----
    x     = 4'd3;
    group = 2'b01;
    #10 start = 1;
    #10 start = 0;
    #70;

    // ---- Caso 3: group=11 -> sumar hasta acc>=20 ----
    x     = 4'd7;
    group = 2'b11;
    #10 start = 1;
    #10 start = 0;
    #80;

    // ---- Caso 4: cancelar a mitad de la acumulacion ----
    x     = 4'd2;
    group = 2'b00;
    #10 start  = 1;
    #10 start  = 0;
    #15 cancel = 1; 
    #10 cancel = 0;
    #40;

    #20 $finish;
  end

endmodule