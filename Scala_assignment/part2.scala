class OInt(x: Int) extends Ordered[OInt]{
	val value = x

	def get = x

	override def toString(): String = "<" + value.toString() + ">"

	override def compare(that: OInt) = this.value - that.value
}

abstract class OTree[T <: Ordered[T]] extends Ordered[OTree[T]]

case class ONode[T <: Ordered[T]] (l: List[OTree[T]]) extends OTree[T] {
	override def compare(other: OTree[T]) = other match {
		case OLeaf(ov) => 1
		// case Empty() => +1
		case ONode(x::xs) => 
			var result = 0
			if (l.isEmpty)
			{
				result = -1
			}
			else
			{
				result = l.head.compare(x)
			}
			if (result==0)
			{
				if (!(xs.isEmpty && l.tail.isEmpty))
				{
					result = ONode(l.tail).compare(ONode(xs))
				}
			}
			result

			case _ => 1
	}
}

case class OLeaf[T <: Ordered[T]] (v: T) extends OTree[T] {
	override def compare(other: OTree[T]) = other match {
		case OLeaf(ov) => v.compare(ov)
		case ONode(m) => -1
		case _ => 1
	}
}

// case class Empty[T <: Ordered[T]] () extends OTree[T] {
// 	override def compare(other: OTree[T]) = other match {
// 		case Empty() => 0
// 		case _ => -1
// 	}
// }

object part2
{

	def test()
	{
		val tree1 = ONode(List(OLeaf(new OInt(6))))

		val tree2 = ONode(List(OLeaf(new OInt(3)),
			   OLeaf(new OInt(4)), 
			   ONode(List(OLeaf(new OInt(5)))), 
			   ONode(List(OLeaf(new OInt(6)), 
				      OLeaf(new OInt(7))))));

		val treeTree1: OTree[OTree[OInt]] = 
      		ONode(List(OLeaf(OLeaf(new OInt(1)))))

      	val treeTree2: OTree[OTree[OInt]] = 
      		ONode(List(OLeaf(OLeaf(new OInt(1))),
			OLeaf(ONode(List(OLeaf(new OInt(2)), 
				  OLeaf(new OInt(2)))))))

		print("tree1: ")
		println(tree1)
		print("tree2: ")
		println(tree2)
		print("treeTree1: ")
    	println(treeTree1)
    	print("treeTree2: ")
    	println(treeTree2)

    	print("Comparing tree1 and tree2: ")
	    compareTrees(tree1, tree2)
	    print("Comparing tree2 and tree2: ")
	    compareTrees(tree2, tree2)
	    print("Comparing tree2 and tree1: ")
	    compareTrees(tree2, tree1)
	    print("Comparing treeTree1 and treeTree2: ")
	    compareTrees(treeTree1, treeTree2)
	    print("Comparing treeTree2 and treeTree2: ")
	    compareTrees(treeTree2, treeTree2)
	    print("Comparing treeTree2 and treeTree1: ")
	    compareTrees(treeTree2, treeTree1)

	}

	def compareTrees[T <: Ordered[T]](a: OTree[T], b: OTree[T])
	{
		if (a.compare(b) < 0){
			println("Less")
		}
		else if (a.compare(b) > 0){
			println("Greater")
		}
		else{
			println("Equal")
		}

	}

	def main(args: Array[String]) 
	{
		test();
	}
}