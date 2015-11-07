package unit_tests;

import Person.Person;

public class TestPerson extends BasicTestCase {

    public void testPersonIsValid() {
    	Person pNotValid = new Person("George", 15);
    	assertEquals(false, pNotValid.isValid());
    	
    	Person pValid = new Person("George", 18);
    	assertEquals(true, pValid.isValid());
    	
    	Person pValid2 = new Person("George", 21);
    	assertEquals(true, pValid2.isValid());
    }
}
