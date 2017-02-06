--PL - Fall 2016 - HW1 - Submmitted by: Lakshay Sharma
generic
	with function F(X: Float) return Float;
package AdaptiveQuad is
	function AQuad(A, B, Eps: Float) return Float;
end AdaptiveQuad;