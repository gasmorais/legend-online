package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.PetBossModel;
   import tasktracetip.data.TipMessageData;
   import yishi.SwitchPageHelp;
   import yishi.manager.ArmyManager;
   import yishi.scene.SceneManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class PetBossTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseIconView;
      
      private var _contentTxt:FilterFrameText;
      
      public function PetBossTipView()
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
         _icon.icon = ComponentFactory.Instance.creatBitmap("asset.taskTraceTips.PetBossIcon");
         _icon.tipStyle = "yishi.view.tips.OneLineTip";
         _icon.tipData = LanguageMgr.GetTranslation("tasktracetip.view.PetBossTipView.iconTip");
         _textBtn.text = LanguageMgr.GetTranslation("gameguide.GameGuideFrame.skipNow");
         addChild(_contentTxt);
         addChild(_textBtn);
         addChild(_icon);
         __switchHandler(null,null);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         MsgMan.addObserver("CampaignEvent.PET_BOSS_SWITCH",this,__switchHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         MsgMan.removeObserver("CampaignEvent.PET_BOSS_SWITCH",this,__switchHandler);
      }
      
      private function __switchHandler(param1:String, param2:Object) : void
      {
         if(!CampaignManager.instance.petBossModel.isOpen)
         {
            dispose();
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
         super.__btnHandler(param1);
         var _loc2_:PetBossModel = CampaignManager.instance.petBossModel;
         if(_loc2_.isOpen)
         {
            if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("taskTrace.SinglepassHasBugleYipsView.TipInfo"));
               return;
            }
            if(ArmyManager.instance.thane.grades < 50)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("tasktracetip.view.PetBossTipView.LevelTips"));
            }
            else
            {
               SwitchPageHelp.walkToCrossMapTarget(_loc2_.mapId + "," + _loc2_.nodeId);
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.view.DailyItem.PetBossUnOpen"));
            dispose();
         }
      }
      
      override protected function check() : Boolean
      {
         return false;
      }
   }
}

