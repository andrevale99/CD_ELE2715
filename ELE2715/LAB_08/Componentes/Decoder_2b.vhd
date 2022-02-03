--====================================================
--	DECODIFICADOR BINARIO DE 2 BITS
--====================================================
entity DECODER is
	port ( s_cod : in bit_vector(1 downto 0);
			en_cod : in bit;
			c0 : out bit;
			c1 : out bit;
			c2 : out bit);
end DECODER;

architecture ckt of DECODER is

	begin

		c0 <= (not s_cod(1) and not s_cod(0) and en_cod);
		c1 <= (not s_cod(1) and s_cod(0) and en_cod);
		c2 <= (s_cod(1) and not s_cod(0) and en_cod);

end ckt;