public class Person {
	
	// This is a comment for the name.
	private String mName;
	
	// This is a comment for the age.
	private int mAge;
	
	Person() {
		this("", 0);
	}
	
	/**
	 * This is a multiline comment.
	 * @param name
	 * @param age 
	 */
	Person(String name, int age) {
		this.mName = name;			// this line should be counted.
		this.mAge = age;			// this also.
	}
	
	public String getName() {
		return this.mName;
	}
	
	public int getAge() {
		return this.mAge;
	}
}