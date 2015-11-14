package metrics_tests;

class DuplicationTests {
	
	public void clonePrint1() {
		System.out.print("1"); // 1
		// Just a comment, still duplicate
		System.out.print("2"); // 2
		System.out.print("3"); // 3
		System.out.print("4"); // 4
		System.out.print("5"); // 5
		System.out.print("6"); // 6
		System.out.print("7"); // 7
        System.out.print("7"); //    || 29     
	} 						   //    || 30
	
	public void clonePrint2() {
		System.out.print("1"); // 8
		System.out.print("2"); // 9
		System.out.print("3"); // 10
		System.out.print("4"); // 11
		System.out.print("5"); // 12
		System.out.print("6"); // 13
		System.out.print("7"); // 14
        System.out.print("7"); //    || 31
	}						   //    || 32
	
	public void clonePrint3() {
		System.out.print("1"); // 15
		System.out.print("2"); // 16
		System.out.print("3"); // 17
		System.out.print("4"); // 18
		System.out.print("5"); // 19
		System.out.print("6"); // 20
		System.out.print("7"); // 21
		System.out.print("8"); //    || 33
		System.out.print("9"); //    || 34
	}						   //    || 35

	public void clonePrint4() {
		System.out.print("1"); // 22
		System.out.print("2"); // 23
		System.out.print("3"); // 24
		System.out.print("4"); // 25
		System.out.print("5"); // 26
		System.out.print("6"); // 27
		System.out.print("7"); // 28
		System.out.print("8"); //    || 36
		System.out.print("9"); //    || 37
	} 						   //    || 38
}