package haxe.ds;

@:using(haxe.ds.Maybe.MaybeUtil)
enum Maybe<T> {
    Just(t:T);
    Nothing;
}

class MaybeUtil {

    public static function isJust<T>(o:Maybe<T>): Bool {
	return switch(o) {
	    case Just(_): true;
	    case Nothing: false;
	};
    }
    
    public static function isNothing<T>(o:Maybe<T>): Bool {
	return !o.isJust();
    }

    public static function map<T,U>( o:Maybe<T>, fn : (t:T) -> U) : Maybe<U> {
	return switch(o) {
	    case Just(t): Just(fn(t));
	    case Nothing: Nothing;
	};
    }

    public static function thenDo<T>( o:Maybe<T>, fn: (t:T) -> Void) {
	map(o,fn);
    }

    public static function onJust<T>( o:Maybe<T>, fn: (t:T) -> Void):Maybe<T> {
	map(o,fn);
	return o;
    }

    public static function onNothing<T>( o: Maybe<T>, fn: () -> Void):Maybe<T> {
	switch(o) {
	case Nothing: fn();
	default: {}
	}
	return o;
    }

    public static function andThen<T,U>( o:Maybe<T>, fn : (t:T) -> Maybe<U>) : Maybe<U> {
	return switch(o) {
	    case Just(t): fn(t);
	    case Nothing: Nothing;
	};
    }

    public static function is<T>( o : Maybe<T>, pred: (t:T) -> Bool) : Bool {
	return switch(o) {
	    case Just(t): pred(t);
	    case Nothing: false;
	};
    }


    public static function when<T>( o : Maybe<T>, pred: (t:T) -> Bool) : Maybe<T> {
	return if (is(o,pred)) o else Nothing;
    }


    public static function take<T>(o : Maybe<T>, ?defaultValue : Null<T> = null) : Null<T> {
	return switch(o) {
	    case Nothing: defaultValue;
	    case Just(t): t;
	};
    }

}
