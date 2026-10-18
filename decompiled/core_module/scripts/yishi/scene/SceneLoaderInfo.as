package yishi.scene
{
   public class SceneLoaderInfo
   {
      
      public var neededUIModule:Vector.<String>;
      
      public var loadedUIModule:Vector.<String>;
      
      public var callBack:Function;
      
      public var isComplete:Boolean;
      
      public var isLoading:Boolean;
      
      public var state:String;
      
      public var currentLoaded:int = 0;
      
      public var progress:Number;
      
      public function SceneLoaderInfo()
      {
         super();
      }
   }
}

