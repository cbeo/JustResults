# JustResults 

Maybe and Result types, and static extensions for using them in a
functional style.

Not in haxelib. Use `haxelib git` or clone this repo and set `haxelib
dev` to its location.


``` haxe

import haxe.ds.Maybe;
import haxe.ds.Result;

typedef MyErrorType = String;

class Main {

    static function maybeInt():Maybe<Int> {
        return if (Math.random() > 0.5) Just( 42 ) else Nothing;
    }
    
    static function intResult():Result<MyErrorType,Int> {
        return if (Math.random() > 0.5) Ok( 42 ) else Error( "This is an error" );
    }

    public static function main () {
        maybeInt()
            .map( i -> i * 100)                              // you can map Maybe instances
            .filter( i -> i == 4200)                         // and filter them
            .onJust( i -> trace('I got an int: $i'))        
            .onNothing( () -> trace('No integer it seems'));
            
        intResult()
            .map( i -> i * 100)                             // you also can map over Results
            .filter( i -> i === 4200)                       // and filter too
            .onOk( i -> trace('its all ok: $i')) 
            .onError( err -> trace('oh no: $err'));
    }

}

```

There are many more convenient methods available. 
