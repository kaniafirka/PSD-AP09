library ieee;
use ieee.std_logic_1164.all;

entity counter_score is 
	port (
		clock			: in std_logic;
		reset			: in std_logic;
		count			: in std_logic;
		seven_segment_1	: out std_logic_vector (6 downto 0):="0111111";
		seven_segment_2	: out std_logic_vector (6 downto 0):="0111111"
	);
end counter_score;

architecture arch_score of counter_score is
	signal digit : integer range 0 to 20;
begin
	process (clock, reset, count, digit)
	begin
		if rising_edge(clock) then
			if reset = '1' then
				seven_segment_1 <= "0111111";
				seven_segment_2	<= "0111111";
				digit <= 0;
			else
				if count = '1' then
					digit <= digit + 1;
					case digit is
						when 0 => seven_segment_2 <= "0000110";
						when 1 => seven_segment_2 <= "1011011";
						when 2 => seven_segment_2 <= "1001111";
						when 3 => seven_segment_2 <= "1100110";
						when 4 => seven_segment_2 <= "1101101";
						when 5 => seven_segment_2 <= "1111101";
						when 6 => seven_segment_2 <= "0000111";
						when 7 => seven_segment_2 <= "1111111";
						when 8 => seven_segment_2 <= "1101111";
						when 9 => seven_segment_2 <= "0111111";
						when 10 => seven_segment_2 <= "0000110";
						when 11 => seven_segment_2 <= "1011011";
						when others =>
							seven_segment_1 <= "0111111";
							seven_segment_2	<= "0111111";
					end case;
				end if;
			end if;
		end if;
	end process;
end arch_score;
	