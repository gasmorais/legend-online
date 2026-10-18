package yishi.actions.consortia
{
   import flash.events.Event;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MarketModel;
   import ui.maintoolbar.MainToolBar;
   import yishi.actions.map.MapBaseAction;
   import yishi.manager.FrameControllerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class ConsortiaApplyAction extends MapBaseAction
   {
      
      private var _isPop:Boolean;
      
      private var _id:int;
      
      private var _msg:String;
      
      public function ConsortiaApplyAction(param1:int, param2:String)
      {
         super();
         _id = param1;
         _msg = param2;
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(!_isPop && !isSellling)
         {
            createApplyFrame(_msg);
            _isPop = true;
         }
      }
      
      private function createApplyFrame(param1:String) : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [__requestFrameCloseHandler];
         SimpleAlertHelper.instance.addEventListener("dispose",__disposeHandler);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,param1,_loc2_,_loc3_);
      }
      
      private function __disposeHandler(param1:Event) : void
      {
         SimpleAlertHelper.instance.removeEventListener("dispose",__disposeHandler);
         dispose();
      }
      
      private function __requestFrameCloseHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.consortiaController.operateConsortiaApply(_id,true);
         }
         else
         {
            MainToolBar.instance.consortiaButtonShine = false;
            FrameControllerManager.instance.consortiaController.operateConsortiaApply(_id,false);
         }
         dispose();
         SimpleAlertHelper.instance.removeEventListener("dispose",__disposeHandler);
      }
      
      private function get isSellling() : Boolean
      {
         var _loc1_:MarketModel = CampaignManager.instance.marketModel;
         return _loc1_ && _loc1_.selfStall.state == 2;
      }
   }
}

