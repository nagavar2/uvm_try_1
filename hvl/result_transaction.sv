import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class result_transaction extends uvm_transaction; 

    `uvm_object_utils(result_transaction);
    bit [3:0] result;
    bit done;

    virtual function string convert2string();
        string s="";
        s = $sformatf("%s Result:%h done:%h",s,result,done);
        return s;
    endfunction 

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
      result_transaction RHS;
      bit    same;
      assert(rhs != null) else
        $fatal(1,"Tried to copare null transaction");

      same = super.do_compare(rhs, comparer);

      $cast(RHS, rhs);
      same = (result == RHS.result) && same;
      return same;
   endfunction : do_compare

    function new (string name="");
        super.new(name);
    endfunction 

endclass