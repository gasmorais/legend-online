package newbie
{
   import com.pickgliss.ui.ComponentSetting;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class NewbieSPHelper
   {
      
      public static const NEWBIE_NAMEEND:int = 10000;
      
      public static const NEWBIE_START_CAMPAIGN:int = 11000;
      
      public static const NEWBIE_GOTOCASTLE:int = 19000;
      
      public function NewbieSPHelper()
      {
         super();
      }
      
      public static function saveNoviceProcess(param1:Object, param2:int, param3:Function = null) : void
      {
         param1["noviceProcess"] = param2;
         var _loc6_:URLLoader = new URLLoader();
         var _loc4_:URLRequest = new URLRequest(ComponentSetting.REQUEST_PATH + "updateplayernovice");
         _loc4_.method = "POST";
         var _loc5_:URLVariables = new URLVariables();
         _loc5_["op"] = 1;
         _loc5_["userid"] = param1["userId"];
         _loc5_["noviceprocess"] = param1["noviceProcess"];
         _loc5_["key"] = param1["key"];
         _loc5_["rnd"] = Math.random();
         _loc4_.data = _loc5_;
         if(param3 != null)
         {
            _loc6_.addEventListener("complete",param3);
         }
         _loc6_.load(_loc4_);
      }
   }
}

