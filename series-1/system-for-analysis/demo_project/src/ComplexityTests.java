class ComplexityTests {
	
	public void ifStatement() { // 1
		if (1 < 2) {            // 2
			System.out.println("Hello");
		}
	}
	
	public void ifTrueStatement() { // 1
		if (true) {            
			System.out.println("Hello");
		}
	}
	
	public void ifFalseStatement() { // 1
		if (false) {           
			System.out.println("Hello");
		}
	}

	public void ifElseStatement() { // 1
		if (1 < 2) {				// 2
			System.out.println("Hello");
		} else {
			System.out.println("World");
		}
	}
	
	public void caseStatement() {	// 1
		int n = 1;
		switch (n) {
			case 0: 					// 2
			case 1: 					// 3
				System.out.println("Hello");
				break;
			case 2: 					// 4
			case 3: 					// 5
				System.out.println("World");
				break;
			default: 
				System.out.println("!!!");
				break;
		}
	}
	
	public void conditional() { // 1
		String x = (1 < 2) ? "Hello" : "World"; // 2
	}
	
	public void andStatement() { // 1
		if (1 < 2 && 2 <= 2) {				// 2, 3
			System.out.println("Hello");
		} 
	}
	
	public void orStatement() { // 1
		if (1 < 2 || 2 <= 2) {				// 2, 3
			System.out.println("Hello");
		} 
	}
	
	public void forStatement() { // 1
		for (int i=0; i<=10; i++) {      // 2      
			System.out.println(i);
		}
	}
	
	public void forCondStatement() { // 1
		for (int i = 0, j = 0; i<10; i++, j++) { // 2
			System.out.println(i);
		}
	}
	
	public void whileStatement() { // 1
		int i = 0;
		while(i<10) {            // 2
			System.out.println(i);
			i++;
		}
	}
	
	public void doStatement() { // 1
		int i = 0;
		do {            
			System.out.println(i);
			i++;
		} while(i<10); // 2
	}
	
	public void catchStatement() { // 1
		try {
			System.out.println("AS");
		} catch(Exception e) {  // 2
			System.out.println(e);
		}
	}
}