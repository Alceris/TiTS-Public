﻿package classes
{
	import classes.DataManager.Serialization.UnversionedSaveable;
	public class BreastRowClass extends UnversionedSaveable
	{
		//constructor
		public function BreastRowClass()
		{
		}
		
		//For cheateyness.
		// include "consts.as";
		
		//VARS AHOOOYYY
		public var breasts:Number = 2;
		
		public var nippleType:Number = 0;
		public var breastRatingRaw:Number = 0;
		public var breastRatingMod:Number = 0;
		public var breastRatingLactationMod:Number = 0;
		public var breastRatingHoneypotMod:Number = 0;
		
		public function breastRating(arg:Number = 0, apply:Boolean = false):Number
		{
			if (apply)
			{
				breastRatingRaw = arg;
			}
			else if (arg != 0)
			{
				breastRatingRaw += arg;
				if (breastRatingRaw < 0) breastRatingRaw = 0;
			}
			
			var currRating:Number = breastRatingRaw + breastRatingMod + breastRatingLactationMod + breastRatingHoneypotMod;
			
			if (currRating < 0)
			{
				return 0;
			}
			else
			{
				return currRating;
			}
		}
		
		//Fullness used for lactation....if 75 or greater warning bells start going off!
		//If it reaches 100 it reduces lactation multiplier.
		public var fullness:Number = 0;
		public function fuckable():Boolean {
			return (nippleType == GLOBAL.NIPPLE_TYPE_FUCKABLE || nippleType == GLOBAL.NIPPLE_TYPE_LIPPLES);
		}
	}
}
