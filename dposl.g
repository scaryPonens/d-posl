grammar posl;

prog	:	 pre+;

pre	:	ruleID=STRING':'name1=STRING'('expr')' drule id'('expr')' NEWLINE
	|	name2=STRING'('expr')' rule id'('expr')' NEWLINE
	|	NEWLINE
	;
	
expr	:	slots
	| 	positionals
	|	(slots (';')) positionals ((';') slots)?
	;
		
positionals 
	:	positional((',') positional)*
	;
	
slots	:	slot((';') slot)* //expr may contain one or more slots
	;

id	:	identifier=STRING(('^^') value=STRING)? // id may contain one or two strings seperated by :
	;

rule 	:	WS*':-'WS*
	;

drule	:	WS*':=' WS*
	|	WS*':~'WS*
	;
	
slot	:	id'->'value=INT
	|	id'->'value=STRING
	|	id'->?'var=STRING
	;
	
positional 
	:	value=INT
	|	value=STRING
	|	'?'var=STRING
	;
	
INT	:'0'..'9'+;
STRING	:('a'..'z'|'A'..'Z')('a'..'z'|'A'..'Z'|'0'..'9')*;
NEWLINE	:'\r'?'\n';
WS	:(' '|'\t')+;