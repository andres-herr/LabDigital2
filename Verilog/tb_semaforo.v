`timescale 1ns/1ns
`include "semaforo.v"

module tb_semaforo;

  wire clk, reset, c, luz;

  // Instancia del DUT (Device Under Test)
  semaforo dut (
    .clk(clk),
    .reset(reset),
    .c(c),
    .luz(luz)
  );

  initial begin
    // Generación del archivo de ondas
    $dumpfile("semaforo.vcd");
    $dumpvars(0, tb_semaforo);
    clk=0;
    c=0;

    // Fin de simulación
    $finish;
  end
  always #5 clk = !clk;

endmodule
