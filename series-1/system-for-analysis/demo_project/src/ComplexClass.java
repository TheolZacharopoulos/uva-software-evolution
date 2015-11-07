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
	
	public boolean isPersonValid12(int age) {
	    for (int i = 0; i < 1000; i++) {
	        for (int i2 = 0; i < 1000; i++) {
	            for (int i3 = 0; i < 1000; i++) {
	                for (int i4 = 0; i < 1000; i++) {
	                    for (int i5 = 0; i < 1000; i++) {
	                        if (age > 26) {
	                            return true;
	                        } else if (age == 15) {
	                            return true;
	                        }
	                    }
	                }
	                if (age > 26) {
	                    return true;
	                } else if (age == 15) {
	                    return true;
	                }
	                return false;
	            }
	            if (age > 26) {
	                return true;
	            } else if (age == 15) {
	                return true;
	            }
	            return false;
	        }
	    }
	    return false;
	}
}