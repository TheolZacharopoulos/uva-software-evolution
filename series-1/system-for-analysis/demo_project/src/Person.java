public class Person {
	
	private String mName;
	private int mAge;
	
	Person() {
		this("", 0);
	}
	
	Person(String name, int age) {
		this.mName = name;
		this.mAge = age;
	}
}