package consortia.view.minos
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.view.minos.ui.MinosEnterViewUI;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import managers.MinosManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class MinosEnterFrame extends Frame implements IManualSize
   {
      
      private var _view:MinosEnterViewUI;
      
      private var _helpBtn:BaseButton;
      
      public function MinosEnterFrame()
      {
         super();
         initView();
         initEvent();
         MinosManager.ins.doSomething(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1262,742);
      }
      
      private function initView() : void
      {
         _view = new MinosEnterViewUI();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.minos.HelpBtn");
         addToContent(_view);
         addToContent(_helpBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",helpClickHandler);
         NotificationManager.instance.addEventListener("minos_EVENT_LV_UPDATE",lvUpdateHandler);
         NotificationManager.instance.addEventListener("minos_EVENT_RANK_UPDATE",updateRankhandler);
         NotificationManager.instance.addEventListener("minos_EVENT_PALYER_UPDATE",playInfoHandler);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",helpClickHandler);
         NotificationManager.instance.removeEventListener("minos_EVENT_LV_UPDATE",lvUpdateHandler);
         NotificationManager.instance.removeEventListener("minos_EVENT_RANK_UPDATE",updateRankhandler);
         NotificationManager.instance.removeEventListener("minos_EVENT_PALYER_UPDATE",playInfoHandler);
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ui.minos.HelpFrame");
         _loc2_.show();
      }
      
      private function playInfoHandler(param1:NotificationEvent) : void
      {
         _view.updateCardReward();
      }
      
      private function updateRankhandler(param1:NotificationEvent) : void
      {
         _view.updateRankList(param1.data as Array);
      }
      
      private function lvUpdateHandler(param1:NotificationEvent) : void
      {
         _view.refreshItemList();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
         MinosManager.ins.doSomething(2);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
   }
}

