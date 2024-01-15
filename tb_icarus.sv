`define FULL_RANDOM
`define DO_TRACE
`define NUM_SUBNETS 1
`define NUM_CLKIN_NETS 0
`define NO_CLKIN_NET

module testbench;

  bit [31:0] in_data_words    [96 / 32];
  bit [31:0] out_data_words   [96 / 32];

  int fd;
  int in_buf;

  int next_actor_id;
  int next_random_input;
  int num_32bit_inputs;

  bit [63:0] cumulated_output;

  bit [96-1:0]  in_data;
  bit [96-1:0] out_data;
  top dut(in_data, out_data);

  always_comb begin
    for (int in_word_id = 0; in_word_id < 96 / 32; in_word_id++) begin
      in_data[32*in_word_id +: 32] = in_data_words[in_word_id];
    end
    for (int out_word_id = 0; out_word_id < 96 / 32; out_word_id++) begin
      out_data_words[out_word_id] = out_data[32*out_word_id +: 32];
    end
  end

  // Stimulus generation
  initial begin
      cumulated_output = 0;

  `ifdef DO_TRACE
      $dumpfile("icarus_dump.vcd");
      $dumpvars(0,dut);
  `endif

      in_data_words[0] = 32'h5f134518;
      in_data_words[1] = 32'h2bdaee79;
      in_data_words[2] = 32'h365282a5;
      #1;

      // Cumulate the outputs
      for (int word_id = 0; word_id < 96 / 32; word_id++) begin
        cumulated_output += out_data_words[word_id];
      end
    $display("Output signature: %d.", cumulated_output);
  end
endmodule
