class ComplexityTests {
	
	public void ifStatement() {
		if (1 < 2) {
			System.out.println("Hello");
		}
	}

	public void ifElseStatement() {
		if (1 < 2) {
			System.out.println("Hello");
		} else {
			System.out.println("World");
		}
	}
	
	public void caseStatement() {
		int n = 1;
		switch (n) {
			case 0:
			case 1:
				System.out.println("Hello");
				break;
			case 2:
			case 3:
				System.out.println("World");
				break;
			default: 
				System.out.println("!!!");
				break;
		}
	}
	
	public void conditional() {
		String x = (1 < 2) ? "Hello" : "World";
	}
	
}