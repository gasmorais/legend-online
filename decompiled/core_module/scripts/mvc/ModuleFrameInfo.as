package mvc
{
   import com.pickgliss.loader.UiConfigAnalyzer;
   import flash.utils.Dictionary;
   
   public class ModuleFrameInfo
   {
      
      public var moduleUIName:String;
      
      public var needLoadArr:Array;
      
      public var projectFile:String;
      
      public var isComplete:Boolean;
      
      public var openType:Object;
      
      public var frameData:Object;
      
      public var callBack:Function;
      
      public var progress:Number;
      
      public var currentLoaded:int;
      
      public function ModuleFrameInfo()
      {
         super();
      }
      
      public function get totalSize() : Number
      {
         var _loc3_:Dictionary = null;
         var _loc1_:Number = 0;
         for each(var _loc2_:String in needLoadArr)
         {
            _loc3_ = UiConfigAnalyzer.data;
            _loc1_ += int(UiConfigAnalyzer.data[_loc2_ + ".swf"]);
         }
         return _loc1_;
      }
   }
}

