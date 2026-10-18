package yishi.service.managers
{
   import flash.utils.getTimer;
   import yishi.GlobalConfig;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class LoginMsgManager implements IEnterFrame
   {
      
      private static var _instance:LoginMsgManager;
      
      private static var _loginMsgArr:Vector.<PackageIn>;
      
      private var _time:int;
      
      public function LoginMsgManager()
      {
         super();
         _loginMsgArr = new Vector.<PackageIn>();
         EnterFrameManager.instance.registeEnterFrame(this);
         _time = getTimer();
      }
      
      public static function get instance() : LoginMsgManager
      {
         if(!_instance)
         {
            _instance = new LoginMsgManager();
         }
         return _instance;
      }
      
      public function enterFrame() : void
      {
         var _loc1_:PackageIn = null;
         _time = getTimer();
         if(GlobalConfig.isLoginMsg)
         {
            if(_loginMsgArr.length > 0)
            {
               _loc1_ = _loginMsgArr.shift();
               SocketManager.instance.dispatchEvent(new SLGSocketEvent("SLGSocketEvent" + _loc1_.code,_loc1_));
            }
         }
         else if(_loginMsgArr.length > 0)
         {
            _loc1_ = _loginMsgArr.shift();
            SocketManager.instance.dispatchEvent(new SLGSocketEvent("SLGSocketEvent" + _loc1_.code,_loc1_));
         }
         else
         {
            stop();
         }
      }
      
      public function acceptMsg(param1:PackageIn) : void
      {
         _loginMsgArr.push(param1);
      }
      
      public function stop() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _loginMsgArr = null;
      }
   }
}

