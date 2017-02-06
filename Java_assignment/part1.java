import java.util.*;
import java.lang.Math;


class ComparableList<T extends Comparable<T>> extends ArrayList<T> implements Comparable<ComparableList<T>>
{

	public int compareTo(ComparableList<T> l2)
	{
		
		// length1 = this.size();
		// length2 = l2.size();
		// length = Math.min(length1, length2);

		Iterator<T> firstIter = this.iterator();
		Iterator<T> secondIter = l2.iterator();

		while (firstIter.hasNext() && secondIter.hasNext())
		{
			T from_l1 = firstIter.next();
			T from_l2 = secondIter.next();
			int result = from_l1.compareTo(from_l2);

			// System.out.println(" this result is" + result );

			if (result==0)
				continue;

			// System.out.println(" this after while ");
			return result;
		}

		if (this.size() > l2.size())
		{
			return 1;
		}

		else if (l2.size() > this.size())
		{
			return -1;
		}

		else
		{
			return 0;
		}
	}

	// @override
	public String toString()
	{
		String s = "[[";
		for (T t : this)
			s += t + " ";

		s += "]]";
		return s;
	}

}

class A implements Comparable<A>
{
	Integer x;

	public A (Integer x)
	{
		this.x = x;
	}

	public int getX()
	{
		return this.x;
	}

	public int compareTo (A that)
	{
		Integer this_value = getSum();
		Integer that_value = that.getSum();
		return this_value.compareTo(that_value);
	}

	public int getSum()
	{
		return x;
	}

	public String toString()
	{
		return "A<" + x.toString() + ">";
	}
}

class B extends A
{
	Integer y;

	public B(Integer x, Integer y)
	{
		super(x);
		this.y = y;
	}

	public int compareTo (A that)
	{
		Integer this_value = getSum();
		Integer that_value = that.getSum();
		return this_value.compareTo(that_value);

	}

	public int getSum()
	{
		return x+y;
	}

	public String toString()
	{
		return "B<" + x.toString() + "," + y.toString() + ">";
	}
}

public class part1
{
	public static void main(String args[])
	{
		// ComparableList<Character> c1 = new ComparableList<Character>();
		// ComparableList<Character> c2 = new ComparableList<Character>();

		// for(int i = 0; i < 10; i++) 
		// {
	 //    	c2.add((char)(i+97));
	    	
		// }

		// c1.add(0, 'b');


		// System.out.println("c1 is ");
		// for (Integer i : c1)
		// 	System.out.println(i);
		// System.out.println("c2 is ");
		// for (Integer i : c2)
		// 	System.out.println(i);

		// System.out.println(" this compareTo result " + c1.compareTo(c2));
		// System.out.println(" this testing comparableList toString " + c2);

		// A a1 = new A(6);
      	// A a2 = new A(7);
      	// System.out.println(" this A toString: a1 " + a1 + " a2: " + a2);
      	// System.out.println(" this A compareTo " + a1.compareTo(a2));
      	// B b1 = new B(2,4);
      	// B b2 = new B(3,5);

   //  	System.out.println(" this " + a1.compareTo(b1));
 		// System.out.println(" this " + a1.compareTo(b2));
 		// System.out.println(" this " + b1.compareTo(a1));
 		// System.out.println(" this " + b2.compareTo(a1));
 		// System.out.println(" this " + b1.compareTo(b2));
 		// // System.out.println(" this b1 " + b1);

 		test();

	}

	public static <T extends Comparable<T>> void addToCList(T z, ComparableList<T> l)
	{
		l.add(z);
	}


	static void test()
	{

 		ComparableList<A> c1 = new ComparableList<A>();
		ComparableList<A> c2 = new ComparableList<A>();
		for(int i = 0; i < 10; i++) {
	    	addToCList(new A(i), c1);
	    	addToCList(new A(i), c2);
		}

		addToCList(new A(12), c1);
		addToCList(new B(6,6), c2);
		
		addToCList(new B(7,11), c1);
		addToCList(new A(13), c2);

		System.out.print("c1: ");
		System.out.println(c1);
		
		System.out.print("c2: ");
		System.out.println(c2);

		switch (c1.compareTo(c2)) {
			case -1: 
			    System.out.println("c1 < c2");
			    break;
			case 0:
			    System.out.println("c1 = c2");
			    break;
			case 1:
			    System.out.println("c1 > c2");
			    break;
			default:
			    System.out.println("Uh Oh");
			    break;
		}
	}
}