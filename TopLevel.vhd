library ieee;
use ieee.std_logic_1164.all;

entity TopLevel is
	port (
		poin : IN STD_LOGIC_VECTOR (1 downto 0);
		clock, reset : IN STD_LOGIC;
		seven_segment_1_A	: out std_logic_vector (6 downto 0);
		seven_segment_2_A	: out std_logic_vector (6 downto 0);
		seven_segment_1_B	: out std_logic_vector (6 downto 0);
		seven_segment_2_B	: out std_logic_vector (6 downto 0);
		posisi_A, posisi_B, servisA, servisB : OUT STD_LOGIC_VECTOR (1 downto 0)
	);
end TopLevel;

architecture main_arch of TopLevel is

	component counter_score is 
		port (
			clock			: in std_logic;
			reset			: in std_logic;
			count			: in std_logic;
			seven_segment_1	: out std_logic_vector (6 downto 0);
			seven_segment_2	: out std_logic_vector (6 downto 0)
		);
	end component;

	component ServisTeamA is
		port(
		--signal untuk clock dan reset
		clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
		-- signal untuk menentukan poin
		-- 10 : Poin untuk team X
		-- 01 : Pon untuk team Y
		poin : IN STD_LOGIC_VECTOR (1 downto 0);
		--Sinyal untuk menentukan posisi pemain
        posisi : out std_logic_vector(1 downto 0);
        --Pemain mana yang berhak melakukan servis
        servisA : out std_logic_vector(1 downto 0)
        );
	end component;

	component ServisTeamB is
		port(
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        -- signal untuk menentukan poin
        -- 10 : Poin untuk team X
        -- 01 : Pon untuk team Y
        poin : IN STD_LOGIC_VECTOR (1 downto 0);
        --Sinyal untuk menentukan posisi pemain
        posisi : out std_logic_vector(1 downto 0);
        --Pemain mana yang berhak melakukan servis
        servisB : out std_logic_vector(1 downto 0)
	);
	end component;
	
	signal poin_A	: std_logic;
	signal poin_B	: std_logic;
	
begin
	poin_A <= poin(1);
	poin_B <= poin(0);
	FSM_A	: ServisTeamA port map (clock, reset, poin, posisi_A, servisA);
	FSM_B	: ServisTeamB port map (clock, reset, poin, posisi_B, servisB);
	score_A	: counter_score port map (clock, reset, poin_A, seven_segment_1_A, seven_segment_2_A);
	score_B	: counter_score port map (clock, reset, poin_B, seven_segment_1_B, seven_segment_2_B);	
end main_arch;