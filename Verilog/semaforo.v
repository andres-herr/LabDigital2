module semaforo(
    input  clk,
    input  reset,
    output reg [1:0] luz   // 2 bits: 00=verde, 01=amarillo, 10=rojo
);
    localparam verde    = 2'b00;
    localparam amarillo = 2'b01;
    localparam rojo     = 2'b10;

    reg [3:0] cont;
    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= verde;
            cont  <= 1;
        end
        else begin
            cont <= cont + 1;

            if (cont < 5) begin
                state <= verde;
            end
            else if (cont == 5) begin
                state <= amarillo;
            end
            else if (cont == 7) begin
                state <= rojo;
            end
            else if (cont == 11) begin
                state <= amarillo;
            end
            else if (cont == 13) begin
                state <= verde;
                cont<=1;
            end
        end
    end

    always @(*) begin
        luz = state;
    end

endmodule
