package yishi.utils
{
   import com.yy.game.GameMsgCollector;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class CallInterfaceUtil
   {
      
      public function CallInterfaceUtil()
      {
         super();
      }
      
      public static function cannDuowanPlayerNotify(param1:String, param2:String, param3:int, param4:int) : void
      {
         var _loc8_:String = null;
         var _loc6_:URLVariables = null;
         var _loc5_:URLRequest = null;
         var _loc7_:URLLoader = null;
         try
         {
            _loc8_ = "http://assist" + param4 + ".shenqu.game.yy.com/";
            _loc6_ = new URLVariables();
            _loc6_["username"] = param1;
            _loc6_["site"] = param2;
            _loc6_["type"] = param3;
            _loc6_["rnd"] = Math.random();
            _loc5_ = new URLRequest(_loc8_ + "playerNotify");
            _loc5_.data = _loc6_;
            _loc7_ = new URLLoader();
            _loc7_.load(_loc5_);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function reportGameProfile(param1:String, param2:int, param3:String, param4:int) : void
      {
         var _loc5_:int = 0;
         try
         {
            _loc5_ = parseInt(param1.substring(param1.indexOf("_") + 1));
            GameMsgCollector.instance.reportGameProfile("",param2,"shenqu","s" + _loc5_,param3,param4,"level_change",null);
         }
         catch(e:Error)
         {
         }
      }
   }
}

