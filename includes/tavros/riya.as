/*
Riya, by Franks
Riya, UGC officer stationed on Tavros

- Should appear on Tavros station merchant deck immediately, no requirements
- Openly racist towards nonhumans
- Still bangs nonhumans tho
- GIRLZ ONLY
*/

public function showRiya(nude:Boolean = false):void
{
	showName("\nRIYA");
	if(nude) showBust("RIYA_NUDE");
	else showBust("RIYA");
}

public function getRiyaPregContainer():PregnancyPlaceholder
{
	var pp:PregnancyPlaceholder = new PregnancyPlaceholder();
	if(!pp.hasCock()) pp.createCock();
	pp.shiftCock(0, GLOBAL.TYPE_HUMAN);
	pp.cocks[0].cLengthRaw = 9;
	pp.createPerk("Fixed CumQ",450,0,0,0);
	
	return pp;
}

public function riyaAppearance():void
{
	clearOutput();
	showRiya();
	author("Franks");
	output("Riya is very tall for a human woman, standing 6\' 2\" by ancient Imperial measurements. She has midnight-black hair in a crew cut, smooth, dusky skin and deep, intense brown eyes. She is in remarkable shape, her rolled-up sleeves showing forearms corded with muscles that flex powerfully with every slight movement she makes. She has two heavy, round, firm D-cup breasts, a flat, hard stomach, and slender, powerful thighs that propel her forward with panther-like grace. She has one tattoo, a lone black wing on the left side of her neck just under her jaw.");
	output("\n\nShe is clad in a U.G.C. Peacekeeper uniform and dark blue beret. As you gaze on her form, you notice a rather conspicuous bulge down the left leg of her pants... it seems officer Batra is packing a little something extra.");
	riyaMenu();
}

public function riyaBonus():Boolean
{
	//If nonhuman: 
	if(!pc.isHuman()) output("\n\nThere’s a woman in a U.G.C. uniform loitering about, gazing at you with undisguised suspicion. There is a rather conspicuous bulge down her left pant leg - It seems this officer is packing something extra between her legs.");
	else output("\n\nThere’s a woman in a U.G.C. uniform loitering about, watching the passing shoppers keenly. There is a rather conspicuous bulge down her left pant leg - It seems this officer is packing something extra between her legs.");

	//[U.G.C. Officer]
	if(flags["RIYA_PUNCHED"] == 2) addDisabledButton(0,"Riya","Riya","After punching her, it’s probably best to avoid Riya.");
	else addButton(0,(flags["MET_RIYA"] == undefined ? "UGC Officer" : "Riya"),approachRiya);
	return false;
}

public function approachRiya():void
{
	clearOutput();
	showRiya();
	author("Franks");
	if(flags["RIYA_PUNCHED"] != undefined)
	{
		sockHerEpilogue();
		return;
	}
	var inhuman:Boolean = (!pc.isHuman());
	if(flags["MET_RIYA"] == undefined)
	{
		output("You decide to approach the officer, glancing at her nametag as you do. <i>Batra, Riya</i>.");
		if(inhuman) 
		{
			output(" The officer squints at you as you approach, one hand subtly dropping to the taser at her belt. Damn, did you commit a crime without realizing?");
			if(pc.characterClass == GLOBAL.CLASS_SMUGGLER) output(" It’s more likely than you’d think.");
		}
		output("\n\n<i>“Need help with anything, " + pc.mf("sir","ma’am") + "?”</i> She inquires cordially.");
		if(inhuman) output(" You notice, though, that her hand is still hovering near her taser.");
		
		flags["MET_RIYA"] = 1;
	}
	else output("You walk up to Officer Batra, who is patrolling the merchant deck as usual. Her watchful gaze turns to you as you approach.");
	processTime(1);
	riyaMenu();
}

public function riyaMenu():void
{
	var inhuman:Boolean = (!pc.isHuman());
	clearMenu();
	//[Talk]
	addButton(0,"Talk",talkToRiya,inhuman);
	addButton(1,"Appearance",riyaAppearance);
	//[Suspicion](Only available for nonhuman/modded PCs)
	if(inhuman) 
	{
		addButton(2,"Suspicion",riyaSuspicionTalk);
		//[Racism]Unlocks after ‘Suspicion’ has been selected’
		if(flags["RIYA_SUSPICION"] != undefined) addButton(2,"Racism",riyaRacismTalk);
	}
	//[Sex]

	if((!pc.hasVagina() || pc.isTaur() || pc.femininity <= 40 || pc.hasCock()) && flags["RIYA_BLOCKED"] != undefined) addDisabledButton(3,"Sex","Sex","You need to a normal female to pique her interest - with less than four legs.");
	else addButton(3,"Sex",sexRiyaCauseYerDumbAndDeserveToBePunished);
	addButton(14,"Leave",mainGameMenu);
}

//(ausar:’mutt’ leithan/centaur:’mule’ kathrit:’alley cat’ else:’creep’)
public function riyaNickname():String
{
	var sName:String = "creep";
	var isDogMorph:Boolean = (pc.catDog("nyan", "bork", false) == "bork");
	var isCatMorph:Boolean = (pc.catDog("nyan", "bork", true) == "nyan");
	
	if(isDogMorph) sName = "mutt";
	else if(isCatMorph) sName = "alley cat";
	if(pc.isTaur()) sName = "mule";
	
	return sName;
}


public function talkToRiya(inhuman:Boolean):void
{
	clearOutput();
	showRiya();
	author("Franks");
	if(inhuman)
	{
		//Talk(Nonhuman/modded PC)
		if(flags["RIYA_TALK"] == undefined)
		{
			output("You don’t need anything, you explain, you just wanted to make conversation. The dark-skinned security officer squints at you, brown eyes narrowing.");
			output("\n\n<i>“What, while your buddies hold up a store? Nice try, " + riyaNickname() + ". Get on your way before I decide you’re resisting arrest.”</i>");
			output("\n\nShe’s preparing to draw her handcuffs and you decide it’s not worth starting a fracas with a uniformed security officer in the middle of Tavros station. You turn, walking away without another word.");
			output("\n\nWhat an asshole.");
			flags["RIYA_TALK"] = 1;
		}
		//Talk #2:(Nonhuman/modded)
		else
		{
			output("Approaching Riya, you wave politely to get her attention, explaining that you need directions. She nods, listens silently as you describe what you’re looking for, scratches her chin in mock thought, then finally responds.");
			output("\n\n<i>“Sure thing. First you head to the elevator, take it down to the hangar, and then you go right the fuck back where you came from, " + riyaNickname() + ".”</i>");
			output("\n\nShe stares at you calmly, though you catch the edges of her mouth twitching a few times, her eyes twinkling with amusement. Realizing you’re not going to get a reasonable answer out of Officer Batra, you turn and walk away, stifling your justified anger before it boils over and gets you arrested.");
			output("\n\nHow does she get away with this shit?");
		}
	}
	else
	{
		//Talk #1(Human)
		if(flags["RIYA_TALK_HUM"] == undefined)
		{
			output("Leaning against a bulkhead next to the dark-skinned officer, you strike up a conversation with her, making idle chatter for a while before you chance onto discussing the finer points of your favorite games. It seems you’ve struck a chord - her eyes light up and she immediately launches into a detailed review of the newest VR game she’s picked up. Over the next half hour or so, she gives you a detailed and shining recommendation for the latest installment in the VRMMORPG <i>Occiyre</i> and it’s latest expansion, <i>Fury of the Ivory Lord</i>. She didn’t strike you as the nerdy type, but you’re quickly disabused of that assumption as the human woman regales you with the lore of the world of Occiyre, a world of magic and fantasy based loosely around the human medieval era.");
			output("\n\nShe spends a good fifteen minutes giving you a rundown of the game’s features. Apparently, it has an incredible amount of customization, playable races and player freedom, and - interestingly enough - the guard tells you there are no factions or quests, or even tutorials. Players are able to choose any of five hundred classes, but are only able to gain fifteen levels in any given class, up to a total level cap of one hundred.");
			output("\n\nShe continues to chatter on about the game for another thirty minutes or so, though you note that she never takes her eyes away from the crowds she’s supposed to be monitoring. Finally though, the conversation tapers off and you go your separate ways.");
			flags["RIYA_TALK_HUM"] = 1;
		}
		//Talk #2(Human)
		else
		{
			output("You begin to chatter with the officer again, asking her a few questions about her past: where is she from? What made her want to join the UGC Peacekeepers?");
			output("\n\nShe squints at you for a moment.");
			output("\n\n<i>“Lot of questions there, Steele. I was born on Earth - The region known as India, more specifically. Dad’s a freight captain, mom’s his first mate. I thought about following in their footsteps, but... Well, I did a stint in the U.G.C. Marines, and I guess I just decided I like the discipline and structure. Not to mention getting to cruise around the galaxy and get paid for it, kill all kinds of different aliens... dirty deeds, done dirt cheap. Oh, and chicks </i>love<i> the uniform. Of course, sleeping in a bed the size of a coffin, getting yelled at all the time, woken up at ungodly hours of the night for drills, and eating cat food three meals a day, that’s not so much fun.”</i>");
			output("\n\nShe shrugs.");
			output("\n\n<i>“So I compromised. Now I get paid basically the same, eat whatever the fuck I want, and play mall cop here on Tavros. Almost nobody breaks the law here, surprisingly.”</i>");
			output("\n\n<i>“So, are you the only Peacekeeper on Tavros?”</i> you ask. She scoffs.");
			output("\n\n<i>“Of course not. We help the station’s private security do patrols, send officers into nearby systems as needed, chase warrants, and formally arrest anyone station security apprehends.”</i>");
			output("\n\nCuriosity getting the better of you, you ask exactly how many peacekeepers are on the station, earning another squint from Riya.");
			output("\n\n<i>“And why do you need to know that?”</i> she says, continuing before you can reply. <i>“Ah, that’s right. You don’t.”</i>");
			output("\n\nQuickly changing the subject, you continue chatting with the officer for another ten-odd minutes before going your separate ways. She waves cheerfully as you go, clearly not holding your questions against you.");
		}
	}
	processTime(10);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//[Suspicion](Only available for nonhuman PCs)
public function riyaSuspicionTalk():void
{
	clearOutput();
	showRiya();
	author("Franks");
	output("Tilting your head curiously, you ask the dark-skinned guard a question - why is she so suspicious of you? Have you done something to earn her ire?");
	output("\n\nShe squints at you, scratching her chin idly for a moment before she responds.");
	output("\n\n<i>“You’re not human,”</i> she says simply, still squinting.");
	output("\n\n<i>“And what is that supposed to mean?”</i> you ask.");
	output("\n\nShe sighs in exaggerated exasperation");
	if(pc.tallness <= 78) output(", patting the top of your head gently.");
	else output(", patting your shoulder gently.");

	output("\n\n<i>“See, this is what I mean. I outright said it, and you still don’t get it. You’re. Not. Human. You’re an inferior race. Useful cumdump, but not much else,”</i> she says, now ");
	if(pc.tallness <= 78) output("rubbing the top of your head gently.");
	else output("rubbing your shoulder gently.");
	output(" That doesn’t make sense though, you counter. Ausar invented warp gates - if humans are intrinsically superior, why didn’t they invent them first?");
	output("\n\nStill ");
	if(pc.tallness <= 78) output("rubbing your head");
	else output("rubbing your shoulder");
	output(", Riya smiles warmly at you.");
	output("\n\n<i>“Do you wanna get tazed, " + riyaNickname() + "?”</i> You hurriedly shake your head no, and the human woman slowly pulls back the hand that had begun reaching for her belt.");
	flags["RIYA_SUSPICION"] = 1;
	processTime(10);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//[Racism](Unlocks after ‘suspicion’ has been selected)
public function riyaRacismTalk():void
{
	clearOutput();
	showRiya();
	author("Franks");
	output("How does Riya get away with her blatant racism? ");
	if(silly) output("her real-life shitposting");
	output("? It doesn’t make sense. She’s in a pretty visible position, walking patrol around Tavros station, and you find it hard to believe you’re the only person she’s treated like that. So why is she allowed to continue? Friends in high places, maybe?");
	output("\n\nRegardless of why, though... Maybe there’s something you can do about it.");
	processTime(4);
	clearMenu();
	//[Nah]
	addButton(0,"Nah",nahNoRacismShit);
	//[Report]
	if(flags["RIYA_REPORTED"] != 2) addButton(1,"Report",reportRiyaIfYouWant);
	else addDisabledButton(1,"Report","Report","You doubt you’ll get a chance to report her again.");
	//[Confront]
	addButton(2,"Confront",confrontRiyasCommandingOfficer);
}

//[Nah]
public function nahNoRacismShit():void
{
	clearOutput();
	showRiya();
	author("Franks");
	output("On second thought, no. What concern is it of yours? Let her be that way. You’ve got bigger fish to fry.");
	processTime(2);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//[Report]
public function reportRiyaIfYouWant():void
{
	clearOutput();
	showBust("");
	showName("THE\nCOMMANDER");
	author("Franks");
	output("You figure the best thing to do is go to her superior officer. After all, they might just legitimately not know about her. Maybe she’s a new transfer?");
	output("\n\nYou say your goodbyes to Riya, walking around a corner out of her sight before fiddling with your Codex, performing a brief Extranet search for the head of the Tavros station U.G.C. detachment. It takes a few minutes, but it’s public information, so it can only evade you for so long... and there it is. Commander Lorna Grence. A photo of the Commander pops up alongside her name - she’s an ausar! A surprisingly young one, considering her posting.");
	if(flags["MET_SYRI"] != undefined || flags["MET_ANNO"] != undefined)
	{
		output(" Not much older than ");
		if(flags["MET_SYRI"] != undefined) output("Syri");
		else output("Anno");
		output(", if you had to hazard a guess.");
	}
	output("\n\nWell, this is going to be interesting.");
	output("\n\nIt takes some doing to actually get in touch with the Commander’s office, but once you do they get back to you almost immediately, surprisingly. Probably the weight of the Steele family name at work. You’re offered an immediate appointment with the ausar woman, who you find sitting behind her desk in an immaculate uniform after your escort leads you to her office. She has bright blue eyes and fluffy, luxurious-looking golden fur and hair of the same color coating her head and perky ears - if not for the seriousness of the situation, you’d be extremely tempted to stroke it. She rises to shake your hand as you enter her office, ");
	if(pc.isTaur()) output("‘offering you refreshments.’");
	else output("‘offering you a seat and refreshments.’");

	output("\n\n<i>“So, [pc.name] Steele wants an interview with me,”</i> she begins, smiling warmly. <i>“I’m flattered, but I assume you’re not just here to chat me up. What’s your concern, citizen?”</i>");
	output("\n\nStraight to the point, this one. You name Riya, then go on to describe her treatment of nonhumans, noting as you talk that the Commander’s expression is growing pained. After you’re finished she sighs, ears flicking back, and begins to respond.");
	output("\n\n<i>“Ugh. I do know about Riya, yes. And as much as I absolutely hate to say it, " + pc.mf("Mr.","Ms.") + " Steele, there’s not a lot I can do.”</i>");
	output("\n\nWhat.");
	output("\n\nIsn’t Riya under her, though? Isn’t Commander Grence, well, the <i>Commander</i>? The ausar woman sighs in exasperation, rubbing her temples.");
	output("\n\n<i>“Steele, if it were up to me I’d have that dirtbag court-martialed and drummed out of the Peacekeeper Corps. It’s not up to me, though. She’s former special forces - lot of very important friends. She scratches their backs, they scratch hers. Last time I really pushed to have her punished, I was offered reassignment. It’s bullshit, quite frankly.”</i> The poor woman looks absolutely livid as she speaks despite how impressively even her voice is, her golden canine ears flat against her skull, and you imagine you’re not even hearing the half of it from the way her nails are digging into her desk.");
	output("\n\n<i>“I really am sorry, Steele. I wish there was more I could do. I can promise you that everything you’ve just told me stays between us, though,”</i> she says, taking a deep breath and removing her nails from her desk, giving you a perfect view of the deep furrows her claws have left in the wood. She sighs, poking at them with her index finger. <i>“Now, if you have any </i>other<i> comments, questions or concerns, I’ll do everything I can to help you.”</i> Her ears are still pinned back against her skull as she says this, you note.");
	processTime(15);
	flags["RIYA_REPORTED"] = 1;
	clearMenu();
	//[Snap](+5 points towards ‘Hard’ personality)((Tooltip: Give the fluffy Commander a piece of your mind. Kind of a dick move, considering that she seems every bit as angry as you do.))
	addButton(0,"Snap",snapAtRiyasComm,undefined,"Snap","Give the fluffy Commander a piece of your mind. Kind of a dick move, considering that she seems every bit as angry as you do.");
	//[Leave]
	addButton(14,"Leave",reportRiyaAndLeave);
}

//[Snap]
public function snapAtRiyasComm():void
{
	clearOutput();
	showBust("");
	showName("THE\nCOMMANDER");
	author("Franks");
	output("You point a finger at the Commander accusingly - what is the meaning of this? She’s Riya’s commanding officer, damn it, and you’d appreciate it if she acted like it instead of literally tucking her tail between her legs and letting the woman do whatever she wants. You give her a tongue lashing that lasts a good twenty seconds or so, through which the senior officer sits wordlessly. After you finish, though, you see that she looks... hurt.");
	output("\n\n<i>“Get out of my office, Steele. You clearly have no desire to understand my position,”</i> she says, pointedly looking away from you and poking at the claw marks in her desk, eyes downcast.");
	output("\n\nYou nod, fuming silently as you rise and depart the Commander’s office. It sucks, but if Riya really is that well connected, you’re going to have to find another avenue.");
	flags["RIYA_REPORTED"] = 2;
	pc.addHard(5);
	processTime(5);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}
public function reportRiyaAndLeave():void
{
	clearOutput();
	showName("THE\nCOMMANDER");
	author("Franks");
	output("You nod, fuming silently as you rise and depart the Commander’s office. It sucks, but if Riya really is that well connected, you’re going to have to find another avenue.");
	processTime(1);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//[Confront]
public function confrontRiyasCommandingOfficer():void
{
	clearOutput();
	showRiya();
	author("Franks");
	output("Squaring your shoulders, you march up to the beret-clad officer and thrust an accusing finger at her, telling her, among other things, that she’s a bigoted moron who shouldn’t be wearing a Peacekeeper’s uniform. She stares blankly at you as you chew her out, an expression of mild amusement on her face. She doesn’t interrupt though, instead waiting for you to finish, her expression remaining the same. Eventually you run out of righteous fury and choice insults alike, falling silent and fixing a hard stare on the officer.");
	output("\n\n<i>“Kay. Thing is, Steele - I can get away with it. How does that make you feel?”</i> she says, an infuriatingly smug grin spreading across her features.");

	processTime(5);
	clearMenu();
	addButton(0,"Sock Her",sockRiya);
	addButton(14,"Leave",leaveRiyaAvoidPaunch);
}

//[Sock her]
public function sockRiya():void
{
	clearOutput();
	showRiya();
	author("Franks");
	//If PC has Reflex stat above 40
	if(pc.reflexes() >= 40)
	{
		output("Enough is enough, you decide. Well... not decide, so much as give in to the rage boiling up inside you and let it find it’s way down your arm and into your fist as it rockets up towards her jaw. You connect, the feeling of your fist moving her face out of the way entirely too satisfying. You note as you pull your fist back that her hand instantly, reflexively went to her side to draw her taser. She jabs it at your stomach but you manage to dodge... just before being dogpiled by Tavros security.");
		output("\n\nRiya is quick to jump on you and cuff you then, pinning your arms behind your back as several more station security officers run up to the two of you. <i>“Bad idea, Steele,”</i> she hisses, roughly hauling you up and in the direction of the elevator with the help of the station’s security officers. It takes the better part of a standard day, but eventually you are released, somehow, with no charges filed. Turns out your dad knew some pretty impressive lawyers.");
	}
	//Otherwise:
	else
	{
		output("Enough is enough, you decide. Well... not decide, so much as give in to the rage boiling up inside you and let it find it’s way down your arm and into your fist as it rockets up towards her jaw.");
		output("\n\nYou only touch air, though - Riya is already crouched, drawing her taser, and ramming it into your gut, kicking your legs out from under you as you spasm. She pulls the taser back as you hit the deck, but before you can react she’s on top of you, pinning your arms behind your back as several station security officers run up to the two of you, helping her pin you down and cuff you.");
		output("\n\n<i>“Bad idea, Steele,”</i> she hisses, roughly hauling you up and in the direction of the elevator with the help of the station’s security officers.");
		output("\n\nIt takes the better part of a standard day, but eventually you are released, somehow, with no charges filed. Turns out your dad knew some pretty impressive lawyers. You are happy to note, as you leave the U.G.C. deck, that Riya is standing at perfect attention before a <i>very</i> angry human man wearing a Colonel’s insignia.");
		//If PC has selected ‘Report’:
		if(flags["RIYA_REPORTED"] != undefined) output(" Knowing what you know, you doubt anything meaningful will happen to her, but it’s still pretty nice to see her being chewed out.");
	}
	flags["RIYA_PUNCHED"] = 1;
	processTime(60*23);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

// Happens on next approach If PC selected ‘Sock her’
public function sockHerEpilogue():void
{
	clearOutput();
	showRiya();
	author("Franks");
	output("As you approach the human officer, you notice that she’s standing and glowering at you with her arms crossed, looking none too pleased.");
	output("\n\n<i>“Steele,”</i> she growls as you approach, <i>“Steele, Steele, Steele. Got that punch out of your system, buddy?”</i> she asks, not waiting for your reply. <i>“I hope so. Because if you do it again, I </i>will<i> get even with you, and I can assure you that’s not something you want. For now, though, stay the fuck out of my face,”</i> she says, spinning on one heel and smoothly striding away from you.");
	output("\n\nWhatever.");
	// ‘Riya’ grayed out
	flags["RIYA_PUNCHED"] = 2;
	processTime(5);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//[Leave]
public function leaveRiyaAvoidPaunch():void
{
	clearOutput();
	showRiya();
	author("Franks");
	output("Sighing, you decide it’s not worth it. Sure, as prominent and rich as you are, dad probably has something set up for you in case of legal troubles, but why give this bitch the satisfaction of filing charges against you?");
	output("\n\nYou shake your head at Riya, turning and walking away.");
	processTime(4);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}




//[Sex]
public function sexRiyaCauseYerDumbAndDeserveToBePunished():void
{
	clearOutput();
	showRiya();
	author("Franks");
	var inhuman:Boolean = (!pc.isHuman());
	//Human;
	//(If PC is male, taur, or has femininity below 40)
	if(!pc.hasVagina() || pc.isTaur() || pc.femininity <= 40)
	{
		output("<i>“Ah, normally I’d say hell yeah, but I only go for girls");
		if(pc.isTaur()) output(" with two legs");
		output(". Call me vanilla.”</i>");
		processTime(3);
		clearMenu();
		addButton(0,"Next",mainGameMenu);
		return;
	}
	//(Otherwise)
	else
	{
		output("<i>“Oh? Feeling randy, Steele? Never fear, I’ve got something </i>juuust<i> for you. Just let me check something.”</i>");
		output("\n\nThe woman proceeds to reach into her back pocket and withdraw what appears to be some sort of scanner - she flips a switch on the device and it beeps once, twice, and then covers your form in a brief flash of red light.");
		output("\n\n<i>“It’s a bioscanner. Just checking your junk, Steele,”</i> she says, peering at the device’s screen.");
		//(If PC has no genitals or a penis)
		if(pc.hasCock() || !pc.hasGenitals())
		{
			output("\n\n<i>“Ah, yeah. Sorry, [pc.name], but I don’t swing your way. Girls only,”</i> the dark-skinned officer says, stowing the scanner back in her pocket.");
			output("\n\n<i>“Good luck, though! Anon’s bar has some folks who might click with you. No hard feelings.”</i>");
			output("\n\nShe turns and resumes her patrolling, whistling nonchalantly.");
			//(‘Sex’ grays out unless PC becomes fully female)
			flags["RIYA_BLOCKED"] = 1;
			processTime(5);
			clearMenu();
			addButton(0,"Next",mainGameMenu);
			return;
		}
	}
	//(If PC is fully female)
	output("\n\nThe officer stows the scanner back in her pocket, stepping up to you suddenly, pinning your back against a nearby bulkhead and pressing her hips against yours, her voice taking on a sultry, predatory tone.");
	output("\n\n<i>“Alright, Steele, here’s how this works. You do as I say, when I say, how I say. Sound good?”</i>");
	processTime(5);
	//[Yes]
	//[No]
	clearMenu();
	addButton(0,"Yes",yesSexWithRiyaRouter,inhuman);
	addButton(1,"No",nopeOuttaSex);
}

public function yesSexWithRiyaRouter(inhuman:Boolean):void
{
	//Should tie into her ‘Sex’ button with each scene having an equal or near equal chance of proc
	//Plan is to write one vaginal(With an alternate for virgin PCs) and one oral scene to fulfill staff desire for more sex scenes before more expacs.
	//Also plan to possibly add ‘Degradation’ option involving PC more or less asking Riya to treat them like crap, but priority is to add oral and vag scenes, so degradation scene may wait until her expac on account of me writing slow as fuck
	//Fellatio scene
	if(rand(3) == 0) riyaFellatioScene();
	//Vaginal
	else if(rand(2) == 0) riyaVagigooVagitiems();
	//Buttstuff
	else yesSexWithRiya(inhuman);
}

//(If ‘No’ is selected)
public function nopeOuttaSex():void
{
	clearOutput();
	showRiya();
	output("The guard releases you without a moment’s hesitation, boredom and disappointment on her face.");
	output("\n\n<i>“Guess you didn’t really want it. Talk some other time, Steele, I got aliens to profile.”</i>");
	output("\n\nShe strides away, twirling her billy club and whistling nonchalantly.");
	processTime(3);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//(If ‘Yes’ is selected)
public function yesSexWithRiya(inhuman:Boolean):void
{
	clearOutput();
	showRiya(true);
	author("Franks");
	output("The officer grins, her rather prominent canines flashing white before she leans in and locks lips with you, less kissing and more invading your mouth with her tongue. Her organ finds yours and wrestles with it, vying for dominance as her hands slide over your [pc.ass]. She squeezes possessively before spinning you around and pressing your front into the nearest bulkhead. Grabbing your wrists, she pinning both arms behind your back with one frighteningly strong hand. You hear the quiet sound of something metal clanking against itself, and then... your wrists are firmly encased in a pair of handcuffs. Riya nips the back of your neck before pulling back, and yanking you off the wall.");
	output("\n\n<i>“You’re under arrest, Steele,”</i> the policewoman hisses into your ear. <i>“For soliciting a uniformed U.G.C. officer for sexual intercourse. You are hereby sentenced to one hard dicking, sentence to be carried out immediately.”</i>");
	output("\n\nWith that, she leads you by your cuffs to the station’s elevator, punching a code into a keypad located just inside it. The device beeps quietly as she taps the digital ‘enter’ button on the screen.");
	output("\n\n<i>“Passcode accepted. Officer Batra to U.G.C. deck,”</i> a soothing voice chimes. Riya walks back over to you, wrapping her arms around your body, and sinking her fingers into your [pc.ass], squeezing hard enough to make you squeal with delight. Her mouth finds yours again, the domineering officer sucking at your [pc.lipsChaste] while pushing you back against the wall of the elevator. Your bound hands press into the small of your back as her fingers freely roam your form, groping roughly.");
	output("\n\nAll too soon though, the elevator chimes your arrival on the detention deck and Riya slowly pulls her head away from yours. Her teeth catch your bottom lip and pull it back just far enough to hurt before releasing, her brown eyes positively smoldering as she stares you down. Spinning you so that your back is to her she takes one more mouthful, kissing the side of your neck before sinking her teeth into your [pc.skinFurScales]. ");
	//If PC has chitin/scales:
	if(pc.hasChitin() || pc.hasScales()) output(" You squeal in pain, but thanks to your hard [pc.skinFurScales], nothing is left behind but an angry, saliva-covered scratch.");
	else output(" She leaves an angry, saliva-covered mark on your [pc.skin] before marching you out of the elevator.");

	output("\n\nShe’s like a wolf with a side of meat; you can almost <i>feel</i> how badly she wants to tear your clothes off and take you right here and now, but she’s clearly restraining herself. As you pass rows of desks with uniformed officers typing away at their terminals or chattering to each other, you can see why she’s holding back. It wouldn’t do, after all, for her to be all over you like she was in the elevator; not in front of so many of her coworkers. Riya places one hand over the bite mark on the side of your neck, concealing it from her fellow officers as she marches you along. You note that her face has turned totally neutral, betraying not even a hint of the raging lust that was there just a moment ago.");
	output("\n\nEventually, you reach a closed door, which Riya promptly opens, leading you inside to a nice-sized, impeccably clean and organized office, her name and rank featured prominently on a placard on the desk that sits in the center of the room. <i>Lieutenant Batra</i>. Lieutenant, huh?");
	output("\n\nBefore you have time to take in any more details, though, you hear the sound of the lock clicking behind you, and the officer is all over you again, grabbing you by the back of the neck and the handcuffs, shoving you forward and bending you over her desk, sweeping her placard and several stacks of papers and office supplies onto the floor. ");
	if(pc.isAssExposed()) output(" She stops for a moment, admiring your lewd form before bouncing her palm off your ass. <i>“Always ready for cock, are we Steele?”</i>");
	else output("She assaults your clothes after that, roughly yanking your [pc.gear] off your body, unlocking your handcuffs to undress you before slapping them back on.");
	output(" When you’re fully helpless before her, bent over her desk, your [pc.vaginas] tingling and beading with anticipation, the dark-skinned officer begins to knead your [pc.ass] roughly, dragging her sharp nails across your [pc.skinFurScales] before slapping you <i>hard</i> with both hands, leaving glowing handprints on your cheeks.");
	output("\n\n<i>“It’s time for your cavity check, bitch,”</i> she says, bringing her hands back down on your ass and groping you carelessly. You whimper as she abuses you, her hands taking their fill of your rear as you blush fiercely. The aggressive woman doesn’t fail to notice the effect her treatment is having on you.");
	output("\n\n<i>“Like the idea of getting your ass pounded, huh? I bet this is a dream come true for you, sweetmeat.");
	if(inhuman) output(" Bent over my desk, about to take your proper place - impaled on human cock... I’m proud of you, " + riyaNickname() + ". It takes courage to come to terms with your inferiority.");
	output("”</i>");

	output("\n\nYou hear the sound of a belt unlatching, a zipper, and then the soft <i>fwump</i> of what you assume is her pants hitting the ground. You twist your neck back, trying to see what the human woman is doing, and find yourself gazing upon her slender, toned caramel legs, thighs corded with muscles that flex powerfully with every slight movement the officer makes, and...");

	output("\n\nYou swallow hard, drinking in the sight of the fat, veiny brown python hanging between Riya’s legs - it looks to be ten inches flaccid, with a set of heavy, hairless, jizz-filled nuts swinging beneath it. It would seem officer Batra is a shower. For your asshole’s sake, you hope she’s not a grower too. You’re on the road to finding out though. The woman reaches into her discarded pants and withdraws a bottle of clear lube, popping the cap open and pouring it into her palm while smiling knowingly at you, her eyes burning into yours.");

	output("\n\n<i>“That’s right, buttslut. Ten inches of fat human dick, just for you,”</i> she says, smearing a copious amount of lube onto her prick and stroking herself to half-mast, her fat brown cock pulsing visibly. <i>“You’re gonna be walking funny when I’m done with you, and you’re going to thank me for it.”</i>");

	processTime(35);
	pc.lust(100);
	clearMenu();
	addButton(0,"Next",yesSexWithRiya2,inhuman);

}

public function yesSexWithRiya2(inhuman:Boolean):void
{
	clearOutput();
	showRiya(true);
	author("Franks");
	output("You swallow nervously, jumping a bit as her fingers make contact with your pucker, the caramel woman pushing her lubed up fingers relentlessly into your bowels. Two of her digits spread your [pc.asshole] open as she coats your insides with lube, stopping after a few seconds to pour more onto her fingers, and pushing that up inside you too. <i>“Never let it be said that I don’t take care of my bottoms, Steele. After all, we can’t have that pretty little asshole of yours tearing, can we?”</i>");
	//If PC has self-lubricating bunghole:
	if(pc.ass.wetness() > 0) 
	{
		output(" After a moment though, it becomes clear to both of you that her concern is entirely pointless. Her fingers slide easily into your depths and she gives a grunt of surprise, withdrawing them before speaking.");
		//If PC is nonhuman:
		if(inhuman) output(" <i>“I appreciate it when a bitch knows their purpose in the galaxy is taking human cock up the ass,”</i> she says, reaching around your body to slap the side of your face, shame flushing your features.");
		else output("<i>“You’ve got one of those self-lubing assholes, Steele? Fancy.”</i>");
	}
	output("\n\nWithout further ado, she lines her half-hard prick up with your hole, her lube-coated right hand guiding her tunnel snake in while her left hand reaches up, lightning quick, to come around your neck and close over your throat. She leans in, tightening her grip enough to leave you struggling to breathe, and bites one of your [pc.ears], drawing a pained whine from your lips as she tugs back on the ear briefly before releasing it. Riya leans in again to brush her lips against you, releasing your throat enough to allow you to breathe again.");

	//Buttchange check
	pc.buttChange(400);

	output("\n\n<i>“You’re my bitch now.”</i>");
	output("\n\nWith that, before you have a chance to reply, she starts forcing her way into your bowels, pushing her cock relentlessly forward, the half-mast monster splitting your ass open and forcing a howl of equal parts pleasure and pain from you. She shows no mercy, though, and between the incredible pressure her hips are exerting on your tailpipe and the copious amount of lube she’s slathered all over her prick and your asshole, your body has no choice but to accept the intrusion. Finally though, her balls tap against your [pc.vaginas] and you have a moment to catch your breath - only a moment, though. Riya immediately begins pulling out of your colon, the feeling of her hot and now rock-hard prick claiming your intestines slowly receding, leaving you feeling... empty. Wanting. Riya, meanwhile, sinks her teeth into the back of your neck again and closes her hand around your throat, choking and biting you while pulling back from your abused backdoor enough to leave just the tip in. Of course, it doesn’t stay there. The officer gives you not even a moment’s respite before forcing her way back in using short, pummeling thrusts that leave your hands clutching empty air, unable to even grip the desk for support thanks to the U.G.C. regulation handcuffs holding your wrists behind your back.");
	output("\n\nHer balls slap into your soaked [pc.vaginas] again and again as she picks up steam, the office filling with the sounds of her body slapping against yours, ");
	if(pc.biggestTitSize() < 1) output("your nipples rubbing torturously against the wood");
	else output("the desk under you creaking as your [pc.breasts] are squished against the wood");
	output(", the brown officer reaching up with her free hand to cuff your face lightly.");

	output("\n\n<i>“Having fun, buttslut?”</i> she asks, releasing her teeth and tightening her grip around your throat for a moment, panting heavily. You’re both close, now - you can feel her breath hot and moist on your neck, your [pc.vagina] clenching, leaking your arousal onto her nuts and down your legs every time they batter against your sex. Riya releases your throat just as your vision begins to dim, and you suck in huge, greedy gulps of air as the domineering woman continues to rail you She rises to a standing position and moves her hands to your [pc.hips], sinking her nails into your [pc.skinFurScales].");
	output("\n\n<i>“Ready, bitch? Ready for me to cum in your guts?”</i> she asks, panting lightly. <i>“Here! It! </i>Comes!<i>”</i>");
	output("\n\nEach word is punctuated by a full length, jackhammer thrust into your stretched out intestines, her hands briefly leaving your sides to bring her palms down on your [pc.butt] hard as she hilts herself in your [pc.asshole] one final time. Grunting animalistically, her balls slap loudly against your sodden twat");
	if(pc.totalVaginas() > 1) output("s");
	output(". You feel her cock twitching and swelling inside you, and then your legs go weak as you feel her seeding your backdoor, hot jizz pumping into your abused rectum for what feels like a blissful eternity. Your [pc.vagina] clenches hard, leaking your orgasm down your thighs.");
	output("\n\nFinally though, Riya’s cock tapers off, the spray of ball-batter being pumped into your guts subsiding. The human stays hilted in you for a few more minutes though, leaning down and resting her head on your upper back, her heavy tits dragging over your back as she sighs contentedly. <i>“Fuck, that was nice,”</i> she says after a while, running her fingers up and down your body surprisingly gently, considering the brutal fuck she just handed out to you.");
	output("\n\nAfter a few minutes, the woman gets up, turning your head to the side and planting a wet smooch on your cheek before finally pulling out of your bowels, your legs shuddering at the sensation of her long, flaccid prick being dragged through your intestines as her seed leaks down your legs. She chuckles at your reaction and makes her way around her desk, opening a drawer and withdrawing two small towels. She lifts her arm to toss one to you, but seeing the state you’re in and presumably remembering that she hasn’t uncuffed you, she grins smugly and walks back around the desk, dabbing the sweat and mixed sexual fluids off your body and cleaning her own loins before helping you back into your gear, uncuffing and recuffing you as necessary. From there, she helps you to your feet, puts her own clothes back on, and marches you back through the rows of cubicles.");
	if(flags["RIYA_FUCKED_YA"] == undefined) 
	{
		output("\n\nYour face flushes suddenly as you realize how loud you two were being. Surprisingly enough though, none of the officers say anything, though one or two of them smirk or snicker knowingly as you pass, your dusky-skinned escort wearing the same emotionless mask as when she first marched you in. Once you’re in the elevator again with Riya punching in her passcode with her torso blocking your view, she explains, apparently having sensed your curiosity.");
		output("\n\n<i>“My office is soundproofed. So, I can rail that sweet ass of yours as loud as I fucking want, and nobody will ever hear. Of course, my colleagues aren’t stupid - the human ones, at least - so most of them know what I get up to in there anyway.”</i>");
		output("\n\nSo why hasn’t she gotten in trouble for it, you wonder aloud.");
		output("\n\n<i>“That, Steele,”</i> she says, turning to spin you around so that your back is facing her, unlocking your cuffs, <i>finally</i>, and stowing them back on her belt as you massage your incredibly sore wrists, <i>“is for me to know, and you to wonder.”</i>");
		output("\n\nAlmost as if on cue, the elevator beeps and opens to allow the two of you to depart. Riya sends you off with a slap on your [pc.ass] and a toothy smile, turning to resume her regular duties.");
	}
	else
	{
		output("\n\nAs always, none of the officers seem to take any notice of you as you and Riya depart the U.G.C. level, aside from a few knowing smirks and snickers. Once in the elevator, the woman punches in her access code and uncuffs you, making idle chitchat as the two of you ascend to the merchant deck.");
		output("\n\nEventually, the elevator beeps and opens to allow the two of you to depart. Riya sends you off with a slap on your [pc.ass] and a toothy smile, turning to resume her regular duties.");
	}
	IncrementFlag("RIYA_FUCKED_YA");
	processTime(45);
	var pp:PregnancyPlaceholder = getRiyaPregContainer();
	pc.loadInAss(pp);
	pc.orgasm();
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}


//Should tie into her ‘Sex’ button with each scene having an equal or near equal chance of proc
//Plan is to write one vaginal(With an alternate for virgin PCs) and one oral scene to fulfill staff desire for more sex scenes before more expacs.
//Also plan to possibly add ‘Degradation’ option involving PC more or less asking Riya to treat them like crap, but priority is to add oral and vag scenes, so degradation scene may wait until her expac on account of me writing slow as fuck

//Vaginal
public function riyaVagigooVagitiems():void
{
	clearOutput();
	showRiya(true);
	author("Franks");
	var race:String = pc.raceShort();
	var isDogMorph:Boolean = (pc.catDog("nyan", "bork", false) == "bork");
	var isCatMorph:Boolean = (pc.catDog("nyan", "bork", true) == "nyan");
	output("Riya smirks, reaching around the back of your head, pulling you in, and setting her teeth against your neck, making you squeal as she sinks them into your [pc.skinFurScales]. She pulls back after leaving an indent in your throat, gazing into your eyes hungrily. <i>“Alright, Steele. You want some of this? You got it,”</i> she says, using her grip on your neck to spin you about and herd you quickly into the elevator, where she grabs your wrists and deftly cuffs them behind your back.");
	output("\n\nShe spins you around, meeting your eyes as her right hand ");
	if(!pc.isCrotchExposed()) output("slips into your [pc.lowerGarment]");
	else output("journeys down your belly");
	output(", fingers skillfully toying with your clit");
	if(pc.totalClits() > 1) output("s");
	output(", spreading the lips of your [pc.cunt] apart as she starts to tease you with surprising gentleness. Hell, she knows what she’s doing too! Your thighs quiver, legs shaking slightly as she explores your insides with her hand while her thumb stays outside to caress your clit. She pushes you back up against the elevator wall, your [pc.vagina] leaking fluid all over her digits as she plays with your naughty bits, a smug smile playing across her sharp features as she watches your face redden and listens to your breathing get heavier.");
	output("\n\n<i>“It’s always such a joy watching my bottoms squirm. The facial expressions, the panting, the whining... Putty in my hands,”</i> she says idly, eyes still boring sensually into yours.");
	//PC is ausar/huskar/dogmorph with tail:
	if(isDogMorph && pc.tailCount > 0) 
	{
		output(" <i>“The tail wagging, in your case. You mutts are adorable as far as aliens go, you know that?”</i> she says, scratching behind your ears vigorously. <i>“Who’s a good puppy? Is it you? </i>Is it yoooou?<i>”</i> you open your mouth to protest this demeaning treatment, but all that comes out is a happy whine as she switches to massaging that spot behind your ears you can never quite get to, snickering loudly as she does. <i>“Putty in my hands.”</i>");
		if(silly) output(" She crows as one of your legs thumps against the deck uncontrollably.");
	}
	output("\n\nAll too soon, the elevator ride ends and Riya is marching you past rows of desks filled with U.G.C. officers of every shape and size, a few of them glancing up as you pass, one or two smirking knowingly at you. Riya’s face is stone-like, betraying none of the raging lust she was showering you with just moments ago. That changes as soon as the two of you enter her office though, the door closing and being locked before Riya resumes her assault on your body. She’s all over you, grabbing you by the throat and throwing you onto the floor, repositioning your head so that your face is down, pressed into the carpet and held there.");
	if(!pc.isCrotchExposed() && !pc.isChestExposed() && !pc.isAssExposed()) output(" She divests you of your gear rapidly, uncuffing you and tossing the restraints off to the side.");
	else output(" She runs her fingers over your bare form slowly, groping and playing with your body as she pleases, removing your cuffs and tossing them off to the side.");

	output("\n\nA moment passes, during which you hear the soft noises of Riya’s uniform and underwear hitting the carpet followed by the sound of a bottle opening, and then you jerk in surprise as you feel something <i>cold</i> being pushed into your [pc.vagina] - lube, it must be.");
	//If PC is not virgin and has looseness rating of 3 or above:
	if(!pc.vaginalVirgin && pc.vaginas[0].looseness() >= 3) output(" <i>“There you go, slut. Not that you really need it. You must be Naughty Wyvern’s favorite customer - or Beth’s favorite earner.”</i>");
	
	//If PC is vaginal virgin(By which I mean complete virgin, not just intact hymen)
	if(pc.vaginalVirgin)
	{
		output("\n\nRiya’s fingers probe deeper into your [pc.cunt], spreading your folds around her fingers as she works more lube into you - that is, until her fingers hit the barrier of your hymen. She grunts in surprise, releasing your head and rolling you over onto your back. <i>“You didn’t tell me you were a virgin, Steele,”</i> she says, an entirely different kind of lust in her eyes now. <i>“You should have. I would’ve set up something nice for you. I’ve got something of a soft spot for first timers.”</i>");
		//PC is nonhuman:
		if(race != "human") 
		{
			output(" She reaches up and tweaks your nose, cuffing your cheek afterwards. <i>“Human or not.”</i> You look at her askance - doesn’t she think nonhumans are inferior?");
			output("\n\n<i>“Yeah, but I’ve got a soft spot for virgins, like I said,”</i> she says, going back to lubing you up. That works, you suppose.");
		}
		output("\n\n<i>“Anyway, in lieu of a candlelight dinner and a path of rose petals leading to my bedroom, here goes!”</i> she says cheerily, climbing on top of you and positioning the head of her already rock-hard member at the lips of your [pc.pussy]. She leans down and locks lips with you, pushing her tongue into your mouth and wrapping it around yours, wrestling your organ into submission. Her left hand is still busy at your unclaimed cunt, while her right comes up your body, nails dragging along your ribs to rest on your [pc.chest], ");
		if(pc.biggestTitSize() >= 2) output("kneading the orb");
		else output("tweaking your [pc.nipple]");
		output(" sensually, lovingly even, as she breaks her kiss.");
		output("\n\n<i>“Isn’t this a bit out of character for you?”</i> you ask. She chuckles.");
		output("\n\n<i>“Maybe. Don’t really give a shit. I said we’re doing this my way, and we are.”</i>");
		output("\n\nThat being said, she pushes forward with her hips slightly, guiding her cock into you, spreading the lips of your [pc.pussy] for the very first time. She pushes in slowly, the look on her face telling you that she’s savoring every moment of this. She stops, though, as the head of her cunt-stuffer prods your hymen, leaving you to acclimate to the feeling of your first cock spreading you so very <i>wide</i>, your breath coming slightly ragged as she prepares to take you. A moment passes, you close your eyes and brace yourself, and... nothing. You open your eyes to the sight of Riya gazing smugly down on you, her right index finger lazily tracing around your areola while her left elbow props her up, her bare breasts hanging enticingly above your ");
		if(pc.tallness < 73) output("face, pebbly dark nipples almost brushing your [pc.lips].");
		else output("chest, coal-black nipples brushing your [pc.chest], sending dual electric currents to your brain.");

		output("\n\nMaybe she wants you to suck them? You crane your head ");
		if(pc.tallness < 73) output("up");
		else output("down");
		output(" to take one of her juicy nipples into your mouth, but she shakes her head lazily, smiling. <i>“Not what I want, Steele,”</i> she drawls, left hand scratching your scalp. <i>“I want you to prove you want this,”</i> she continues, leaning in to whisper into your ear. ");
		if(isDogMorph) output("<i>“Bark. And" + (pc.tailCount > 0 ? " wag your tail, and" : "") + " beg like a good doggie. And then you can tell me how bad you want to be brought to heel.”</i>");
		// PC is Kaithrit:
		else if(isCatMorph) output("<i>“Meow for me. And purr. Then I want to hear what a nice pussy you are, and how bad you want me to pop your pussy, </i>pussy<i>.”</i>");
		else if(race == "human") output("<i>“Beg. Tell me how honored you are that I’m your first, and how bad you want me to bust a nice, virile nut up your cunt.”</i>");
		else output("<i>“Beg. Tell me how lucky you are that a human wants to pop your cherry, and that you hope I’m kind enough to fuck you again after this.”</i>");

		output("\n\nWhat? This is degradin-... It occurs to you suddenly that you were really dumb to expect it not to be. You hesitate, though, despite how horny, how <i>ready</i> you are. You’re rich, somewhat famous; do you really need to debase yourself just to catch some dick? No... but as Riya sighs theatrically and starts to pull out, you realize you <i>want</i> to. Whatever it takes. Why else would you put yourself here, ");
		//PC is nonhuman: 
		if(race != "human") output("with someone you know for a fact thinks you’re inferior to them?");
		else output("knowing how rude and crude Riya is?");

		output("\n\n And so, just as the head of her magnificent brown beast of a cock is starting to leave your body, ");
		//PC is ausar/huskar/dogmorph:
		if(isDogMorph) output("you bark. Quietly and shamefully at first, but when Riya stops pulling out and stares at you expectantly you bark again, just the tiniest bit louder. She leers at you. <i>“I can’t hear you, slutpuppy. </b>Bark.<b>”</i> she orders, her cock shifting just a tiny bit further into your body, taunting you. You bark again, louder, and again, and again, your [pc.tails] shifting side to side rapidly, thumping against one of the legs of her desk as your yipping increases in volume - you wouldn’t be surprised if her fellow officers can hear the commotion outside. Is it just you, or is Riya getting harder inside you...? <i>“Good dog. Now beg,”</i> she continues, shifting forward so that her cock is touching your hymen again, so tantalizingly close... and you beg. You’ve already come this far, why stop now? You beg Riya to pop your cherry, to train you to be a loyal and obedient doggie, among other things.");
		else if(isCatMorph) output("you meow. At first it’s a quiet, pitiful sound, but when Riya stops pulling out and leers at you, an expectant look in her eyes, you do it again, louder and clearer. She pushes in a bit more, then stops again and looks at you. <i>“Well?”</i> she asks, that infuriatingly smug grin of hers crawling across her features. But still, you purr as ordered, telling Riya what a good kitty you are and how badly you want - how badly you <i>need</i> her to take you, to make you hers, among other things.");
		// PC is human:
		else if(race == "human") output("you beg. At first you’re quiet and hesitant, almost whispering as you ask her to take you, but when she shifts her hips forward a few centimeters and grins expectantly at you, pinching your left nipple between her thumb and index finger. Her ministrations draw a squeal from your [pc.lips] and you increase the volume, face flushing, telling her in no uncertain terms that you <i>need</i> her inside you, filling you with hot, hard cock and thick, creamy white seed...");
		else output("you beg. Hesitantly and shamefully at first, but increasing in volume as she pushes just a tiny bit deeper into your [pc.vagina], bumping the head of her prick into your hymen again, promising to fill you if you’ll just ask like you mean it, like you really want it - which you do, howling now how badly you need her inside you, pounding you, pumping her steaming nut up into your womb.");

		output("\n\n<i>“See Steele, was that so hard? All you had to do,”</i> she says, pressing a bit harder on your hymen, eyes fixed on your face, <i>“was admit that you belong to me. That you belong under me,”</i> she crows, leaning down and pecking you on the lips. <i>“This part hurts, pet. Hold still,”</i> she continues, and then you see her hips push forward, feel something inside you <i>rip</i>. Your head snaps back against the carpet, eyes watering suddenly at the intense pain. You lie like that for a few moments with Riya motionless inside you, cradling your head in her left arm, before she starts to move again, slowly, rocking back and forth, easing herself deeper into you with every thrust, spreading your previously untouched flower around her member. Even as gentle as she’s being though, you still find yourself wincing and gasping at the sheer size of her as she splits your [pc.vagina] open, burying ");
		if(!silly) output("her trouser snake");
		else output("the thickest oak tree in the forests of dickland");
		output(" in your body.");
		pc.cuntChange(0,400);

		output("\n\nShe guides your head to her chest then - <i>now</i> she wants you to suckle her, it seems. You do, of course, wrapping your [pc.lips] around a dark, pebbly nipple and dragging your [pc.tongue] over it, drawing a soft moan from the shemale above you. ");
		if(isDogMorph) output("<i>“Good dog,”</i> she coos, petting the top of your head and scratching between your ears.");
		else if(isCatMorph) output("<i>“Good kitty,”</i> she coos, petting the top of your head and scratching between your ears.");
		else output("<i>“Good girl,”</i> she coos, petting the top of your head.");
		output(" She starts picking up the pace then, her hips slapping off yours with the kind of easy, powerful grace that can only come from hours and hours of practice. You purse your lips, suckling gently at her breast, doing your best to pleasure Riya as she pounds you into the carpet, every thrust of her hips sending shockwaves through your form - she’s not being quite so gentle as she was when she initially took your virginity, not at all. Her nipple pops out of your mouth despite your best efforts and you lean your head back into the carpet, wrapping your legs around Riya’s hips, looking up to see her shapely brown tits bouncing in time with her thrusting.");
		output("\n\nYou’re close now - every long, powerful stroke Riya delivers to your [pc.vagina] sends lightning coursing through your form, ");
		if(pc.biggestTitSize() > 1) 
		{
			output("your [pc.chest] jiggling and bouncing enticingly. The dusky officer grabs a handful of titty with her right hand and kneads it possessively, tweaking your nipples expertly as ");
		}
		output("her balls slap off your [pc.ass]. Your domineering lover’s expression is one of intense focus, though. She continues to rail you, toying with your body, until finally you feel an orgasm coming at you like a tidal wave, crashing down on you and sweeping you away. Your body seizes up, back arching, your ");
		if(pc.biggestTitSize() < 1) output("chest");
		else output("breasts");
		output(" pressing up into Riya’s heavenly soft bosom, the human woman continuing to turn your cunt inside out as your walls clench around her, your sex rhythmically massaging her fat brown anaconda as it kisses your cervix. You’re too blissed out to be doing much of anything besides cumming around Riya’s ");
		if(!silly) output("cock");
		else output("throbbing meat wand");
		output(", but your body knows exactly what it’s about - you’re writhing and pulling Riya further into you with your legs, acting with no input from your brain, entirely on instinct.");

		output("\n\nInstinct that <i>demands</i> that you let this magnificent specimen dump her seed into your hot, needy depths. Riya seems to be trying to resist cumming, biting her bottom lip so hard you’re afraid she’ll start bleeding, but it’s no use. You see her eyes roll up into her skull as she hilts in you one last time, feel her prick swell inside you, and then the first jet of her seed slams directly into your womb, triggering another orgasm on the heels of your first, your mouth working soundlessly as Riya grunts, her lower abdomen flexing visibly as she pumps you full of hot, virile seed. It feels like she cums into you forever, planting her essence in your deepest reaches. But all things must come to an end, and so too does her orgasm, tapering off until one last, powerful jet of jizz shoots into your ovaries, Riya’s ");
		if(!silly) output("cock");
		else output("100% all-beef thermometer");
		output(" starting to soften inside you.");

		output("\n\nThe dark-skinned human starts to pull out, leaving your well-fucked body quivering as her ");
		if(!silly) output("cock");
		else output("throbbing meat truncheon");
		output(" drags through your still-sensitive box, parting ways with your sex with a lewd, wet noise as your sweat-slick bodies glide off each other. Riya stands, stretching luxuriously and reaching down to grab your hand, pulling you easily to your [pc.legs]. She grins, looking you up and down, then focuses her attention on the ground. <i>“You bled on my carpet, Steele,”</i> she says, pointing - sure enough, there’s a small bloodstain on the otherwise tan rug, where you and your partner were just entangled in coitus.");
		output("\n\n<i>“Totally worth it, though,”</i> she continues, waltzing over to her desk, rummaging around inside and tossing you a towel, cleaning her sweat-glistening form off with a second one. <i>“Hope you had fun, [pc.name]. Next time I won’t be so gentle,”</i> she says teasingly, dressing herself and picking her handcuffs off the floor. She grabs you after you’ve dressed, spins you around, and handcuffs your wrists behind your back. Then the two of you are on your way, marching back through the rows of desks, only to be stopped by a tall, slim ausar officer with rich, chestnut brown fur with black patches. She smirks knowingly at you and Riya, planting an arm on the elevator door, blocking your path.");
		output("\n\n<i>“Some kind of interrogation that must’ve been, eh ell-tee?”</i> she drawls, amber eyes twinkling. Riya returns the grin, leaning in until her face is almost touching the other woman’s. <i>“Yup. Just like your promotion board, sergeant.”</i>");
		output("\n\nThe ausar’s ears pin back against her skull, her face flushing bright red as she stutters out a response - something about how she earned that promotion, and anyone who says otherwise is a damn liar. You barely hear though, as your escort is shuffling you into the elevator and closing it, still smirking.");
		output("\n\n As the two of you ascend, Riya lazily gropes your [pc.ass], unlocking your cuffs one-handed. <i>“Fuck, it’s been too long since I’ve done that. Thanks, Steele,”</i> she says, her hand withdrawing your ass only to deliver a resounding <i>smack</i>, the officer blowing you a kiss as the elevator opens and the two of you begin to part ways. <i>“Catch you later, slut! Try not to trip and land on a cock, now!”</i>");
		processTime(35);
		pc.orgasm();
	}
	//PC is not virgin
	else
	{
		output("\n\nRiya’s fingers probe deeper into your [pc.cunt], spreading your folds around her fingers as she works more lube into you until your warm cunny is ready to go, making sure to brush them over your clit on their way out. The domineering dickgirl grunts in satisfaction, wiping the leftover lube off onto your rump. <i>“Ready to get your clam slammed, fuckmeat?”</i> she says, ");
		//PC does not have tail:
		if(pc.tailCount == 0) output("slapping your [pc.ass] roughly and gripping your thighs, angling your rear up.");
		else output("yanking your [pc.oneTail] up roughly, drawing a pained squeal from your lips.");
		output(" <i>“Face down, ass up. The way you belong,”</i> she barks, slapping her swollen caramel cock down into the cleavage of your [pc.ass] and hot dogging you lazily, grinding her length back and forth for a few moments, her fuckstick gliding easily between your asscheeks. She kneads your buns possessively, eventually sinking her nails into your [pc.skinFurScales] and pulling back, slapping her prick against your thighs a few times before shoving your legs apart. You feel something press into your [pc.cunt], spreading your lips around it, and Riya’s left hand comes down beside your head, the pressure steadily increasing, your teeth unconsciously worrying your bottom lip...");
		//PC has looseness of 3 or above:
		if(pc.vaginas[0].looseness() >= 3) output(" Riya’s cunt-stuffer plunges into your waiting depths, your well-practiced cocksleeve devouring her boner.");
		else output(" Riya’s monster of a cock invades your body, her caramel python spreading your tight cunny from a slit into a perfect, cock-swallowing ‘O’.");
		pc.cuntChange(0,400);

		output("\n\nShe’s got to be at least halfway in, and with no concern for your enjoyment, she just keeps feeding you dick - at least she took the time to lube you up beforehand. She’s already setting a rhythm though, grunting animalistically as her right hand comes down on the other side of your head, her torso resting heavily on your back, pinning you to the carpet. ");
		if(race == "human") output("<i>“You like this, bitch? Pinned and bred, the way you were meant to be.”</i>");
		// PC is ausar/huskar/dogmorph:
		else if(isDogMorph) output("<i>“Having fun, slutpuppy? Hell, maybe I’ll give you a litter of half-human pups, improve your bloodline!”</i>");
		// PC is kaithrit: 
		else if(isCatMorph) output("<i>“Enjoying yourself, pussy? I’d bet my next paycheck this is better than those nu-males on your homeworld. Shit, maybe I’ll even give you some half-human kittens to improve your genes!”</i>");
		else output("<i>“Like how human cock feels? Hell, I might even give you a kid to improve your genetics if you behave.”</i>");

		output("\n\nShe takes her hands off the rug then, instead looping her left arm around your throat, forcing your head back and painfully constricting your windpipe while her right hand pushes your hips down, leaving you prone on your belly, gasping for air as Riya’s hips hammer into your ass, her cock driving in to the hilt on every thrust. Her office is full of the sounds of the savage mating you’re receiving, the caramel shemale above you fucking you without any apparent care for your comfort or desires. Still, though... it feels <i>right</i>, somehow - being here, Riya’s weight pinning you down, her hips fucking you into the floor like the bottom bitch you are. Your mouth hangs open, working soundlessly as Riya plunders your insides, her beautiful prick spreading your sex around it, reforming your innards into a perfect mold of her dick. ");
		if(race != "human") output("<i>“You get it now?”</i> she hisses into your ear, <i>“You’re a walking, talking hole for me to fuck. A warm, wet sock. The sooner you accept that, the better off you’ll be.”</i> ");
		output("She groans as she takes her pleasure of you, railing your helpless form mercilessly, and hard enough that you can see her desk rattling out of the corner of your eye.");
		output("\n\nShe continues like this for what feels like hours, the occasional droplet of sweat falling from her to land on you, the intense exertion otherwise seeming to take no toll on her incredible stamina - meanwhile, you can already sense that you’re going to be sore after this, if not walking funny. You can feel your orgasm building steadily, mounting to an inexorable crescendo in spite of Riya’s brutal, uncaring pummeling of your [pc.vagina]. Or perhaps <i>because</i> of it? You still can’t quite shake the feeling of rightness that subsumed you earlier, the feeling that this is where you truly belong and what you truly are; a fleshy, welcoming cunt begging to be filled. Again, and again, and again, hard and fast and... Your breath catches suddenly as Riya gifts you a particularly deep thrust, and the orgasm you felt building becomes a symphony of ecstasy. Your [pc.legs] shiver and jerk suddenly as your cunt flexes, constricting instinctively, rhythmically around the turgid hammer of a cock slamming into you from behind, giving you something you needed more than you ever knew until now.");
		output("\n\nRiya gasps, her powerful arm flexing across your windpipe as your body tries to milk hers for its alabaster bounty. The mental image of her seed being pumped directly into your womb flashes unbidden into your lust-addled mind, a ragged howl of pleasure tearing out of your mouth as what’s left of your mind succumbs to the all-consuming inferno of arousal blazing through you. You’re not sure when you come down; all you know is that when you do, Riya’s elbows are planted in the rug next to your ears, her full, shapely breasts resting on either side of your head. She’s still fucking you somehow, your tongue lolling nervelessly out of your slack jaws as your tenderized bitch-hole is plugged. Every movement she makes, every thrust and shift of her body against yours is amplified tenfold thanks to how sensitive you are in the wake of your explosive orgasm. Riya is close too, you can tell, every body-shaking thrust she delivers drawing another moan out of her. Her thrusting suddenly takes on an erratic, frenetic pace, the caramel futa grunting as her cock swells within you, her balls tightening, pulling up against her shaft.");
		output("\n\nYou feel her member pulse, and then the first thick, hot splash of seed hits your innards, setting off another orgasm on the heels of your first. Your eyes roll up halfway into your skull, your [pc.toes] curl,");
		if(pc.tailCount > 0) output(" [pc.eachTail] twitches madly,");
		output(" and your body tenses and shudders beneath Riya as your mind blanks out with pleasure for the second time in nearly as many minutes. She continues to fill you, jet after steaming jet of ball-batter filling your womb, seconds turning into hours in your mind until she finally begins to taper off, her rod withdrawing from your body slowly, your legs shaking involuntarily as it drags across your oversensitized nerves. There’s a lewd, wet ‘pop’ as she leaves your body, the sound of her breathing heavily with exertion, then the sound of a drawer opening. You look up groggily and spy her slinging two towels over one of her shoulders, a bottle of water in each hand. She makes her way back over to you, nudging your ribs with her toes. <i>“Get up, slutmuffin. Drink some water,”</i> she says, setting a bottle and towel down next to you and beginning to towel herself off.");
		output("\n\nYou stretch, shaking off the comfy post-coital daze encompassing you and start to get to your feet, only to stumble and fall on your [pc.ass], Riya bursting into uproarious laughter. She regains her composure after a moment, sitting down next to you. <i>“I’m not giving you time to recover, you know,”</i> she gloats sipping her water and grabbing her boxers, wiggling back into them. <i>“You’re going to be limping on your way out of here, and everyone is going to know why. Now get your sexy ass dressed, and let’s get moving.”</i>");
		output("\n\nShe’s right, too; on your way back to the elevator, you hear a chorus of quiet snickering as you hobble past the rows of desks, cum slowly leaking from your fuckhole. The two of you make small talk as you ascend, your cheeks colored in embarrassment, Riya’s familiar shit-eating grin plastered across her face. The elevator opens after a bit, and the dusky shemale punches your shoulder as a farewell before beginning to march off.");
		output("\n\n<i>“See you some other time, Steele!”</i>");
		processTime(40);
		pc.orgasm();
	}
	var pp:PregnancyPlaceholder = getRiyaPregContainer();
	pc.loadInCunt(pp,0);
	IncrementFlag("RIYA_CUNTPOUNDED_YOU");
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//Fellatio scene
public function riyaFellatioScene():void
{
	clearOutput();
	showRiya(true);
	author("Franks");
	var race:String = pc.raceShort();
	var isDogMorph:Boolean = (pc.catDog("nyan", "bork", false) == "bork");
	var isCatMorph:Boolean = (pc.catDog("nyan", "bork", true) == "nyan");
	output("Riya grins, gripping your chin between her thumb and index finger and pulling you in for a kiss. Of course, Riya being Riya, it’s less a kiss and more an invasion of your mouth, her tongue finding yours and attempting to wrestle it into submission. She breaks the kiss, teeth catching your bottom lip and pulling it back a bit and releasing it, letting the soft flesh snap back into place. After that, she hooks her thumb into your mouth, yanking you along by the cheek towards the nearest public restroom. She nudges the door open with her foot, peeking inside to make sure it’s empty before kicking it all the way open and pulling you inside, herding you into an open stall and closing the door, sliding the bolt shut. ");
	if(pc.exhibitionism() < 33) output("A bathroom stall? Won’t people hear you?");
	else output("A bathroom stall? The thought of someone hearing you getting it in a public restroom sends a small shiver through your body.");

	if(race == "human") output("<i>“Get on your knees and beg for this dick, Steele. Like you mean it.”</i>");
	else if(isDogMorph) output("\n\n<i>“Get on your knees and beg for your bone. I want to hear you whine like a good mutt.”</i>");
	else if(isCatMorph) output("\n\n<i>“Get on your knees and purr for me like a good kitty. I’ll have some fresh, warm milk for you soon.”</i>");
	else output("\n\n<i>“Get down there and beg for human cock, alien. Might be I’m feeling generous.”</i>");

	if(pc.exhibitionism() < 33) output("\n\nYou obey, dropping down and begging meekly for the domineering dickgirl to use you, to fill your mouth with hard cock.");
	else output("\n\nYou obey eagerly, dropping down, your voice ringing out in sultry need as you beg your hung partner to stuff her meat down your throat, to force feed you her ball-batter straight from the tap. The thought of someone hearing your whorish pleas or even peeking over the top of the stall to watch you sucking dick in a bathroom makes your cunt wetter every second.");
	output(" She just grins, unbuckling her belt and working her thumbs into the waistline of her pants, pulling them down to reveal her plain white boxers. They come down in short order too, letting her fat, soft chocolate cock flop in front of your face, the officer shifting her hips forward, gripping her tool with one hand and slapping your cheek with it, hard.");

	output("\n\nThe sound fills the bathroom for a brief moment and your cheek stings from the impact - not to mention the humiliation (and arousal) you get from being slapped across your face with a juicy prick. She pulls back again and you flinch instinctively, drawing a chuckle from the sadistic woman. <i>“Aww, ");
	// PC is human: 
	if(race == "human") output("is the cockshock setting in? I know it’s scary being up close and personal with something as big as my dick. I don’t give a shit, don’t get me wrong. But I know.");
	//PC is ausar/huskar/dogmorph: 
	else if(isDogMorph) output("is puppy’s widdle feewings hurt? Is she gonna tuck her widdle tail between her legs and cry?");
	// PC is kaithrit: 
	else if(isCatMorph) output("is kitty scaaared? I guess that’s why they call you <i>pussy</i>cats.");
	else output("is the little alien bitch nervous? In over her head? Is this too much cock for you, you dumb little slut?");
	output("”</i>");

	output("\n\nShe sends her cock swinging into your face again - and again, and again, the rod of mocha flesh getting harder and harder with every impact until it actually starts to hurt a bit, rather than sting. Once she’s at half-mast, Riya pumps her hand up and down her shaft a few times until the veiny thing is almost fully erect, pulsing visibly in front of your face. She wastes no time inching her hips forward and bumping her pre-leaking tip into your [pc.lips], the powerful, salty taste assaulting your mouth. <i>“Well, Steele? It ain’t gonna blow itself,”</i> she says as she pushes forward another inch, your nostrils the next to come under attack. Her smell permeates your olfactory senses, strong and intoxicating, your mouth seeming to open of it’s own accord to welcome this exemplary specimen in.");
	output("\n\nShe leans back against the stall door and reaches into one of her breast pockets to withdraw a sleek black tablet, the SteeleTech logo proudly displayed on it’s back. You blink - it’s rather strange to see your company’s products in this sort of situation. Riya slides her thumb across the other side of the device and you hear it open with a beep. Her cock pulses in your mouth and it’s owner peeks over the top of her tablet, one eyebrow quirking curiously. <i>“Why aren’t you sucking my dick, Steele?”</i> she asks, right hand leaving her tablet to rest on your head, her powerful fingers gripping your ");
	if(pc.horns > 1) output("[pc.horns]");
	else if(!pc.hasHair()) output("scalp");
	else output("[pc.hair]");
	output(" and pulling you forward. The bottom of her meat glides over your tongue, bumping the roof of your maw at the same time on it’s way to the back of your mouth. She keeps going until her dong hits the entrance to your throat, your body clenching the tunnel reflexively. Still, she holds you there easily, the muscles in her forearm standing out in high definition as you gag uselessly. She keeps you like that for a bit, the head of her cock poking uncomfortably into your esophagus without going all the way down, blocking your air until your hands come up to bat at her thighs, lungs burning.");
	output("\n\nReleasing you, she smirks over the side of her tablet. <i>“Ready to do your job now, ");
	if(race == "human") output("Steele?");
	//PC is ausar/huskar/dogmorph:
	else if(isDogMorph) output("muttslut?");
	// PC is kaithrit: 
	else if(isCatMorph) output("kitten?");
	else output("xeno?");
	output("”</i> she asks, cuffing you across the cheek lightly before returning to her tablet. Is she filming this? No... the camera light isn’t blinking, and her thumbs are moving too fast. She’s clearly typing - at least until she looks over the side of her device again, eyes glinting with irritation. <i>“I’m trying to get some reports done here, Steele. Are you gonna blow me, or am I gonna have to put this thing away and facefuck you? You do seem like you’d like my balls slapping your chin,”</i> she says, pushing her hips forward until her prick is poking the back of your mouth again. Taking the hint, you begin to move your head up and down her shaft, your tongue wrapping around the head, sliding over her cumslit. Riya groans approvingly, beginning to type again. <i>“Bet you can’t make me nut before I finish this,”</i> she says, her trademark shit eating grin visible over the top of her tablet. Is that a challenge?");
	output("\n\nApparently so, and it is <i>on</i>. You start to work harder on her schlong, right hand coming up to cradle her balls, the cum-swollen brown orbs weighty in your hand, filling and overflowing your palm easily. She throbs approvingly at this treatment, a drop of salty-sweet pre leaking onto your tongue. Encouraged, you push your head down further onto her shaft, her tip pressing into the back of your mouth again before you stop. <i>“Can’t take it all, Steele?”</i> Riya taunts, fingers tapping quickly against her screen. You squint up at her, tongue lapping along the sides of her shaft, her breath catching despite her best efforts to remain smug. Gathering yourself, you begin to push forward, steadily feeding a third of her beefy member down your gullet - and feel a hand on the back of your head, pushing you inexorably further down as Riya forces your jaws apart.");
	output("\n\nShe seems to have given up typing for now, instead holding her device idle in her left hand, breathing hard as her fingers rub into your scalp. <i>“Such a good ");
	if(race == "human") output("girl!");
	//PC is ausar/huskar/dogmorph:
	else if(isDogMorph) output("mutt!");
	// PC is kaithrit:
	else if(isCatMorph) output("kitty!");
	// PC is other:
	else output("xeno!");
	output("”</i> she coos, patting the top of your head. <i>“Keep it up, slut! You might actually win our little bet at this rate.");
	if(race != "human") output(" I’ve got something just for you after this.");
	output("”</i>");

	output("\n\nShe keeps pushing you down, your throat constricting powerfully around her girth as your body vainly tries to force the insertion out, only adding to her pleasure. Your eyes begin to water, chest burning as your lungs run low on oxygen, drool leaking liberally down your chin - and onto Riya’s heavy brown nuts as the swinging orbs slap into your face. Your [pc.lips] are stretched thin around her base and you can <i>feel</i> your throat bulging obscenely, distending to accommodate the fat meat buried in it. Looking up at Riya, it becomes apparent that she doesn’t seem very interested in moving for the moment, eyes fluttering shut. She spends a few long moments simply luxuriating in the feeling of your neck wringing her cock, wrapped in sweltering tightness. As usual, she seems completely unconcerned with your pleasure or lack thereof, rolling her hips back and slamming herself home, driving her schlong back down your gullet.");
	output("\n\nBy now your lungs have passed burning and begun to scream for air, your hands coming up of their own accord to bat at Riya’s powerful thighs. Your vision is beginning to dim, arms hitting with all the strength of a kitten until you can’t take it any more, limbs going limply to your sides as your eyes flutter shut. You find yourself coughing and gasping frantically for air a few seconds (you think) later, the dusky futa gripping you firmly under one armpit, keeping you from falling to the floor. <i>“Too much for you, ");
	if(race == "human") output("Steele? Guess you’ve been spending too much time with those pindick xenos.");
	//PC is ausar/huskar/dogmorph:
	else if(isDogMorph) output("mutt? I thought dogs loved swallowing bones. Are you... having a ruff day?");
	// PC is Kaithrit: 
	else if(isCatMorph) output("puss? I thought cats loved milk. You’re sure not showing it.");
	// PC is other: 
	else output("alien? Guess they don’t grow em’ this big on... whatever ball of dirt you’re from.");
	output("”</i> she says, grinning lopsidedly down at you. You try to marshal a witty reply, but all that comes out is loud sputtering and hacking, your recently cock-clogged esophagus unable to articulate properly. <i>“Anyways, back to work. Since you can’t take the heat I’m packing, why don’t you start on my nuts instead?”</i>");

	output("\n\nShe slowly releases your shoulder as she says this, allowing you to support yourself, one hand coming up to wipe away some of the drool on your chin. Her hand meanwhile drifts up to your head again, pinching one of your [pc.ears] and tugging you forward with it, smushing your face into those heavy, churning balls. The smell of them fills your nostrils as Riya releases your ear and grips the back of your head again, rubbing your mouth against her sack lazily. <i>“Don’t be shy, ");
	if(race == "human") output("Steele!");
	//PC is ausar/huskar/dogmorph:
	else if(isDogMorph) output("mutt!");
	// PC is kaithrit:
	else if(isCatMorph) output("sex kitten!");
	// PC is other: 
	else output("xeno!");
	output("”</i> she says, shifting her hips to drag her balls across your face, your vision suddenly obscured by the cum-swollen orbs. Your mouth opens, tongue venturing out to glide over her skin, her member twitching happily in response. You can just barely see a fat bead of pre at the tip of her shaft; between that and her increasingly heavy breathing, you suspect she’s getting close. She’s taken up her report again too, fingers flying across her tablet’s screen as if to make up for lost time.");

	output("\n\nWell, that won’t do. You step your game up, opening your jaws wide to allow one of her testes to fully enter your maw, your cheeks hollowing out as you lean your head back. Riya’s hands twitch and grip her tablet, unable to type, and the officer lets out a sharp gasp. You keep pulling your head back until her nut pops out of your mouth with a loud, lewd noise, Riya unable to restrain another pleasured grunt. <i>“Fucking... keep... keep that up, Steele. Holy shit,”</i> she whispers, eyes fluttering as you lick your way up the side of her shaft again, taking the head of her prick between your [pc.lips] and teasing her sensitive glans with your [pc.tongue]. She’s leaking more freely now - and so are you, your [pc.cunts] wetting ");
	if(pc.totalVaginas() == 1) output("itself");
	else output("themselves");
	output(" steadily as one of your hands slips down to your loins. ");
	if(pc.exhibitionism() < 33) output("Are you really about to masturbate in a public restroom, on your knees with a cock in your mouth? Your cheeks flush with embarrassment, but it doesn’t stop your questing digits.");
	else output("The thrill of what you’re up to hits you suddenly, of giving head in a public restroom where anyone might hear... or even open the door and spot the heiress to the Steele fortune on her knees, guzzling cock... Your cheeks flush, fingers scrabbling for your juiced up cunt with renewed vigor.");

	output("\n\n<i>“Almost done my report, Steele,”</i> you hear from above. <i>“It’s not looking like you’re gonna win our little race. You ready to get throatfucked?”</i> she asks tauntingly, one hand leaving her tablet to pat the top of your head. <i>“Or is that what you’re aiming for here? Get your face pounded by good ol’ Officer Batra?”</i> You glare up at the abrasive woman, but her eyes are fixed on her tablet, her hand leaving your hair to rejoin her other at work. You decide to speed up your work at any rate, bobbing your head vigorously while simultaneously jerking her shaft. ");
	//PC looseness 3 or above:
	if(pc.isBimbo() || pc.libido() >= 80 || pc.canDeepthroat() || pc.elasticity >= 3 || pc.isGoo())
	{
		output(" You take her into your throat easily now that you’ve time to steel yourself, even managing to swallow around her tool as you bury it in your throat. The dusky woman’s python flexes approvingly in your esophagus, and you notice her hurriedly stuffing her tablet back into her pocket before sliding her hands down to ");
		if(pc.horns == 0) output("either side of your head.");
		else output("your [pc.horns].");
	}
	else output(" Despite your best efforts, you’re barely able to get half of her lollipop into your mouth, but certainly not for lack of trying. Your determined, if fruitless efforts are still having the desired effect though, Riya’s schlong pulsing happily in your mouth. You notice her hurriedly stuffing her tablet back into her pocket before placing her hands firmly on either side of your head.");

	output("\n\nYou have a sneaking suspicion you know what’s next... and after your partner hauls your head back off of her girth, your suspicions are confirmed. <i>“Take a deep breath, ");
	// PC is human:
	if(race == "human") output("Steele."); 
	//PC is ausar/huskar/dogmorph: 
	else if(isDogMorph) output("muttslut.");
	// PC is kaithrit: 
	else if(isCatMorph) output("pussy.");
	// PC is other: 
	else output("xeno.");
	output(" You’ll need all the air you can get pretty soon.”</i>");

	output("\n\nIt’s a pretty strong hint - and one you take, gulping down a huge lungful of air, taking this opportunity to wipe some of the drool off your chin. Why, you’re not entirely sure, considering you’re about to have a second layer applied. As soon as she senses your readiness, Riya starts to push back into your mouth, tunneling down your throat ruthlessly, every vein on her dong sliding against the warm inside of your throat. She pulls you back until the head of her dark anaconda is just barely piercing your throat and thrusts again, setting a wet, noisy rhythm of nuts on chin, the degrading act compounded by the copious gagging and sputtering you find yourself unable to contain. You hear the door to the restroom open with a deafening creak, then the sound of someone snickering and feet approaching. Not bothering to slow her pace or even look up, Riya opens her mouth to speak. <i>“Fuck off or you’re next.”</i>");

	output("\n\nThe stranger outside the stall mumbles a hurried apology followed by quickly departing footsteps. ");
	//PC exhibitionism score above 33:
	if(pc.exhibitionism() >= 33) output("The thrill you get knowing that your degeneracy has been seen stays though, sending a rush of heat to your already sweltering loins. ");
	else output("Your cheeks flush in shame at the realization that you’ve been caught in the act, though that doesn’t stop your [pc.vagina] wetting itself with arousal. ");
	output("The beating your face is taking shows no signs of stopping, your drool glistening up and down the meatrod stuffing your gullet and dribbling down your chin again. Riya seems to be close at least, her grunting taking on a needy tone. You <i>hope</i> she’s close; a fair amount of the air you sucked down earlier has been forced right back out by the feverish facefucking the dickgirl cop is unleashing on you. You can’t even concentrate on jilling yourself off, hands instead gripping Riya’s thighs to steady yourself as she wears your throat out.");

	output("\n\nThere’s no real warning when she cums, beyond her thrusting becoming short and erratic, the dusky woman instinctively burying her member as deeply as possible into your throat before her cock swells within the clinging, wet heat of your bulging neck, balls sliding up your chin as they prepare to dump their cargo into your belly. Good thing, too - you’re starting to run out of air again. Her fingers clutch your ");
	if(pc.horns == 0) output("head");
	else output("horns");
	output(" powerfully, immobilizing you as her shaft begins to pulse, lances of burning hot jizz shooting almost directly into your stomach. It feels like she cums down your throat for hours, but that might just be the lack of oxygen. However long she spends seeding your mouth, Riya finally begins to pull back as her orgasm tapers off, the last few jets of off-white jism landing on your [pc.tongue]. She pumps her length a few times, panting like she’s just run a race, and pushes the head of her slowly deflating babymaker past your lips again to shoot her last bit of nut into your open mouth. Even at the end of her orgasm, Riya’s cum is bountiful enough to fill your maw almost to capacity, the salty, slightly sweet taste overpowering your taste buds. She’s quick to pinch your spit-slick chin between a thumb and forefinger before you can spit out the last of her copious load, tilting your head up so that it pools in the back of your mouth.");

	output("\n\n<i>“Swallow,”</i> she says, pushing your mouth closed. You blink, then comply, the slimy mouthful of nutbatter in your mouth sliding heavily down your throat, joining the sloshing mass in your tummy.");

	output("\n\nRiya grins, leaning down and frenching you on the lips, her tongue clearing some of her own jizz out of your mouth before she breaks it. <i>“Such a good little whore you are!");
	//PC is nonhuman: 
	if(race != "human" && !pc.hasStatusEffect("Riya Treat CD"))
	{
		output(" Here, have a treat, sweetmeat,”</i> she purrs, licking her lips and reaching down into her crumpled pants, withdrawing a small baggie filled with... Terran Treats? Does she seriously just have a bag of Terran Treats on her person at all times? That’s... well. Knowing Riya, maybe it’s not <i>that</i> unexpected. She takes one out and presses it into your hand. <i>“There you go, ");
		//PC is ausar/huskar/dogmorph: 
		if(isDogMorph) output("mutt!");
		// PC is kaithrit:
		else if(isCatMorph) output("puss!");
		// PC is other: 
		else output("xeno!");
		output(" Take it any time you feel like improving yourself.");
	}
	output("”</i>");
	output("\n\nShe grabs a towel from the dispenser next to you, wiping her loins dry with it before tossing it to you and reaching for her pants, pulling them back on. You wipe your face clean with the dry parts of the towel, closing your sore jaws as you stand shakily, [pc.knees] sore from being on them so long. Riya pinches your [pc.ass] hard, ushering you out of the bathroom and back into the station proper before blowing you a kiss and returning to her post. You go your own way - you didn’t get off this time, but you feel strangely satisfied nonetheless.\n\n");
	// PC exhibition score +2
	processTime(20);
	pc.exhibitionism(2);
	pc.lust(30);
	var pp:PregnancyPlaceholder = getRiyaPregContainer();
	pc.loadInMouth(pp);
	IncrementFlag("RIYA_GOT_BLOWN");
	// If PC is nonhuman, PC receives one Terran Treat
	if(race != "human" && !pc.hasStatusEffect("Riya Treat CD"))
	{
		pc.createStatusEffect("Riya Treat CD", 0, 0, 0, 0, true, "", "", false, 7*24*60);
		quickLoot(new TerranTreats());
	}
	else
	{
		clearMenu();
		addButton(0,"Next",mainGameMenu);
	}
}