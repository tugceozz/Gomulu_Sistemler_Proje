module LedDimmer(
  input clock,
  input buton1,
  input buton2,
  output reg red_led,
  output reg blue_led,
  output reg green_led
);

reg [31:0] counter = 32'd0;
reg [9:0] counter1 = 10'd0;
reg [3:0] pwm_counter = 4'd0;
reg btn_prev = 0;
reg is_pressed = 1;



always @(posedge clock) begin
  btn_prev <= buton1;
  
  if (btn_prev == 1'b1) begin
    is_pressed <= 1'b1;
    if (counter == 32'd240_000_000)  
      blue_led <= 1'b1;  
    else
      counter <= counter + 1;
  end else begin
    is_pressed <= 1'b0;
    blue_led <= is_pressed ? 1'b1 : 1'b0;  
    counter <= 0;
  end
end

always @(posedge clock) begin
  counter1 <= counter1 + 1;
  if (counter1 == 10'd100) begin
    counter1 <= 10'd0;
    pwm_counter <= pwm_counter + 1;
    
    if (pwm_counter >= 4'd15)
      pwm_counter <= 4'd0;
    
    if (pwm_counter < 4'd1)
      red_led <= 0;
    else
      red_led <= 1;
  end
end

  always @(posedge clock) begin 
    if (buton2)
      green_led <= 1;
    else
      green_led <= 0;
  end

endmodule
