package yishi.manager
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import manager.LanguageMgr;
   
   public class RechargeAlertMannager
   {
      
      public function RechargeAlertMannager()
      {
         super();
      }
      
      public static function show(param1:Function = null) : void
      {
         var closeFun:Function = param1;
         var rechargeHandler:* = function(param1:FrameEvent):void
         {
            if(closeFun != null)
            {
               if(closeFun.length > 0)
               {
                  closeFun(param1);
               }
               else
               {
                  closeFun();
               }
            }
            if(param1.responseCode == 3 || param1.responseCode == 2)
            {
               navigateToRechargePage();
            }
            alert.removeEventListener("response",rechargeHandler);
            alert.dispose();
         };
         var prompt:String = LanguageMgr.GetTranslation("public.prompt");
         var content:String = LanguageMgr.GetTranslation("yishi.manager.RechargeAlertMannager.content");
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(prompt,content,"","");
         alert.addEventListener("response",rechargeHandler);
      }
      
      public static function navigateToRechargePage() : void
      {
         var _loc4_:URLRequest = null;
         var _loc1_:* = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(ExternalInterface.available)
         {
            if(ComponentSetting.SITE.slice(0,5) == "7road")
            {
               _loc2_ = PlayerManager.instance.currentPlayerModel.userInfo.site;
               _loc3_ = PlayerManager.instance.currentPlayerModel.userInfo.user;
               _loc4_ = new URLRequest(PathManager.info.PAY + "?key=sq&site=" + _loc2_ + "&uid=" + _loc3_);
               navigateToURL(_loc4_,"_blank");
            }
            else
            {
               _loc4_ = new URLRequest(PathManager.info.PAY);
               navigateToURL(_loc4_,"_blank");
            }
         }
      }
   }
}

