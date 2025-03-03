module Bus(
    input [31:0] select_signals,
    input [31:0] R0_data, R1_data, R2_data, R3_data, R4_data,
                 R5_data, R6_data, R7_data, R8_data, R9_data,
                 R10_data, R11_data, R12_data, R13_data, R14_data,
                 R15_data, HI_data, LO_data, MAR_data, MDR_data,
					  Z_data, PC_data,
					  
    output wire [31:0] BusMuxOut,
    output wire [4:0] encoded_signal
);

    Encoder32to5 encoder (.Data(select_signals), .signal(encoded_signal));

    Mux32to1 multiplexer (
        .I0(R0_data), .I1(R1_data), .I2(R2_data), .I3(R3_data), .I4(R4_data),
        .I5(R5_data), .I6(R6_data), .I7(R7_data), .I8(R8_data), .I9(R9_data),
        .I10(R10_data), .I11(R11_data), .I12(R12_data), .I13(R13_data), .I14(R14_data),
        .I15(R15_data), .I16(HI_data), .I17(LO_data), .I18(MAR_data), .I19(MDR_data),
        .I20(Z_data), .I21(Z_data), .I22(PC_data), .I23(32'd0), .I24(32'd0), .I25(32'd0), .I26(32'd0), .I27(32'd0),
        .I28(32'd0), .I29(32'd0), .I30(32'd0), .I31(32'd0),
        .signal(encoded_signal),
        .BusMuxOut(BusMuxOut)
    );

endmodule 