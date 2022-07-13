module alu (input bit clk,
            input bit resetn,
            input bit [3:0] operandA, operandB,
            input bit [1:0] op,
            output bit done,
            output bit [3:0] result);

    always_ff@(posedge clk) begin
        if (!resetn) begin
            result <= '0;
            done <= '0;
        end
        else begin
            unique case (op) 
            0: begin
                result <= operandA | operandB;
                done <= 1;
                end
            1: begin
                result <= operandA & operandB;
                done <= 1;
                end
            2: begin
                result <= operandA ^ operandB;
                done <= 1;
                end
            3: begin
                result <= '1;
                done <= 1;
                end
            endcase
        end
    end

endmodule