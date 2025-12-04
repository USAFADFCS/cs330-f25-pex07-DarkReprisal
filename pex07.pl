%---who
cadet(smith).
cadet(garcia).
cadet(chen).
cadet(jones).
%---when
day(tuesday).
day(wednesday).
day(thursday).
day(friday).
%---what
object(fighter).
object(balloon).
object(cloud).
object(kite).

solve :-
    day(smithDay), day(garciaDay), day(chenDay), day(jonesDay),
	  all_different([smithDay, garciaDay, chenDay, jonesDay]),

    object(smithObject),object(garciaObject),object(chenObject),object(jonesObject),
    all_different([smithObject, garciaObject, chenObject, jonesObject]),
    Triples = [ [smith, smithDay, smithObject], [garcia, garciaDay, garciaObject], [chen, chenDay, chenObject], [jones, jonesDay, jonesObject]],
    
    %1 C4C Smith did not see a weather balloon, nor kite.
    \+ member([smith,_,balloon],Triples),
    \+ member([smith,_,kite],Triples),
    
    %2 The one who saw the kite isn’t C4C Garcia.
    \+ member([garcia,_,kite],Triples),
    
    %3 Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    (member([chen,friday,_],Triples);
    member([_,friday,fighter],Triples)),
    
    %4 The kite was not sighted on Tuesday.
    \+ member([_,tuesday,kite],Triples),
    
    %5 Neither C4C Garcia nor C4C Jones saw the weather balloon.
    \+ member([garcia,_,balloon],Triples),
    \+ member([jones,_,balloon],Triples),
    
    %6 C4C Jones did not make their sighting on Tuesday.
    \+ member([jones,tuesday,_],Triples),
    
    %7 C4C Smith saw an object that turned out to be a cloud.
    member([smith,_,cloud],Triples),
    
    %8 The fighter aircraft was spotted on Friday.
    member([_,friday,fighter],Triples),
    
    %9 The weather balloon was not spotted on Wednesday.
    \+ member([_,wednesday,balloon],Triples),

	  tell(garcia, garciaDay, garciaObject),
	  tell(smith, smithDay, smithObject),
	  tell(jones, jonesDay, jonesObject),
	  tell(chen, chenDay, chenObject).

all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X,Y,Z) :-
    write('On '), write(Y), write(' C4C '), write(X), write(' saw '), write(Z), write('.'),nl.

          

