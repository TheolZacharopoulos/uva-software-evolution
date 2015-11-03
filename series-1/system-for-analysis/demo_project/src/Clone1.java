class Clone1 {
	public void cloneMethod() {
		int i;
		final int n = 10;
		
		for(i=0;i<n;i++) {
			if (i % 2 == 0) {
				System.out.print("Even");
			} else {
				System.out.print("Odd");
			}
		}
	}
}