class Clone2 {
	public void cloneMethod() {
		
		// This is an exact clone of Clone1
		int i;
		
		/**
		 * It includes some comments and empty lines though
		 */
		final int n = 10;
		
		/**
		 * It should be detected anyway.
		 */for(i=0;i<n;i++) {
			if (i % 2 == 0) {
				System.out.print("Even");
			} else {
				System.out.print("Odd"); // alright!
			}
		}
	}
}