--==============================================================================================
--				OPERACAO OR
--==============================================================================================
entity OPR_OR is
    port (A, B : in bit_vector(7 downto 0);
            S : out bit_vector(7 downto 0);
            Z : out bit);
end OPR_OR;

architecture ckt of OPR_OR is

begin

    S <= A or B;

end ckt;