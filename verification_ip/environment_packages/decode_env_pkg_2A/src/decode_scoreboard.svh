class decode_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(decode_scoreboard)
	
	`uvm_analysis_imp_decl(_expected_ae)	
	uvm_analysis_imp_expected_ae #(decode_out_transaction, decode_scoreboard) expected_analysis_export;
	
	`uvm_analysis_imp_decl(_actual_ae)
	uvm_analysis_imp_actual_ae #(decode_out_transaction, decode_scoreboard) actual_analysis_export;
	
	uvm_tlm_analysis_fifo #(decode_out_transaction) expected_analysis_fifo;
	
	int nothing_to_compare_against_count;
	int match_count;
	int mismatch_count;
	
	bit end_of_test_activity_check;
	int transaction_count;
	
	event entry_received;
	bit wait_for_scoreboard_empty;
	
	bit end_of_test_empty_check;
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
		
		expected_analysis_export = new("expected_analysis_export",this);
		actual_analysis_export = new("actual_analysis_export",this);
		expected_analysis_fifo = new("expected_analysis_fifo",this);
		
		nothing_to_compare_against_count = 0;
		match_count = 0;
		mismatch_count = 0;
		
		end_of_test_activity_check = 1;
		end_of_test_empty_check = 0;
		transaction_count = 0;
		
		wait_for_scoreboard_empty = 0 ;
	endfunction : new
	
	virtual function void write_expected_ae(input decode_out_transaction trans_expected);
		
		//super.write(trans_expected);
		
		transaction_count++;
		
		->entry_received;
		void'(expected_analysis_fifo.try_put(trans_expected));
	endfunction
	
	virtual function void write_actual_ae(input decode_out_transaction trans_actual);
		
		decode_out_transaction expected_transaction;
		
		//super.write_actual_ae(trans_actual);
		
		->entry_received;
		
		if( !(expected_analysis_fifo.try_get(expected_transaction)))
		begin : try_get_fail
			nothing_to_compare_against_count++;
			`uvm_error("Fifo is empty: couldn't get anything","");			
		end : try_get_fail
		else
		begin :try_get_pass
			
			if(trans_actual.compare(expected_transaction))
			begin : compare_pass
				match_count++;
				`uvm_info("correct predictioin matched ","",UVM_MEDIUM);
			end : compare_pass
			else
			begin : compare_fail
				mismatch_count++;
				`uvm_error("mismatch in DUT v/s predictor results","");
			end :compare_fail 
		end : try_get_pass
	endfunction
	
	virtual function void check_phase( uvm_phase phase );

		super.check_phase(phase);
		if( end_of_test_empty_check && expected_analysis_fifo.is_empty() == 0 )
			`uvm_error("fifo not empty at the end","");
			
		if( end_of_test_activity_check && transaction_count == 0)
			`uvm_error("no transactions fed into the fifo","");
			
		
		
	endfunction
	
	virtual task wait_for_scoreboard_drain();
		
		while(expected_analysis_fifo.is_empty() == 0)
		begin
			@entry_received;
		end
		
	endtask
	
	virtual function void phase_ready_to_end (uvm_phase phase);
		if(phase.get_name() == "run")
		begin
			if(wait_for_scoreboard_empty)
			begin
				phase.raise_objection(this, "waiting for scoreboard to finish the remaining transactions");
				fork
				begin
					wait_for_scoreboard_drain();
					phase.drop_objection(this, "dropping objection");
				end
				join_none
			end
		end
		
		
	endfunction
	
endclass