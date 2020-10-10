package haxe.ds;

@:using(Result.ResultExtensions)
enum Result<E,T> {
  Err(kind:E);
  Ok(ok:T);
}

class ResultExtensions
{
  
  public static function isOk<E,T>(result: Result<E,T>): Bool {
    return switch (result) {
    case Ok(_): true;
    case _: false;
    };
  }
  
  public static function isErr<E,T>(result: Result<E,T>): Bool {
    return !isOk(result);
  }
  
  public static function then<E,T,U>(result: Result<E,T>,
                                     fn: (val:T) -> Result<E,U>
                                     ): Result<E,U>
  {
    return switch (result) {
    case Ok(val): fn(val);
    case Err(e): Err(e);
    };
  }

  public static function onOk<E,T>(result: Result<E,T>,
                                   fn: (val:T) -> Void
                                   ): Result<E,T>
  {
    return then(result, val -> {fn(val); return result;});
  }      
  
  public static function onError<E,T>(result: Result<E,T>,
                                      fn: (err:E) -> Void
                                      ): Result<E,T>
  {
    switch (result) {
    case Err(e): fn(e);
    case _: {}
    }
    return result;
  }
  
  public static function map<E,T,U>(result: Result<E,T>,
                                    fn: (val:T) -> U
                                    ): Result<E,U>
  {
	    return switch (result) {
            case Ok(v): Ok(fn(v));
            case Err(e): Err(e);
	    };
  }
  
  public static function resultMap<E,T,U>(ts: Array<T>,
                                          fn: (t:T) -> Result<E,U>
                                          ): Result<E,Array<U>> {
    var res: Array<U> = [];
    for (t in ts) switch(fn(t)) {
      case Ok(u): res.push(u);
      case Err(e): return Err(e);
      }
    return Ok(res);
  }

  public static function fromMaybe<E,T>(m:Maybe<T>, e: E) : Result<E,T> {
    return switch (m) {
    case Just(t): Ok(t);
    case Nothing: Err(e);
    };
  }
}
