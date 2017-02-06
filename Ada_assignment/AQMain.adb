--PL - Fall 2016 - HW1 - Submmitted by: Lakshay Sharma
with Text_Io;  
use Text_Io;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;
--package int_io is new integer_io(integer);
--use int_io;
with AdaptiveQuad;

procedure AQMain is 

package FloatFunctions is new Ada.Numerics.Generic_Elementary_Functions(Float);
use FloatFunctions;

	Epsilon : Float := 0.000001;

	function MyF(x:Float) return Float is
	begin
    	return sin(x * x);
  	end MyF;

  	package ThisPack is new AdaptiveQuad(myF);
  	use ThisPack;
  
	task ReadPairs;

	task ComputeArea is 
		entry receive(A, B : float);
		entry ReadPairs_done;
	end ComputeArea;

	task PrintResult is 
		entry get_result(A_received, B_received, area_received : float);
		entry ComputeArea_done;
	end PrintResult;

	task body ReadPairs is
	a : float;
	b : float;

	begin
			for i in 1..5 loop
   				get(a);
   				get(b);
   				ComputeArea.receive(a, b);
	  		end loop;
	   	ComputeArea.ReadPairs_done;
	end ReadPairs;

	task body ComputeArea is
		this_A: float;
		this_B: float;
		area: float;
		Finished: Boolean := False;
	
	begin
		while not Finished loop
			select
				accept receive(A, B:float) do
					this_A := A;
					this_B := B;
				end receive;
				area := AQuad(this_A, this_B, Epsilon);
				PrintResult.get_result(this_A, this_B, area);
			or
				accept ReadPairs_done;
				Finished := True;
			end select;
		end loop;
		PrintResult.ComputeArea_done;
	end ComputeArea;

	task body PrintResult is
		value_A: float;
		value_B: float;
		value_area: float;
		Finished_2: Boolean := False;
	
	begin
		while not Finished_2 loop
			select
				accept get_result(A_received, B_received, area_received: float) do
					value_A := A_received;
					value_B := B_received;
					value_area := area_received;
				end get_result;

					Put("The area under sin(x^2) for x = " & float'image(value_A));
					Put(" to " & float'image(value_B));
					Put_Line(" is " & float'image(value_area));

			or

				accept ComputeArea_done;
					Finished_2 := True;
			end select;
		end loop;

	end PrintResult;

begin --AQMain
	null;
end AQMain;

