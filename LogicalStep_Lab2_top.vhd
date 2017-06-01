library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
    clkin_50			: in	std_logic;
	pb					: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
    leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
    seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  --below is where we create the design of a component
  --this is just the definition of the component, though- to actually put it on the "board", we need to instantiate it (which is done below)
  --a component can be instantiated any number of times, and what distinguishes them is which signals are hooked up to their inputs and outputs (this will be discussed below when we instantiate)
  
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port (
		clk		: in  std_logic := '0';
		DIN2		: in  std_logic_Vector(6 downto 0);
		DIN1		: in  std_logic_Vector(6 downto 0);
		DOUT		: out std_logic_Vector(6 downto 0);
		DIG2		: out std_logic;
		DIG1		: out std_logic
	);
	end component;
	
	component 2to1_mux port (
		
	
	);
	
	
	--Create any signals, or temporary variables to be used
	--But how about, person who wrote this document, YOU TELL US WHAT THE HELL A SIGNAL IS SO I DON'T HAVE TO SPEND A MILLION HOURS FIGURING OUT HOW THE MOST ESSENTIAL PART OF VHDL WORKS
	--Here is where we create the signals- essentially signals are kind of like variables in software, and work to connect components together here 
	--For example, you might create a 1 bit signal of type std_logic that is connected to the output of an AND gate (through port mapping, which we will go through further below)
	--You can then map that signal (through port mapping- again, we will go through it further down)
	--std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
	--
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);
	signal hex_A		: std_logic_vector(3 downto 0);
	signal hex_B		: std_logic_vector(7 downto 4);
	
-- Here the circuit begins

begin
	 hex_A <= sw(3 downto 0); --4 bit signal that is generated from usage of push buttons 0-3
	 hex_B <= sw(7 downto 4); --4 bit signal that is generated from usage of push buttons 4-7
	 
	 --COMPONENT HOOKUP 
	 --Here, we start by instantiating versions of our components that we created above (actually putting them on the chip board)
	 --If we want to use a component twice, we have to instantiate that object twice, but with different names (like with INST1 and INST2)
	 --The function of the port map is to actually solder or connect the wires/pins of the incoming signals into the holes/ports of the instantiated component 
	 --INST3 is a good example to use- essentially, we create an instantiation of the component "segment7_mux", and then hook up the various signals 
	 --The way you hook them up is crucial- We can see in the component definition that "clk" is the first input, "DIN2" is the second, then "DIN1", etc 
	 --Essentially what we are doing when we say "port map(clkin_50, seg7_A, seg7_B, etc)" is we are kind of putting a wire between "clkin_50" that connects it to the port labelled "clk" 
	 --So clkin_50 -> (is connected to) clk (port on the component "segment7_mux"), seg7_A -> DIN2, seg7_B -> DIN1, seg7_data -> DOUT, seg7_char2 -> DIG2, seg7_char1 -> DIG1 

	 INST1: SevenSegment port map(hex_A, seg7_A);
	 INST2: SevenSegment port map(hex_B, seg7_B);
	 INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);
 
end SimpleCircuit;

