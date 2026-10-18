package yishi.scene
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Stage3D;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.system.Capabilities;
   import yishi.datas.VersionSwitch;
   import yishi.utils.StringUtil;
   
   public class SceneCreateSwitch
   {
      
      private static var _instance:SceneCreateSwitch = null;
      
      private var _stage3D:Stage3D;
      
      private var _data:Vector.<String>;
      
      private var _driverInfo:String = "";
      
      private var _isSetUp:Boolean = false;
      
      private var _canOpen3D:Boolean = true;
      
      public function SceneCreateSwitch()
      {
         super();
      }
      
      public static function get instance() : SceneCreateSwitch
      {
         if(!_instance)
         {
            _instance = new SceneCreateSwitch();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(_isSetUp)
         {
            if(VersionSwitch.OUTCITY_3D)
            {
               VersionSwitch.OUTCITY_3D = _canOpen3D;
            }
            return;
         }
         if(VersionSwitch.OUTCITY_3D)
         {
            if(checkVersion())
            {
               _data = new Vector.<String>();
               getDriverInfo();
            }
            else
            {
               VersionSwitch.OUTCITY_3D = false;
               _canOpen3D = false;
            }
         }
         _isSetUp = true;
      }
      
      private function checkVersion() : Boolean
      {
         var _loc2_:String = getNoStrVersion(Capabilities.version);
         var _loc1_:Array = _loc2_.split(",");
         if(int(_loc1_[0]) > 11)
         {
            return true;
         }
         return int(_loc1_[0]) >= 11 && int(_loc1_[1]) >= 4;
      }
      
      private function getNoStrVersion(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1.charAt(_loc2_);
            if(!StringUtil.isEnglish(_loc3_))
            {
               return StringUtil.ltrim(param1.substring(_loc2_,param1.length));
            }
            _loc2_++;
         }
         return param1;
      }
      
      public function getDriverInfo() : void
      {
         if(StageReferance.stage.stage3Ds.length > 0)
         {
            _stage3D = StageReferance.stage.stage3Ds[0];
            _stage3D.addEventListener("context3DCreate",__context3DCreateHandle);
            _stage3D.addEventListener("error",__onCreateError);
            _stage3D.requestContext3D("auto");
         }
         else
         {
            _data.push("your computer GPU not work");
            VersionSwitch.OUTCITY_3D = false;
            _canOpen3D = false;
            getVersion();
         }
      }
      
      private function __context3DCreateHandle(param1:Event) : void
      {
         _stage3D.removeEventListener("context3DCreate",__context3DCreateHandle);
         _stage3D.removeEventListener("error",__onCreateError);
         if(!_stage3D.context3D)
         {
            return;
         }
         _driverInfo = _stage3D.context3D.driverInfo;
         if(_driverInfo.indexOf("DirectX9") != -1 || _driverInfo.indexOf("OpenGL") != -1)
         {
            if(_driverInfo.indexOf("userDisabled") == -1)
            {
               VersionSwitch.OUTCITY_3D = true;
               _canOpen3D = true;
            }
            else
            {
               VersionSwitch.OUTCITY_3D = false;
               _canOpen3D = false;
               _data.push(_driverInfo);
               getVersion();
            }
         }
         else
         {
            VersionSwitch.OUTCITY_3D = false;
            _canOpen3D = true;
            _data.push(_driverInfo);
            getVersion();
         }
      }
      
      private function __onCreateError(param1:ErrorEvent) : void
      {
         VersionSwitch.OUTCITY_3D = false;
         _canOpen3D = false;
         _stage3D.removeEventListener("context3DCreate",__context3DCreateHandle);
         _stage3D.removeEventListener("error",__onCreateError);
         if(param1.errorID == 3702)
         {
            _data.push("This application is not correctly embedded (wrong wmode value)");
         }
         else
         {
            _data.push("Stage3D error: " + param1.text);
         }
         getVersion();
      }
      
      private function getVersion() : void
      {
         _data.push(Capabilities.version);
      }
      
      private function joinString(param1:Vector.<String>) : String
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

