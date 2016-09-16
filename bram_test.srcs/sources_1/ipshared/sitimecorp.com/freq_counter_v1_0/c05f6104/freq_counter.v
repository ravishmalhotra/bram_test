`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2016 04:59:38 PM
// Design Name: 
// Module Name: freq_counter
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

 `define MEAS_COUNTER_VALUE   32'h1D4C0 // 120K CYCLES
 `define TIMEOUT_COUNTER_VALUE   32'h30D40 //200K CYCLES

//`define MEAS_COUNTER_VALUE   32'hF // 120K CYCLES. Based on Clk to be measured
 //`define TIMEOUT_COUNTER_VALUE   32'hFF //200K CYCLES. Based on REF CLK


module freq_counter(
   ref_clk, //Reference clock for measuring frequency 
   meas_clk1, meas_clk2, meas_clk3, meas_clk4, meas_clk5, meas_clk6, meas_clk7, meas_clk8, //The clock that needs to be measured
   en_counter,     //Enable signal for Clk measurements
   reset_counter,  //Reset the counter
   
     
   //doutb, //BRAM dout. Will be input for the freq counter block
   dinb, //BRAM din. Will be output for the freq counter block
   addrb, //BRAM Address to which counter data will be written
   web, //BRAM write enable. The signal to enable writing 
   enb, //Enable BRAM block. 
   rstb, //BRAM reset to initial value specified in the BRAM GUI 
   data_transfer_status //Frequency transfer data status
   );
     
     

     
   output [31:0] dinb;
   output [31:0] addrb; 
   output [3:0]web; 
   output enb;
   output rstb;
   output data_transfer_status;
   input ref_clk, meas_clk1, meas_clk2, meas_clk3, meas_clk4, meas_clk5, meas_clk6, meas_clk7, meas_clk8, 
   en_counter, reset_counter;
   //input doutb[31:0];
   
  
  reg enb;
  reg rstb;
  
  reg[31:0] addrb;
  reg[3:0] web;
  reg[31:0] dinb;
  
  
  reg[31:0] counter_ref1;
  
  reg[31:0] countermeas_clk1;
  reg[31:0] countermeas_clk2;
  reg[31:0] countermeas_clk3;
  reg[31:0] countermeas_clk4;
  reg[31:0] countermeas_clk5;
  reg[31:0] countermeas_clk6;
  reg[31:0] countermeas_clk7;
  reg[31:0] countermeas_clk8; 
  
  reg[31:0] data_ref_ch1;
  reg[31:0] data_ref_ch2;
  reg[31:0] data_ref_ch3;
  reg[31:0] data_ref_ch4;
  reg[31:0] data_ref_ch5;
  reg[31:0] data_ref_ch6;
  reg[31:0] data_ref_ch7;
  reg[31:0] data_ref_ch8;
    
    
  reg[31:0] data_meas_ch1;
  reg[31:0] data_meas_ch2;
  reg[31:0] data_meas_ch3;
  reg[31:0] data_meas_ch4;
  reg[31:0] data_meas_ch5;
  reg[31:0] data_meas_ch6;
  reg[31:0] data_meas_ch7;
  reg[31:0] data_meas_ch8;
    
  reg data_ch1_done;
  reg data_ch2_done;
  reg data_ch3_done;
  reg data_ch4_done;
  reg data_ch5_done;
  reg data_ch6_done;
  reg data_ch7_done;
  reg data_ch8_done;
    
  reg data_ready;
    
  reg[5:0] data_transfer_counter;
  reg data_transfer_status;
  
  /* always@(reset_counter==1)
     begin
     countermeas_clk1<=0;
     countermeas_clk2<=0;
     countermeas_clk3<=0;
     countermeas_clk4<=0;
     countermeas_clk5<=0;
     countermeas_clk6<=0;
     countermeas_clk7<=0;
     countermeas_clk8<=0; 
   end*/
    
   always @(posedge ref_clk)  
   
   begin 
     if (reset_counter==1)  
     begin 
           
     
       web<=4'b000;
       enb<=0;
       rstb<=0;
       addrb<=32'h0;
       dinb<=0;
       counter_ref1<=32'b0;
       
       
        data_ref_ch1<=32'b0;
        data_ref_ch2<=32'b0;
        data_ref_ch3<=32'b0;
        data_ref_ch4<=32'b0;
        data_ref_ch5<=32'b0;
        data_ref_ch6<=32'b0;
        data_ref_ch7<=32'b0;
        data_ref_ch8<=32'b0;
        
        data_meas_ch1<=32'b0;
        data_meas_ch2<=32'b0;
        data_meas_ch3<=32'b0;
        data_meas_ch4<=32'b0;
        data_meas_ch5<=32'b0;
        data_meas_ch6<=32'b0;
        data_meas_ch7<=32'b0;
        data_meas_ch8<=32'b0;
          
        data_ch1_done<=0;
        data_ch2_done<=0;
        data_ch3_done<=0;
        data_ch4_done<=0;
        data_ch5_done<=0;
        data_ch6_done<=0;
        data_ch7_done<=0;
        data_ch8_done<=0;
          
        data_ready<=0;
          
        data_transfer_counter<=6'h0;
        data_transfer_status<=0;
          
     end 
     
     else if (en_counter && reset_counter!=1)
     begin 
       counter_ref1<=counter_ref1+1;
       data_ready<=(data_ch1_done&&data_ch2_done&&data_ch3_done&&data_ch4_done&&data_ch5_done&&data_ch6_done&&data_ch7_done&&data_ch8_done);
       
       if ((countermeas_clk1==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)&&(data_ch1_done!=1))
       begin
         data_ref_ch1<=counter_ref1;
         data_meas_ch1<=countermeas_clk1;
         data_ch1_done<=1;  
        end 
      
       
       if ((countermeas_clk2==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE) &&(data_ch2_done!=1))
       begin
          data_ref_ch2<=counter_ref1;
          data_meas_ch2<=countermeas_clk2;
          data_ch2_done<=1;  
        end 
      
       if ((countermeas_clk3==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE) &&(data_ch3_done!=1))
          begin
            data_ref_ch3<=counter_ref1;
            data_meas_ch3<=countermeas_clk3;
            data_ch3_done<=1;  
        end 
       
       
      
        if ((countermeas_clk4==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)&&(data_ch4_done!=1))
          begin
            data_ref_ch4<=counter_ref1;
            data_meas_ch4<=countermeas_clk4;
            data_ch4_done<=1;  
        end 
       
       
       
         if ((countermeas_clk5==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)&&(data_ch5_done!=1))
         begin
           data_ref_ch5=counter_ref1;
           data_meas_ch5<=countermeas_clk5;
           data_ch5_done<=1;  
         end 
              
      
         if ((countermeas_clk6==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)&&(data_ch6_done!=1))
         begin
           data_ref_ch6<=counter_ref1;
           data_meas_ch6<=countermeas_clk6;
           data_ch6_done<=1;  
         end 
              
         if ((countermeas_clk7==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)&&(data_ch7_done!=1))
          begin
            data_ref_ch7<=counter_ref1;
            data_meas_ch7<=countermeas_clk7;
            data_ch7_done<=1;  
          end 
              
       
          if ((countermeas_clk8==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)&&(data_ch8_done!=1))
          begin
            data_ref_ch8<=counter_ref1;
            data_meas_ch8<=countermeas_clk8;
            data_ch8_done<=1;  
          end 
         
         
                 
         if (data_ready && data_transfer_status!=1)
         begin
           data_transfer_counter<=data_transfer_counter+1;
           web<=4'b1111;
           enb<=1;
                   
                     
           case (data_transfer_counter)
             6'b000001:begin 
             addrb<=32'h0;
             dinb<=data_ref_ch1;
             //dinb<=32'h1;
             end 
             6'b000011:begin
             addrb<=32'h4;
             dinb<=data_ref_ch2;
             //dinb<=32'h2;
             end   
             6'b000101:begin
             addrb<=32'h8;
             dinb<=data_ref_ch3;
             //dinb<=32'h3;
             end 
             6'b000111:
             begin
             addrb<=32'hc;
             dinb<=data_ref_ch4;
             //dinb<=32'h4;
             end
             6'b001001:begin
             addrb<=32'h10;
             //dinb<=data_ref_ch5;
             dinb<=32'h5;
             end 
             6'b001011:begin
             addrb<=32'h14;
             dinb<=data_ref_ch6;
             end 
             6'b001101:begin
             addrb<=32'h18;
             dinb<=data_ref_ch7;
             end 
             6'b001111:begin 
             addrb<=32'h1C;
             dinb<=data_ref_ch8;
             end 
             6'b010001:begin
             addrb<=32'h20;
             dinb<=data_meas_ch1;
             end
             6'b010011:begin
             addrb<=32'h24;
             dinb<=data_meas_ch2;
             end
             6'b010101:begin
             addrb<=32'h28;
             dinb<=data_meas_ch3;
             end
             6'b010111:begin
             addrb<=32'h2C;
             dinb<=data_meas_ch4;
             end
             6'b011001:begin
             addrb<=32'h30;
             dinb<=data_meas_ch5;
             end
             6'b011011:begin
             addrb<=32'h34;
             dinb<=data_meas_ch6;
             end
             6'b011101:begin
             addrb<=32'h38;
             dinb<=data_meas_ch7;
             end
             6'b011111:begin
             addrb<=32'h3C;
             dinb<=data_meas_ch8;
             end  
                   
                   
                   
             6'b000010:begin 
               addrb<=32'h0;
               dinb<=data_ref_ch1;
               //dinb<=32'h1;
               end 
             6'b000100:begin
               addrb<=32'h4;
               dinb<=data_ref_ch2;
               //dinb<=32'h2;
             end   
             6'b000110:begin
               addrb<=32'h8;
               dinb<=data_ref_ch3;
               //dinb<=32'h3;
             end 
             6'b001000:
               begin
               addrb<=32'hC;
               dinb<=data_ref_ch4;
               //dinb<=32'h4;
             end
             6'b001010:begin
               addrb<=32'h10;
               dinb<=data_ref_ch5;
               //dinb<=32'h5;
             end 
             6'b001100:begin
               addrb<=32'h14;
               dinb<=data_ref_ch6;
             end 
             6'b001110:begin
               addrb<=32'h18;
               dinb<=data_ref_ch7;
             end 
             6'b010000:begin 
               addrb<=32'h1C;
               dinb<=data_ref_ch8;
             end 
             6'b010010:begin
               addrb<=32'h20;
               dinb<=data_meas_ch1;
             end
             6'b010100:begin
               addrb<=32'h24;
               dinb<=data_meas_ch2;
             end
             6'b010110:begin
               addrb<=32'h28;
               dinb<=data_meas_ch3;
             end
             6'b011000:begin
               addrb<=32'h2C;
               dinb<=data_meas_ch4;
             end
             6'b011010:begin
               addrb<=32'h30;
               dinb<=data_meas_ch5;
             end
             6'b010110:begin
               addrb<=32'h34;
               dinb<=data_meas_ch6;
             end
             6'b011110:begin
              addrb<=32'h38;
              dinb<=data_meas_ch7;
             end
             6'b100000:begin
               addrb<=32'h3C;
               dinb<=data_meas_ch8;
               data_transfer_status=1;
             end  
                   
             endcase 
           end
           
           else if ((data_ready && data_transfer_status))
           begin
             web<=4'b000;
             enb<=0;
             rstb<=0;
             addrb<=32'h0;
             dinb<=0;
           end 
     end
   end
    
     
  
   always @(posedge meas_clk1 or posedge reset_counter)
   begin
     
     if (reset_counter==1)
     begin 
         countermeas_clk1<=0;
     end
     
     else if (en_counter && reset_counter!=1)
     begin
          countermeas_clk1<=countermeas_clk1+1;
     end 
     
   end    
     
    
    always @(posedge meas_clk2 or posedge reset_counter)
    begin
      if (reset_counter==1)
        begin 
          countermeas_clk2<=0;
        end
       else if (en_counter && reset_counter!=1)
       begin
         countermeas_clk2<=countermeas_clk2+1;
         
       end  
          
    end 
    
    always @(posedge meas_clk3 or posedge reset_counter)
    begin
       
       if (reset_counter)
       begin 
         countermeas_clk3<=0;
       end 
       
       else if (en_counter && reset_counter!=1)
       begin
         countermeas_clk3<=countermeas_clk3+1;
       end
     end 
        
    always @(posedge meas_clk4 or posedge reset_counter)
    begin
        if (reset_counter)
        begin 
          countermeas_clk4<=0;
        end
        
        else if (en_counter && reset_counter!=1)
        begin
        countermeas_clk4<=countermeas_clk4+1;
        end 
        
         
     end     
        
     always @(posedge meas_clk5 or posedge reset_counter)
     begin
      
      if (reset_counter)
      begin 
        countermeas_clk5<=0;
      end
     
      else  if (en_counter && reset_counter!=1)
      begin
        countermeas_clk5<=countermeas_clk5+1;
      end 
       
     end     
      
     always @(posedge meas_clk6 or posedge reset_counter )
     begin
    
        if (reset_counter)
        begin 
          countermeas_clk6<=0;
        end
       
       else if (en_counter && reset_counter!=1)
       begin
         countermeas_clk6<=countermeas_clk6+1;
       end 
        
       
     end   

     always @(posedge meas_clk7 or posedge reset_counter )
     begin
       
       
        if (reset_counter)
        begin 
         countermeas_clk7<=0;
        end 
        
        else if (en_counter && reset_counter!=1)
        begin
          countermeas_clk7<=countermeas_clk7+1;
        end
        
     end  
           
     always @(posedge meas_clk8 or posedge reset_counter)
     begin
       
       if (reset_counter)
       begin 
         countermeas_clk8<=0;
       end 
       
       else if (en_counter && reset_counter!=1)
       begin
         countermeas_clk8<=countermeas_clk8+1;
       end 
       
        
     end  
     
    
           
     endmodule
           
     //Valid data acquired starts here      
     /*always @(countermeas_clk1==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)
     begin 
       if (en_counter && reset_counter!=1 && data_ch1_done!=1)
       begin 
         data_ref_ch1<=counter_ref1;
         data_meas_ch1<=countermeas_clk1;
         data_ch1_done<=1;
       end   
     end  
         
     always @(countermeas_clk2==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)
     begin 
       if (en_counter && reset_counter!=1 && data_ch2_done!=1)
       begin 
         data_ref_ch2<=counter_ref1;
         data_meas_ch2<=countermeas_clk2;
         data_ch2_done<=1;
       end   
     end
             
     always @(countermeas_clk3==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)
     begin 
         if (en_counter && reset_counter!=1 && data_ch3_done!=1 )
         begin 
           data_ref_ch3<=counter_ref1;
           data_meas_ch3<=countermeas_clk3;
           data_ch3_done<=1;
         end   
     end   
               
     always @(countermeas_clk4==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)
     begin 
       if (en_counter && reset_counter!=1 && data_ch4_done!=1)
         begin 
           data_ref_ch4<=counter_ref1;
           data_meas_ch4<=countermeas_clk4;
           data_ch4_done<=1;
         end   
      end       
                
     always @(countermeas_clk5==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)
     begin 
       if (en_counter && reset_counter!=1 && data_ch5_done!=1)
       begin 
         data_ref_ch5<=counter_ref1;
         data_meas_ch5<=countermeas_clk5;
         data_ch5_done<=1;
         end   
       end      
                
     always @(countermeas_clk6==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)
     begin 
       if (en_counter && reset_counter!=1 && data_ch6_done!=1)
       begin 
         data_ref_ch6<=counter_ref1;
         data_meas_ch6<=countermeas_clk6;
         data_ch6_done<=1;
       end   
     end       
            
     always @(countermeas_clk7==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)
     begin 
       if (en_counter && reset_counter!=1 && data_ch7_done!=1)
       begin 
         data_ref_ch7<=counter_ref1;
         data_meas_ch7<=countermeas_clk7;
         data_ch7_done<=1;
       end   
     end 
    
     always @(countermeas_clk8==`MEAS_COUNTER_VALUE || counter_ref1==`TIMEOUT_COUNTER_VALUE)
     begin 
       if (en_counter && reset_counter!=1 && data_ch8_done!=1)
       begin 
         data_ref_ch8<=counter_ref1;
         data_meas_ch8<=countermeas_clk8;
         data_ch8_done<=1;
       end   
     end */
        
        
     //Setup data transfer
    /* always@(posedge ref_clk)
     begin 
       if (reset_counter!=1)
       begin
       data_ready<=(data_ch1_done&&data_ch2_done&&data_ch3_done&&data_ch4_done&&data_ch5_done&&data_ch6_done&&data_ch7_done&&data_ch8_done);
       end 
       
       if (data_ready && data_transfer_status!=1 && en_counter && reset_counter!=1)
       begin
         data_transfer_counter<=data_transfer_counter+1;
         web<=4'b1111;
         enb<=1;
         
           
         case (data_transfer_counter)
         6'b000001:begin 
           addrb<=32'h0;
           dinb<=data_ref_ch1;
           end 
         6'b000011:begin
           addrb<=32'd4;
           dinb<=data_ref_ch2;
           end   
         6'b000101:begin
           addrb<=32'd8;
           dinb<=data_ref_ch3;
           end 
         6'b000111:
           begin
           addrb<=32'd12;
           dinb<=data_ref_ch4;
           end
         6'b001001:begin
           addrb<=32'd16;
           dinb<=data_ref_ch5;
           end 
         6'b001011:begin
           addrb<=32'd20;
           dinb<=data_ref_ch6;
           end 
         6'b001101:begin
           addrb<=32'd24;
           dinb<=data_ref_ch7;
         end 
         6'b001111:begin 
           addrb<=32'd28;
           dinb<=data_ref_ch8;
         end 
         6'b010001:begin
           addrb<=32'd32;
           dinb<=data_meas_ch1;
         end
         6'b010011:begin
           addrb<=32'd36;
           dinb<=data_meas_ch2;
         end
         6'b010101:begin
            addrb<=32'd40;
            dinb<=data_meas_ch3;
         end
         6'b010111:begin
           addrb<=32'd44;
           dinb<=data_meas_ch4;
         end
          6'b011001:begin
            addrb<=32'd48;
            dinb<=data_meas_ch5;
          end
          6'b011011:begin
            addrb<=32'd52;
            dinb<=data_meas_ch6;
          end
          6'b011101:begin
            addrb<=32'd56;
            dinb<=data_meas_ch7;
          end
          6'b011111:begin
            addrb<=32'd60;
            dinb<=data_meas_ch8;
            
          end  
         
         
         
         6'b000010:begin 
           addrb<=32'h0;
           dinb<=data_ref_ch1;
           end 
         6'b000100:begin
           addrb<=32'd4;
           dinb<=data_ref_ch2;
           end   
         6'b000110:begin
           addrb<=32'd8;
           dinb<=data_ref_ch3;
           end 
         6'b001000:
           begin
           addrb<=32'd12;
           dinb<=data_ref_ch4;
           end
         6'b001010:begin
           addrb<=32'd16;
           dinb<=data_ref_ch5;
           end 
         6'b001100:begin
           addrb<=32'd20;
           dinb<=data_ref_ch6;
           end 
         6'b001110:begin
           addrb<=32'd24;
           dinb<=data_ref_ch7;
         end 
         6'b010000:begin 
           addrb<=32'd28;
           dinb<=data_ref_ch8;
         end 
         6'b010010:begin
           addrb<=32'd32;
           dinb<=data_meas_ch1;
         end
         6'b010100:begin
           addrb<=32'd36;
           dinb<=data_meas_ch2;
         end
         6'b010110:begin
            addrb<=32'd40;
            dinb<=data_meas_ch3;
         end
         6'b011000:begin
           addrb<=32'd44;
           dinb<=data_meas_ch4;
         end
          6'b011010:begin
            addrb<=32'd48;
            dinb<=data_meas_ch5;
          end
          6'b010110:begin
            addrb<=32'd52;
            dinb<=data_meas_ch6;
          end
          6'b011110:begin
            addrb<=32'd56;
            dinb<=data_meas_ch7;
          end
          6'b100000:begin
            addrb<=32'd60;
            dinb<=data_meas_ch8;
            data_transfer_status=1;
          end  
         
         /* default: begin 
            web<=4'b000;
            addrb<=32'd0;
            dinb<=32'd0;
            enb<=0;
            rstb<=0;
          end  
         endcase 
       end
         
         else if ((reset_counter==1)||(data_ready && data_transfer_status && en_counter && reset_counter!=1))
         begin
                web<=4'b000;
                enb<=0;
                rstb<=0;
                addrb<=32'h0;
                dinb<=0;
           
         end 
     end 
     
           
    
      //Data transfer starts here
  /*   always @(data_transfer_counter==4'b0001)
     begin
        if (en_counter && reset_counter!=1 && data_transfer_status!=1 )
         begin
           web<=4'b1111;
           addrb<=32'h0;
           dinb<=data_ref_ch1;
           enb<=1;
           rstb<=0;
         end 
     end 
   
     always @(data_transfer_counter==4'b0010)
     begin 
         if (en_counter && reset_counter!=1 && data_transfer_status!=1)
         begin
           web<=4'b1111;
           addrb<=32'd4;
           dinb<=data_ref_ch2;
           enb<=1;
           rstb<=0;
         end 
      end 
       
     always @(data_transfer_counter==4'b0011)
     begin 
         if (en_counter && reset_counter!=1 && data_transfer_status!=1)
         begin
          web<=4'b1111;
          addrb<=32'd8;
          dinb<=data_ref_ch3;
          enb<=1;
          rstb<=0;
         end
      end 
        
     always @(data_transfer_counter==4'b0100 )
     begin
       if (en_counter && reset_counter!=1 && data_transfer_status!=1)
       begin
         web<=4'b1111;
         addrb<=32'd16;
         dinb<=data_ref_ch4;
         enb<=1;
         rstb<=0;
       end 
     end 
         
     always @(data_transfer_counter==4'b0101)
     begin
       if (en_counter && reset_counter!=1 && data_transfer_status!=1)
       begin
         web<=4'b1111;
         addrb<=32'd20;
         dinb<=data_ref_ch5;
         enb<=1;
         rstb<=0;
       end 
     end      
        
     always @(data_transfer_counter==4'b0110)
     begin
       if (en_counter && reset_counter!=1 && data_transfer_status!=1)
       begin
         web<=4'b1111;
         addrb<=32'd24;
         dinb<=data_ref_ch6;
         enb<=1;
         rstb<=0;
       end      
     end 

     always @(data_transfer_counter==4'b0111)
     begin
       if (en_counter && reset_counter!=1 && data_transfer_status!=1)
       begin  
         web<=4'b1111;
         addrb<=32'd28;
         dinb<=data_ref_ch7;
         enb<=1;
         rstb<=0;
       end 
     end     


     always @(data_transfer_counter==4'b1000)
     begin
       if (en_counter && reset_counter!=1 && data_transfer_status!=1)
       begin 
         web<=4'b1111;
         addrb<=32'd32;
         dinb<=data_ref_ch8;
         enb<=1;
         rstb<=0;
         data_transfer_status<=1;
       end 
     end */

     



    /*else if (en_counter)
          begin 
            counter<=counter+1;
             web<=4'b1111;
             addrb<=32'b0;
             dinb<=counter;
             enb<=1;
             rstb<=0;
          end  */
    
   
    /*always@(counter==8'h01)
     begin
        web<=4'b0000;
        addrb<=32'b0;
        dinb<=32'hffff;
        enb<=0;
        rstb<=0;
     end
   
   
   always@(counter==32'h006)
   begin
      web<=4'b1111;
      addrb<=32'b0;
      dinb<=counter;
      enb<=1;
      rstb<=0;
   end
   
     always@(counter==32'h007)
    begin
       web<=4'b0000;
       addrb<=32'b0;
       enb<=0;
       rstb<=0;
    end */
   
   
    /*always@(counter==32'hFFFFFFFE)
       begin
          counter<=32'b0;
       end
       */
   
   
  
   
   
   
   
  /* always @(posedge clk)
   begin 
   
   if (counter==32'h006)
   begin
   //en_counter<=0; //Take a closer look when you are making multiple counters
   //reset_counter<=1; //Take a closer look when you are making multiple counters
   web<=4'b1111;
   addrb<=32'b0;
   dinb<=counter;
   enb<=1;
   rstb<=0;
   end
  
  else if (reset_counter==1)
  begin
  counter<=32'b0;
  end  
  
  else 
   begin 
   web<=4'b0000;
   addrb<=32'b0;
   dinb<=32'hffff;
   enb<=1;
   rstb<=0;
   end 
      
    end */