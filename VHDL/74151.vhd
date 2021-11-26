entity ci_74151 is
	port ( I : in bit_vector(7 downto 0);
			S : in bit_vector(2 downto 0);
			Y : out bit;
			YN : out bit);
end ci_74151;


architecture ckt of ci_74151 is

	begin

		Y <= (I(0) and (not S(2) and not S(1) and not S(0))) 
			or
			  (I(1) and (not S(2) and not S(1) and S(0))) 
			or 
			  (I(2) and (not S(2) and S(1) and not S(0))) 
			or 
			  (I(3) and (not S(2) and S(1) and S(0))) 
			or 
			  (I(4) and (S(2) and not S(1) and not S(0))) 
			or 
			  (I(5) and (S(2) and not S(1) and S(0))) 
			or 
			  (I(6) and (S(2) and S(1) and not S(0))) 
			or 
			  (I(7) and (S(2) and S(1) and S(0)));


end ckt;