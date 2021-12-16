--==============================================================================================
--				OPERACAO AND
--==============================================================================================
entity OPR_NOT is
    port (A : in bit_vector(7 downto 0);
            S : out bit_vector(7 downto 0);
            Z : out bit);
end OPR_NOT;

architecture ckt of OPR_NOT is

begin

    S <= not A;

end ckt;