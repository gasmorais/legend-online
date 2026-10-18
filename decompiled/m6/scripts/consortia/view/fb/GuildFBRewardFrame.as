package consortia.view.fb
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.fb.item.GuildFBRewardItem;
   import manager.LanguageMgr;
   import mvc.module.guildfb.GuildFBModel;
   import mvc.module.guildfb.GuildFBRewardItemInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.FrameControllerManager;
   
   public class GuildFBRewardFrame extends Frame
   {
      
      private var _tipTxt:FilterFrameText;
      
      private var _rewardVbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function GuildFBRewardFrame()
      {
         super();
         initView();
         addEvent();
         refreView();
      }
      
      private function initView() : void
      {
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRewardFrame.tipTxt");
         _rewardVbox = ComponentFactory.Instance.creatComponentByStylename("guildFBRewardFrame.rewardVbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("guildFBRewardFrame.scrollPanel");
         addToContent(_tipTxt);
         _scrollPanel.beginChanges();
         _scrollPanel.setView(_rewardVbox);
         _scrollPanel.invalidateViewport();
         addToContent(_scrollPanel);
         _tipTxt.text = LanguageMgr.GetTranslation("consortia.view.fb.guildFBRewardFrame.text");
      }
      
      private function refreView() : void
      {
         var _loc2_:Array = null;
         var _loc1_:GuildFBRewardItem = null;
         var _loc3_:int = 0;
         if(_rewardVbox)
         {
            _rewardVbox.removeAllChild();
         }
         if(model)
         {
            _loc2_ = model.getRewardArray();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc1_ = new GuildFBRewardItem();
               _loc1_.data = _loc2_[_loc3_] as GuildFBRewardItemInfo;
               _rewardVbox.addChild(_loc1_);
               _loc3_++;
            }
         }
         _scrollPanel.beginChanges();
         _scrollPanel.vScrollbar.scrollValue = 0;
         _scrollPanel.invalidateViewport();
      }
      
      private function get model() : GuildFBModel
      {
         return FrameControllerManager.instance.guildFbController.model;
      }
      
      private function unInitView() : void
      {
         if(_tipTxt)
         {
            ObjectUtils.disposeObject(_tipTxt);
         }
         _tipTxt = null;
         if(_rewardVbox)
         {
            ObjectUtils.disposeObject(_rewardVbox);
         }
         _rewardVbox = null;
         if(_tipTxt)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.fb.guildFBRankFrame.seasonRewardTxt");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         unInitView();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

