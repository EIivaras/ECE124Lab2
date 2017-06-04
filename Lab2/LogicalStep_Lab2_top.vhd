library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
    clkin_50			: in	std_logic;
	pb					: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
    leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
    seg7_data 		    : out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	    : out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	    : out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 

   component SevenSegment port (
		hex   		:  in  std_logic_vector(3 downto 0);   -- The 4-bit data to be displayed
		sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port (
		clk		    : in  std_logic := '0';
		DIN2		: in  std_logic_vector(6 downto 0);
		DIN1		: in  std_logic_vector(6 downto 0);
		DOUT		: out std_logic_vector(6 downto 0);
		DIG2		: out std_logic;
		DIG1		: out std_logic
	);
	end component;
	
	component leds_drivers port ( --this is the component that will drive the leds
		leds_in     : in   std_logic_vector(7 downto 0); --takes in an 8-bit logic vector where each bit is the state that the corresponding led we will be in
		led7_out    : out  std_logic;
		led6_out    : out  std_logic;
		led5_out    : out  std_logic;
		led4_out    : out  std_logic;
		led3_out    : out  std_logic;
		led2_out    : out  std_logic;
		led1_out    : out  std_logic;
		led0_out    : out  std_logic
	);
	end component;
	
	component twoToOne_mux port (
		logic	   :  in  std_logic_vector(7 downto 0);
		addition   :  in  std_logic_vector(7 downto 0);
		pb3_select :  in  std_logic;
		hex_out    :  out std_logic_vector(7 downto 0)
	);
	end component;
	
	component ALU port ( --this is the component that will take care of the and/or/xor operations
		hex_A      :  in  std_logic_vector(3 downto 0);
		hex_B      :  in  std_logic_vector(3 downto 0);
		pb_0       :  in  std_logic;
		pb_1       :  in  std_logic;
		pb_2       :  in  std_logic;
	    ALU_output :  out std_logic_vector(3 downto 0)
	);
	end component;
	
	component adder port ( --this is the component that will actually add the numbers together
		hex_A      :  in  std_logic_vector(3 downto 0);
		hex_B      :  in  std_logic_vector(3 downto 0);
		sum        :  out std_logic_vector(7 downto 0)
	);
	
	
	--Create any signals, or temporary variables to be used
	
	signal pb_bar                    : std_logic_vector(3 downto 0);
	signal seg7_A		             : std_logic_vector(6 downto 0);
	signal seg7_B		             : std_logic_vector(6 downto 0);
	signal hex_A		             : std_logic_vector(3 downto 0);
	signal hex_B		             : std_logic_vector(7 downto 4);
	signal hex_C                     : std_logic_vector(7 downto 0); --hex_C will be the concatenated version of hex_A and hex_B
	signal fourBitLogic              : std_logic_vector(3 downto 0); --fourBitLogic will be the output of the ALU 
	signal eightBitLogic             : std_logic_vector(7 downto 0); --eightBitLogic will be fourBitLogic with four 0's concatenated onto its front
	signal eightBitSum               : std_logic_vector(7 downto 0); --eightBitSum is the sum of the adder 
	signal twoToOne_mux_out_sevenSeg : std_logic_vector(7 downto 0); --this will be the bit output that is sent through the sevenSeg decoder 
	signal twoToOne_mux_out_leds     : std_logic_vector(7 downto 0); --this will be the bit output that is sent through the led driver
	signal sevenSeg_firstHalf        : std_logic_vector(3 downto 0); --this will be first half of twoToOne_mux_out_sevenSeg, because each sevenSeg decoder only takes 4 bit inputs 
	signal sevenSeg_secondHalf       : std_logic_vector(3 downto 0); --this will be the second half of -----------||--------------------------------------------------------------
	
-- Here the circuit begins

begin
	 pb_bar <= NOT(pb); --add inverters to the push buttons for active-low compensation
	
	 hex_A <= sw(3 downto 0); --4-bit signal that is generated from usage of push buttons 0-3
	 hex_B <= sw(7 downto 4); --4-bit signal that is generated from usage of push buttons 4-7
	 hex_C <= hex_B & hex_A; --concatenate hex_A and hex_B, where hex_B is the MS bit 
	 
	 --COMPONENT HOOKUP 

	 INST1: ALU          port map(hex_A, hex_B, pb_bar(0), pb_bar(1), pb_bar(2), fourBitLogic); --start by hooking up the ALU to the hex inputs, push buttons, and set its output to fourBitLogic 
	 INST2: adder        port map(hex_A, hex_B, eightBitSum); --hook up the adder to the hex inputs and set its output to eightBitSum 
	 INST3: twoToOne_mux port map(hex_C, eightBitSum, pb_bar(3), twoToOne_mux_sevenSeg); --hook up one two to one mux that will decide what data goes into the sevenSeg displays 
	 INST4: twoToOne_mux port map(eightBitLogic, eightBitSum, pb_bar(3), twoToOne_mux_out_leds); --hook up another two to one mux that will decide what data goes into the leds 
	 INST5: SevenSegment port map(sevenSeg_firstHalf, seg7_A); --First seven seg decoder 
	 INST6: SevenSegment port map(sevenSeg_secondHalf, seg7_B); --Second seven seg decoder
	 INST7: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);
	 INST8: leds_drivers port map(twoToOne_mux_out_leds, leds(7), leds(6), leds(5), leds(4), leds(3), leds(2), leds(1), leds(0));

	 
	 eightBitLogic <= "0000" & fourBitLogic; --concatenate four 0's onto fourBitLogic so it can go through the two to one mux (which takes in 8-bit inputs)
	 
	 sevenSeg_firstHalf <= twoToOne_mux_sevenSeg(3 downto 0); --un-concatenating the 8-bit sum into two 4-bit signals so they can go through the sevenSegment decoder
	 sevenSeg_secondHalf <= twoToOne_mux_sevenSeg(7 downto 4); 
 
end SimpleCircuit;

