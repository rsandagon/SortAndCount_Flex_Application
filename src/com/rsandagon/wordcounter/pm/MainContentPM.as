package com.rsandagon.wordcounter.pm
{
	import com.rsandagon.wordcounter.models.WordGroup;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	
	//	Presentation Model (MVVM) is best suited for languages with binding mechanism
	//	It was introduced by Fowler as another optimization for MVC
	//	http://martinfowler.com/eaaDev/PresentationModel.html
	[Bindable]
	public class MainContentPM extends EventDispatcher
	{
		private var dispatcher:IEventDispatcher;
		
		public var wordGroups : ArrayCollection;
		
		private var phrase : String;
		private var keys:Object;
		
		public function MainContentPM(target:IEventDispatcher=null)
		{
			super(target);
			dispatcher = target;
			
			//	initialize arrayList
			wordGroups = new ArrayCollection;
		}
		
		public function countWords(phraseString : String): Boolean{
			//	indicates if phrase is processed or not
			//	this avoid unnecessary counting when input is unchanged.
			if(trim(phraseString.toLowerCase()) == phrase) 
				return false;

			// reset params
			reset();
			
			//	change phrase
			phrase = trim(phraseString.toLowerCase());
			
			//	build the list
			buildWordGroups();
			return true;
		}

		//	this resets the parameters 
		public function reset():void{
			keys = {};
			phrase = "";
			wordGroups.removeAll();
		}
		
		//	this builds the wordGroups
		private function buildWordGroups():void{
			var wordArray : Array = phrase.split(" ");
			var filteredWords:Array = wordArray.filter(removedDuplicates);
			
			for each(var word : String in filteredWords){
				var count : int = phrase.split(word).length - 1; //count occurences by split	
				wordGroups.addItem(new WordGroup(word,count));
			}
			
			var dataSortField:SortField = new SortField();
			dataSortField.name = "word";
			dataSortField.numeric = false;
			
			var dataSort:Sort = new Sort();
			dataSort.fields = [dataSortField];
			wordGroups.sort = dataSort;
			wordGroups.refresh();
		}
		
		//	this is an old snippet I have in filterring out duplicates in arrays. I don't have the 
		//	original source though.		
		private function removedDuplicates(word:String, idx:uint, arr:Array):Boolean {
			if (keys.hasOwnProperty(word)) {
				return false;
			} else {
				keys[word] = word;
				return true;
			}
		}
		
		// regex for quick trim; other uses StringUtils etc,
		// I prefer to simply use this method to reduce unneeded import 		
		private function trim( s:String ):String
		{
			return s.replace(/^[\s|"]+|[\s|"]+$/gs, '');
		}
	}
}