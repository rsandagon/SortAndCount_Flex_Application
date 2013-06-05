package com.rsandagon.wordcounter.models
{
	/*	A simple object containing the word and the count
		This can be a model representation from an API -> JSON {"word":"myWord", "count" : 1}
		or a VO of the same structure.
	*/
	
	[Bindable]
	public class WordGroup
	{
		public var word : String;		
		public var count : int;
		
		public function WordGroup(word : String, count : int):void{
			this.word = word;
			this.count = count;
		}
	}
}