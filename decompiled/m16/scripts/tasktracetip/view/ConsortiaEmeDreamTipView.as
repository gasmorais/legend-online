package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import managers.MopupManager;
   import managers.TaskTraceTipManager;
   import mvc.module.consortia.ConsortiaModel;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaEmeDreamTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseIconView;
      
      private var _contentTxt:FilterFrameText;
      
      public function ConsortiaEmeDreamTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         _icon = ComponentFactory.Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         _icon.icon = ComponentFactory.Instance.creatBitmap("asset.taskTraceTips.ConsortiaBossIcon");
         _icon.tipStyle = "yishi.view.tips.OneLineTip";
         _icon.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaBossFrame.titleText");
         _textBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.skipNow");
         addChild(_contentTxt);
         addChild(_textBtn);
         addChild(_icon);
         __switchHandler(null,null);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         MsgMan.addObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",this,__switchHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         MsgMan.removeObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",this,__switchHandler);
      }
      
      private function __switchHandler(param1:String, param2:Object) : void
      {
         if(model.emeDreamInfo.state != 1 && model.emeDreamInfo.state != 2)
         {
            TaskTraceTipManager.instance.cleanByType(42);
         }
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.htmlText = _data.content;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         super.__btnHandler(param1);
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(model.emeDreamInfo.state != 1 && model.emeDreamInfo.state != 2)
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamPromptTxt" + model.emeDreamInfo.state);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(checkScene())
         {
            ConsortiaSocketOutManager.enterConsortiaBoss();
         }
         TaskTraceTipManager.instance.cleanByType(56);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:String = WorldBossHelper.getCampaignTips();
         if(StringHelper.isNullOrEmpty(_loc1_))
         {
            return true;
         }
         MessageTipManager.instance().show(_loc1_);
         return false;
      }
      
      override protected function check() : Boolean
      {
         return false;
      }
   }
}

