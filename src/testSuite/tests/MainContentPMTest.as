package testSuite.tests {
	
	import com.rsandagon.wordcounter.models.WordGroup;
	import com.rsandagon.wordcounter.pm.MainContentPM;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.Assert;
	
	public class MainContetPMTest {
		private var componentToTest : MainContentPM;
		
		[Before]
		public function runBeforeEveryTest():void {   
			componentToTest = new MainContentPM;
		}   
		
		[After]  
		public function runAfterEveryTest():void {   
			componentToTest = null;  
		} 
		
		[Test]  
		public function testReset():void { 
			componentToTest.wordGroups = new ArrayCollection([new WordGroup("testWord","5")]);
			Assert.assertEquals(1, componentToTest.wordGroups.length());
			
			componentToTest.reset();
			Assert.assertEquals(0, componentToTest.wordGroups.length());
		}
		
		[Test]  
		public function testWordGroup():void { 
			//	test count first
			componentToTest.countWords("this is a test");
			Assert.assertEquals(4, componentToTest.wordGroups.length());
			
			//	test removal of duplicates
			componentToTest.countWords("this is a test test test test");
			Assert.assertEquals(4, componentToTest.wordGroups.length());
			
			//	test word and count
			componentToTest.countWords("test1 test2 test3");
			Assert.assertEquals("test", WordGroup(componentToTest.wordGroups[0]).word);
			Assert.assertEquals(3, WordGroup(componentToTest.wordGroups[0]).count);
			
			//	test count update
			componentToTest.countWords("test1 test2 test3");
			Assert.assertEquals(3, WordGroup(componentToTest.wordGroups[0]).count);
			componentToTest.countWords("test1 test2 test3 test4 test5");
			Assert.assertEquals(5, WordGroup(componentToTest.wordGroups[0]).count);
		}
	}
}