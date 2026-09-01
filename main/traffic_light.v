module traffic_light(
    input clk,
    input enable,
    output reg lampuHijau,
    output reg lampuKuning,
    output reg lampuMerah

);

//parameter kondisi untuk counter
parameter green_timer = 1000;
parameter yellow_timer = 200;
parameter red_timer = 1000;

//Deklarasi state
parameter IDLE = 3'b000;
parameter HIJAU = 3'b001;
parameter KUN_MER = 3'b010;
parameter MERAH = 3'b011;
parameter MER_KUN = 3'b100;

//Register untuk memori counter
reg [2:0] state;
reg [31:0] counter;

//logika FSM menggunakan sekuensial circuit
always @(posedge clk) begin
    if (enable == 1'b0) begin
        state <= IDLE;
        counter <= 0;
    end
    else begin
        case (state)
            IDLE: begin
            state <= HIJAU;
            counter <= 0;
        end    
        
            HIJAU: begin
                if (counter >= green_timer)begin
                state <= KUN_MER;
                counter <= 0;
                end else begin
            counter <= counter + 1;
                end
            end 
    
            KUN_MER: begin
                if (counter >= yellow_timer)begin
                state <= MERAH;
                counter <= 0;
            end else begin
                counter <= counter + 1;
                end
            end
            
            MERAH: begin
                if (counter >= red_timer)begin
                state <= MER_KUN;
                counter <= 0;
                end else begin
            counter <= counter + 1;
                end
            end
            
            MER_KUN: begin
                if (counter >= yellow_timer)begin
                state <= HIJAU;
                counter <= 0;
                end else begin
            counter <= counter + 1;
                end
            end
        endcase
    end              
 end

//rangkaian kombinasional
always @(*) begin
    lampuHijau = 1'b0;
    lampuKuning = 1'b0;
    lampuMerah = 1'b0;

    case(state)
        HIJAU: begin
            lampuHijau = 1'b1;
        end
        
        KUN_MER: begin
            lampuKuning = 1'b1;
        end
        
        MERAH: begin
            lampuMerah = 1'b1;
        end
        
        MER_KUN: begin
            lampuKuning = 1'b1;
        end
    endcase

    end

endmodule