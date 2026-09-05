module semaforo(
    input  wire clk,
    input  wire reset, 
    input  wire integer c,
    output wire luz
);
    localparam verde = 2'b00;
    localparam amarillo = 2'b01;
    localparam rojo = 2'b10;

    reg [1:0] state;
    assign luz = 2'b00;

    always @(posedge clk) begin
        
        c=c+1;
        if (!reset && c<5) begin
            state <= verde; // Estado inicial por defecto
            luz=state;
        end 
        
        else if(c==5)
        
         begin
            state <= amarillo;
            luz=state;
         end
         else if (c==7)
         begin
            state <= rojo;
            luz=state;
         end
         else if (c==11)
         begin
            state <=amarillo;
            luz=state;
         end
         else if (c==13);
         begin
            c=0;
            state <=verde;
            luz=state;
         end
    end


endmodule
