# UVM-based-Asynchronous-FIFO-verification-platform-design
### Structure
![structure](https://user-images.githubusercontent.com/71707557/183389925-0d69c33a-2d4b-40f9-ab6b-bc0768cb8edf.png)

### UVM testbench topology
------------------------------------------------------------------
Name                       Type                        Size  Value
------------------------------------------------------------------
uvm_test_top               my_case2                    -     @458 
  env                      my_env                      -     @476 
    agt_mdl_fifo           uvm_tlm_analysis_fifo #(T)  -     @696 
      analysis_export      uvm_analysis_imp            -     @740 
      get_ap               uvm_analysis_port           -     @731 
      get_peek_export      uvm_get_peek_imp            -     @713 
      put_ap               uvm_analysis_port           -     @722 
      put_export           uvm_put_imp                 -     @704 
    agt_scb_fifo           uvm_tlm_analysis_fifo #(T)  -     @643 
      analysis_export      uvm_analysis_imp            -     @687 
      get_ap               uvm_analysis_port           -     @678 
      get_peek_export      uvm_get_peek_imp            -     @660 
      put_ap               uvm_analysis_port           -     @669 
      put_export           uvm_put_imp                 -     @651 
    i_agt                  write_fifo_agent            -     @488 
      drv                  write_fifo_driver           -     @929 
        rsp_port           uvm_analysis_port           -     @946 
        seq_item_port      uvm_seq_item_pull_port      -     @937 
      mon                  write_fifo_monitor          -     @955 
        ap                 uvm_analysis_port           -     @965 
      sqr                  write_fifo_sequencer        -     @806 
        rsp_export         uvm_analysis_export         -     @814 
        seq_item_export    uvm_seq_item_pull_imp       -     @920 
        arbitration_queue  array                       0     -    
        lock_queue         array                       0     -    
        num_last_reqs      integral                    32    'd1  
        num_last_rsps      integral                    32    'd1  
    m_vseqr                my_virtual_sequencer        -     @520 
      rsp_export           uvm_analysis_export         -     @528 
      seq_item_export      uvm_seq_item_pull_imp       -     @634 
      arbitration_queue    array                       0     -    
      lock_queue           array                       0     -    
      num_last_reqs        integral                    32    'd1  
      num_last_rsps        integral                    32    'd1  
    mdl                    my_model                    -     @504 
      ap                   uvm_analysis_port           -     @993 
      port                 uvm_blocking_get_port       -     @984 
    mdl_scb_fifo           uvm_tlm_analysis_fifo #(T)  -     @749 
      analysis_export      uvm_analysis_imp            -     @793 
      get_ap               uvm_analysis_port           -     @784 
      get_peek_export      uvm_get_peek_imp            -     @766 
      put_ap               uvm_analysis_port           -     @775 
      put_export           uvm_put_imp                 -     @757 
    o_agt                  read_fifo_agent             -     @496 
      drv                  read_fifo_driver            -     @1137
        rsp_port           uvm_analysis_port           -     @1154
        seq_item_port      uvm_seq_item_pull_port      -     @1145
      mon                  read_fifo_monitor           -     @1129
        ap                 uvm_analysis_port           -     @1165
      sqr                  read_fifo_sequencer         -     @1006
        rsp_export         uvm_analysis_export         -     @1014
        seq_item_export    uvm_seq_item_pull_imp       -     @1120
        arbitration_queue  array                       0     -    
        lock_queue         array                       0     -    
        num_last_reqs      integral                    32    'd1  
        num_last_rsps      integral                    32    'd1  
    scb                    my_scoreboard               -     @512 
      act_port             uvm_blocking_get_port       -     @1188
      exp_port             uvm_blocking_get_port       -     @1179
------------------------------------------------------------------
