`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2023 10:27:35 PM
// Design Name: 
// Module Name: crank_cam_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module crank_cam_sim #(
    parameter integer DATA_WIDTH  = 32,
    parameter integer CRANK_TEETH = 58,
    parameter integer CRANK_TEETH_TOTAL = 60,
    parameter integer CAM_OFFSET = 2
)
(
    input wire rst,
    input wire clk,
    input wire [DATA_WIDTH-1:0] rpm,
    input wire enable,
    output reg crank,
    output reg cam
    );
    
    
    reg[DATA_WIDTH-1:0] prescaler;
    integer tooth_cnt;
    always @(posedge clk)begin 
    if (rst || !enable) begin
        prescaler <= 0;
        tooth_cnt <= 0;
        cam <= 0;
        crank <= 0;
        end
    else begin
        if(prescaler > 0)
            prescaler <= prescaler -1;
        else begin
            prescaler <= rpm;
            if(tooth_cnt < (CRANK_TEETH*2)) begin
                crank <= ~crank;    
                end
            else if(tooth_cnt >= (CRANK_TEETH_TOTAL*2))
                tooth_cnt <= 0;
            end
            if(tooth_cnt ==  CAM_OFFSET)
                cam <= 1;
            else
                cam <= 0;
    end
    end



endmodule
