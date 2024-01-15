module top(in_data, out_data);
  bit celloutsig_10z;
  bit [3:0] celloutsig_1z;
  bit [5:0] celloutsig_2z;
  bit celloutsig_5z;
  bit celloutsig_6z;
  bit celloutsig_7z;
  input [95:0] in_data;
  bit [95:0] in_data;
  output [95:0] out_data;
  bit [95:0] out_data;
  assign celloutsig_5z = ~(celloutsig_1z[3] & in_data[67]);
  assign celloutsig_6z = ~(in_data[86] & celloutsig_5z);
  assign celloutsig_7z = ~(celloutsig_6z);
  assign celloutsig_10z = in_data[3] & ~(celloutsig_7z);
  assign celloutsig_2z = ~ { in_data[43:42], celloutsig_1z };
  assign celloutsig_1z = in_data[18:15] ^ { in_data[42:40], 1'b1 };
  assign out_data[0] = celloutsig_10z;
endmodule
