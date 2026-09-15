module acumulador(
    input  clk,
    input  start,
    input  reset,
    input  cancel,
    input  [1:0] group,
    input  [3:0] x,
    output reg [5:0] acc
);
    reg [4:0] cont;
    reg [1:0] state; //idle=00 load=01 add=11 done=10
    localparam idle = 2'b00;
    localparam load = 2'b01;
    localparam add  = 2'b11;
    localparam done = 2'b10;

    always @(posedge clk) begin
        if (reset) begin
            state <= idle;
            cont  <= 0;
            acc   <= 0;
        end
        else begin
            if (state==idle && start && !cancel) begin
                state <= load;
            end
            else if (state==load && cancel) begin
                state <= idle;
            end
            else if (state==load && !cancel) begin
                acc   <= 0;
                cont  <= 0;
                state <= add;
            end
            else if (state==add && cancel) begin
                state <= idle;
            end
            else if (state==add && group==2'b00 && !cancel) begin //group=00 -> sumar 3 veces
                if (cont < 3) begin
                    acc  <= acc + x;
                    cont <= cont + 1;
                end
                else begin
                    state <= done;
                end
            end
            else if (state==add && group==2'b01 && !cancel) begin //group=01 -> sumar 4 veces
                if (cont < 4) begin
                    acc  <= acc + x;
                    cont <= cont + 1;
                end
                else begin
                    state <= done;
                end
            end
            else if (state==add && group==2'b11 && !cancel) begin //group=11 -> sumar hasta acc>=20
                if (acc < 20) begin
                    acc <= acc + x;
                end
                else begin
                    state <= done;
                end
            end
            else if (state==done) begin
                state <= idle;
            end
        end
    end
endmodule