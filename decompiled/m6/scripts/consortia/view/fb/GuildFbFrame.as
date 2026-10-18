package consortia.view.fb
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import mvc.module.guildfb.GuildFBModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class GuildFbFrame extends Frame
   {
      
      private var _ui:GuildFBMainUIView;
      
      private var _helpBtn:BaseButton;
      
      public function GuildFbFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function initView() : void
      {
         _ui = new GuildFBMainUIView();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.HelpBtn");
         addToContent(_ui);
         addToContent(_helpBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
         _helpBtn.addEventListener("click",__helpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:Frame = null;
         SoundManager.instance.play("022");
         if(model.raceNode == null || model.raceNode.state == 0)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.helpFrame1");
         }
         else
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.helpFrame");
         }
         _loc2_["show"]();
      }
      
      private function get model() : GuildFBModel
      {
         return FrameControllerManager.instance.guildFbController.model;
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
         ObjectUtils.disposeObject(_ui);
         _ui = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
         LayerManager.Instance.clearnGameDynamic();
      }
   }
}

