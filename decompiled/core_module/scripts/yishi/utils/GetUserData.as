package yishi.utils
{
   import flash.display.Stage;
   import flash.display.Stage3D;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.system.Capabilities;
   
   public class GetUserData
   {
      
      private static var _stage3D:Stage3D;
      
      private static var _driverInfo:String = "";
      
      private static var _callback:Function;
      
      private static var _strs:Vector.<String>;
      
      private static var _os:String = "";
      
      private static var _flashVersion:String = "";
      
      public function GetUserData()
      {
         super();
      }
      
      public static function init(param1:Stage, param2:Function) : void
      {
         _callback = param2;
         _stage3D = param1.stage3Ds[0];
         _strs = new Vector.<String>();
         _stage3D.addEventListener("context3DCreate",context3DCreateHandle);
         _stage3D.addEventListener("error",onStage3DError);
         _stage3D.requestContext3D("auto");
      }
      
      protected static function onStage3DError(param1:ErrorEvent) : void
      {
         if(param1.errorID == 3702)
         {
            _strs.push("This application is not correctly embedded (wrong wmode value)");
         }
         else
         {
            _strs.push("Stage3D error: " + param1.text);
         }
         getInfoOver();
      }
      
      protected static function context3DCreateHandle(param1:Event) : void
      {
         _driverInfo = _stage3D.context3D.driverInfo;
         _strs.push(_driverInfo);
         getInfoOver();
      }
      
      private static function getInfoOver() : void
      {
         var _loc1_:Array = Capabilities.version.split(" ");
         if(_loc1_ && _loc1_.length > 0)
         {
            _os = _loc1_[0];
            if(_loc1_.length > 1)
            {
               _flashVersion = _loc1_[1];
            }
         }
         if(_callback != null)
         {
            _callback(_driverInfo,_os,_flashVersion);
            dispose();
         }
      }
      
      private static function dispose() : void
      {
         _callback = null;
         if(_stage3D)
         {
            _stage3D.removeEventListener("context3DCreate",context3DCreateHandle);
            _stage3D.removeEventListener("error",onStage3DError);
            if(_stage3D.context3D)
            {
               _stage3D.context3D.dispose();
            }
         }
         _strs.length = 0;
      }
      
      private static function joinString(param1:Vector.<String>) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = param1[0];
         _loc3_ = 1;
         while(_loc3_ < param1.length)
         {
            _loc2_ += " /*/ ";
            _loc2_ += param1[_loc3_];
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

