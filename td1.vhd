library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Indispensable pour l'arithmétique

entity counter is
    Port ( 
        CK, RST, SENS, LOAD, EN : in std_logic;
        Din    : in std_logic_vector(15 downto 0);
        Dout    : out std_logic_vector(15 downto 0);
    );
end counter;

architecture Behavioral of counter is
begin
    process(CK)
        signal count : unsigned(15 downto 0) := (others => '0'); -- 8 bits pour capturer le carry
    begin
        -- Valeurs par défaut pour éviter les "latches"
        if CK'event and CK='1' then 
            if RST='0' then count<=(others => '0');
            elsif LOAD='1' then count<=Din;
            elsif EN='0' and SENS='1' then count<=count+1;
            elsif EN='0' and SENS='0' then count<=count-1;
            end if;
        end if;
        Dout<=count;
    end process;
end Behavioral;