library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity TopLevel_Testbench is
end TopLevel_Testbench;

architecture bench of TopLevel_Testbench is

	component TopLevel
		port (
			poin : IN STD_LOGIC_VECTOR (1 downto 0);
		    clock, reset : IN STD_LOGIC;
		    seven_segment_1_A	: out std_logic_vector (6 downto 0);
		    seven_segment_2_A	: out std_logic_vector (6 downto 0);
		    seven_segment_1_B	: out std_logic_vector (6 downto 0);
		    seven_segment_2_B	: out std_logic_vector (6 downto 0);
		    posisi_A, posisi_B, servisA, servisB : OUT STD_LOGIC_VECTOR (1 downto 0)
	    );
	end component;
	
	constant T       : time    := 20 ns;
	constant max_clk : integer := 43;
	constant count   : integer := 0;
	signal i         : integer := 0;
	
	signal poin : STD_LOGIC_VECTOR (1 downto 0);
	signal clock, reset : STD_LOGIC;
	signal seven_segment_1_A	: std_logic_vector (6 downto 0);
	signal seven_segment_2_A	: std_logic_vector (6 downto 0);
	signal seven_segment_1_B	: std_logic_vector (6 downto 0);
	signal seven_segment_2_B	: std_logic_vector (6 downto 0);
	signal posisi_A, posisi_B, servisA, servisB : STD_LOGIC_VECTOR (1 downto 0);
	
begin

	uut: TopLevel port map (poin, clock, reset, seven_segment_1_A, seven_segment_2_A, seven_segment_1_B, seven_segment_2_B, posisi_A, posisi_B, servisA, servisB);
									
	clock_process: process
	begin
		if (i < max_clk) then i <= i + 1;
		clock <= '1';
		wait for T/2;
		clock <= '0';
		wait for T/2;
		i <= i + 1;
		else wait;
		end if;
	end process;
	
	reset <= '1', '0' after T/2;

stimulus: process

	begin
		poin <= "00";
		wait for T;
		assert(posisi_A = "01" and posisi_B = "10" and servisA = "10" and servisB = "00")
		report "tes gagal pada testbench " & integer'image(1) severity error;
		poin <= "01";
		wait for T;
		assert(posisi_A = "10" and posisi_B = "10" and servisA = "01" and servisB = "00")
		report "tes gagal pada testbench " & integer'image(2) severity error;
		poin <= "00";
		wait for T;
		assert(posisi_A = "10" and posisi_B = "10" and servisA = "01" and servisB = "00")
		report "tes gagal pada testbench " & integer'image(3) severity error;
		poin <= "10";
		wait for T;
		wait;
end process;
		
end bench;