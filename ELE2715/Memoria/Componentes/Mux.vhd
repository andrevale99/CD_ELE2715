--===============================
--		MUX de 2 bits de saida
--===============================
entity MUX is
	port (	I1, I2 : in bit;
			S : in bit;
			Q : out bit);
end MUX;

architecture ckt of MUX is

begin

	Q <= (I1 and not S) or (I2 and S);


end ckt;