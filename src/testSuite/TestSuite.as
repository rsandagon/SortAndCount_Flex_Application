package testsuite
{
	import testSuite.tests.MainContetPMTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite
	{
		public var pmTest:MainContetPMTest = new MainContetPMTest();
	}
}  