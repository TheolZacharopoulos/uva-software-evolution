package unit_tests;

import junit.framework.TestCase;

public class BasicTestCase extends TestCase {
	public BasicTestCase(){
        super();
    }

    public BasicTestCase(String name){
        super(makeNameValid(name));
    }
    private static String makeNameValid(String name){
    	return name.replace(',' , ';').replace('(','{');
    }
}