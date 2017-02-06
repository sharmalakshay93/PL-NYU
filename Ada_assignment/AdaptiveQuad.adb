--PL - Fall 2016 - HW1 - Submmitted by: Lakshay Sharma
with Text_Io;  
use Text_Io;

package body AdaptiveQuad is


	function SimpsonsRule(a, b: Float) return Float is
		c : Float;
		h3 : Float;
	begin
		c := (a + b) / 2.0;
		h3 := abs (b - a) / 6.0;
		return h3*(f(a) + 4.0*f(c) + f(b));
	end SimpsonsRule;

	
	function AQ (a, b, eps, whole: float) return float is

	c : float := (a+b)/2.0;
	left : float := SimpsonsRule(a, c);
	right : float := SimpsonsRule(c, b);
	left_part : float;
	right_part : float;

		procedure Rec is
			
			task One;
			task body One is
			begin 
				left_part := AQ(a, c, eps/2.0, left);
			end One;	

			task Two;
			task body Two is
			begin 
				right_part := AQ(c, b, eps/2.0, right);
			end Two;	

		begin -- Rec
			null;
		end Rec;



	begin
		if abs(left + right - whole) <= 15.0 * eps then
			return left + right + ((left + right - whole)/15.0);

		else
			Rec;
			return left_part + right_part;
		end if;

	end AQ;




	function AQuad(a, b, eps: float) return Float is
		whole : float;
	begin
		whole := SimpsonsRule(a, b);
		return AQ(a, b, eps, whole);
	end AQuad;



end AdaptiveQuad;