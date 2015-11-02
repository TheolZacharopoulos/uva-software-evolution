class ComplexClass {
	
	public boolean isPersonValid1(int age) {
		// Complexity 1. 
		return false;
	}
	
	public boolean isPersonValid2(int age) {
		// Complexity 2.
		if (age > 26) {
			return true;
		} 
		return false;
	}
	
	public boolean isPersonValid3(int age) {
		// Complexity 3.
		if (age > 26) {
			return true;
		} else if (age == 15) {
			return true;
		}
		return false;
	}
}