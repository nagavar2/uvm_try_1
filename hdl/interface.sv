import alu_pkg::*;
interface alu_bfm();

bit clk;
bit resetn;
bit [3:0] operandA;
bit [3:0] operandB;
bit [1:0] op;
bit [3:0] result;
bit done;

task reset_alu();
    resetn = 1'b0;
    @(posedge clk);
    @(posedge clk);
    resetn = 1'b1;
endtask

task send_op(input bit [3:0] A, input bit [3:0] B, input bit [1:0] opcode, output bit [3:0] res);
    @(posedge clk) begin
        operandA <= A;
        operandB <= B;
        op <= opcode;
        res <= result;
    end
endtask

passive_monitor passive_monitor_h;

/*function bit [1:0] check_op();
    case(op)
        2'b00: return 1;
        2'b01: return 1;
        2'b10: return 1;
        2'b11: return 1;
        default: return 0;
    endcase
endfunction */


always_ff@(posedge clk) begin
    passive_monitor_h.write_to_monitor(operandA,operandB,op);
   // if(done)
    //active_monitor_h.write_to_monitor(result,done);
end

active_monitor active_monitor_h;

initial begin
    forever begin
        @(posedge clk);
        if(done)
        active_monitor_h.write_to_monitor(result,done);
    end
end

initial begin
    clk = 0;
    fork
        forever begin
            #10;
            clk = ~clk;
        end
    join_none
end

endinterface