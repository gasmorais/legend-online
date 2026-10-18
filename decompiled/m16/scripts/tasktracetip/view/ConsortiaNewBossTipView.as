package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.MopupManager;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaNewBossTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      private var _icon:BaseIconView;
      
      public function ConsortiaNewBossTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.GetGiftBtn");
         _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.ConsortiaNewBossTipView.ContentTxt");
         _textBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.skipNow");
         _icon = ComponentFactory.Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         _icon.icon = ComponentFactory.Instance.creatBitmap("asset.taskTraceTips.ConsortiaNewBossIcon");
         addChild(_contentTxt);
         addChild(_textBtn);
         addChild(_icon);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         super.__btnHandler(param1);
         if(FreedomTeamManager.instance.hasTeam)
         {
            _loc2_ = LanguageMgr.GetTranslation("resourcebar.view.consortianewboss.inTeam");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.tip01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FrameControllerManager.instance.landMineController.isInLandMineFrame)
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inLandMine.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FrameControllerManager.instance.gemMazeController.isEnterGemMaze)
         {
            _loc2_ = LanguageMgr.GetTranslation("ChatOutputViewII.inGemMaze.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip06");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:String = WorldBossHelper.getCampaignTips();
         if(_loc3_ != "")
         {
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(playerInfo.consortiaID == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.view.ChatView.consortianewboss.command");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("consortianewboss",1);
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override protected function check() : Boolean
      {
         return false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

