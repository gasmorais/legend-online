package yishi.manager
{
   import avmplus.getQualifiedClassName;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import yishi.comm.PackageIn;
   import yishi.datas.buffer.PkgBuffer;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.scene.SceneManager;
   
   public class SocketSceneBufferManager implements IEnterFrame
   {
      
      private static var _instance:SocketSceneBufferManager;
      
      private var _pkgBuffer:Dictionary;
      
      private var _isSetup:Boolean;
      
      public function SocketSceneBufferManager()
      {
         super();
      }
      
      public static function get instance() : SocketSceneBufferManager
      {
         if(!_instance)
         {
            _instance = new SocketSceneBufferManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _isSetup = true;
         _pkgBuffer = new Dictionary(true);
         EnterFrameManager.instance.registeEnterFrame(this);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         var _loc4_:PkgBuffer = null;
         if(SceneManager.instance.lock)
         {
            return;
         }
         var _loc3_:String = SceneManager.instance.currentType;
         var _loc2_:Array = _pkgBuffer[_loc3_] as Array;
         if(_loc2_)
         {
            while(_loc2_.length > 0)
            {
               _loc4_ = _loc2_.pop();
               executePkg(_loc4_);
            }
         }
         _pkgBuffer[_loc3_] = null;
         delete _pkgBuffer[_loc3_];
      }
      
      public function enterFrame() : void
      {
         var _loc2_:int = 0;
         var _loc4_:PkgBuffer = null;
         var _loc3_:int = getTimer();
         for each(var _loc1_:Array in _pkgBuffer)
         {
            _loc2_ = _loc1_.length - 1;
            while(_loc2_ >= 0)
            {
               _loc4_ = _loc1_[_loc2_];
               if(_loc3_ - _loc4_.time > _loc4_.leftTime)
               {
                  _loc1_.splice(_loc2_,1);
                  executePkg(_loc4_);
               }
               _loc2_--;
            }
         }
      }
      
      public function getMessage() : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:String = "";
         for each(var _loc1_:Array in _pkgBuffer)
         {
            _loc4_ = _loc1_.length - 1;
            while(_loc4_ >= 0)
            {
               _loc3_++;
               _loc2_ += _loc3_ + " : " + getQualifiedClassName(_loc1_[_loc4_]) + "\n";
               _loc4_--;
            }
         }
         return _loc2_;
      }
      
      public function addPkgToBuffer(param1:PackageIn, param2:String, param3:Function, param4:int = 90000) : void
      {
         if(!_isSetup)
         {
            return;
         }
         param1.position = 20;
         var _loc5_:PkgBuffer = new PkgBuffer(param1,getTimer(),param3,param4);
         if(!_pkgBuffer[param2])
         {
            _pkgBuffer[param2] = [];
         }
         _pkgBuffer[param2].push(_loc5_);
         __switchSceneHandler(null);
      }
      
      private function executePkg(param1:PkgBuffer) : void
      {
         param1.callBack(param1.pkg);
         param1 = null;
      }
   }
}

