library ieee;
use ieee.std_logic_1164.all ;
use IEEE.Numeric_Std.all;

entity ServisTeamA is

    port(
        clock : in STD_LOGIC;
        reset : in STD_LOGIC;
        -- 10 : Untuk team A
        -- 01 : Untuk team B
        poin : in std_logic_vector(1 downto 0);
        --Sinyal untuk menentukan posisi pemain
        posisi : out std_logic_vector(1 downto 0);
        --Pemain mana yang berhak melakukan servis
        servisA : out std_logic_vector(1 downto 0)
    );
end ServisTeamA;

architecture arch_servA of ServisTeamA is
    --State dari FSM
    type state_types is (S0,S1,S2,S3,S4,S5,S6,S7);
    signal present_state : state_types;
    signal next_state : state_types;
    --keadaan dari FSM dalam biner
    signal keadaan : std_logic_vector (2 downto 0);
begin

    proc : process(clock, next_state, reset)
    begin
        --jika reset nilainya 1 maka akan mengembalikan ke S0
        if(reset = '1') then
            present_state <= S0;
        elsif(rising_edge(clock)) then
            present_state <= next_state;
        end if;
    end process proc;

    mix_proc : process(present_state, poin)
    begin
    --Output di set ke 00 untuk mencegah eror
        servisA <= "00";
        posisi <= "00";
        case present_state is
        --Keterangan Servis
        --10 = Servis pemain X
        --01 = Servis pemain Y
        --00 = Team A tidak boleh melakukan servis
        --Keterangan Posisi
        --01 = Pemain X dikiri, pemain Y dikanan
        --10 = Pemain X di kanan, pemain X dikiri
            when S0 =>
                keadaan <= "110";
                servisA <= "10";
                posisi <= "10";
                --Jika tim A dapat poin
                if(poin = "10") then
                    next_state <= S1;
                --Jika tim B dapat point
                elsif(poin = "01") then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 =>
                keadaan <= "111";
                servisA <= "10";
                posisi <= "10";
                --Jika tim A dapat poin
                if(poin = "10") then
                    next_state <= S2;
                --Jika tim B dapat point
                elsif (poin = "01") then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;
            when S2 =>
                keadaan <="000";
                servisA  <= "00";
                posisi <= "10";
                --Jika tim A dapat poin
                if(poin = "10") then
                    next_state <= S3;
                --Jika tim B dapat point
                elsif (poin = "01") then
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;
            when S3 =>
                keadaan <="001";
                servisA <= "00";
                posisi <= "10";
                --Jika timA dapat poin
                if(poin = "10") then
                    next_state <= S4;
                
                --Jika tim B dapat point
                elsif(poin ="01") then
                    next_state <= S4;
                else
                    next_state <= S3;
                end if;
            when S4 =>
                keadaan <="100";
                servisA <="01";
                posisi <= "01";
                --Jika tim A dapat point
                if(poin = "10") then
                    next_state <= S5;
                --Jika tim B dapat point
                elsif(poin = "01") then
                    next_state <= S5;
                else
                    next_state <= S4;
                end if;
            when S5 =>
                keadaan <="101";
                servisA <= "01";
                posisi <="01";
                --Jika tim A dapat point
                if (poin = "10") then
                    next_state <= S6;
                --Jika tim B dapat point
                elsif (poin = "01") then
                    next_state <= S6;
                else
                    next_state <= S5;
                end if;
            when S6 =>
                keadaan <="010";
                servisA <= "00";
                posisi <= "01";
                --Jika tim A dapat point
                if (poin = "10") then
                    next_state <= S7;
                
                --Jika tim B dapat point
                elsif (poin = "01") then
                    next_state <= S7;
                else
                    next_state <= S6;
                end if;
            when S7 =>
                keadaan <="011";
                servisA <= "00";
                posisi <= "01";
                --Jika tim A dapat point
                if (poin = "10") then
                    next_state <= S0;
                --Jika tim B dapat point
                elsif (poin = "01") then
                    next_state <= S0;
                else
                    next_state <= S7;
                end if;
            end case;
    end process mix_proc;
end arch_servA;
