package map.campaign.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.NotificationManager;
   import yishi.utils.StringHelper;
   import yishi.view.community.HeroIconCell;
   
   public class PrepareBattleFrame2 extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _icon:HeroIconCell;
      
      private var _nameTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _tipTxt:FilterFrameText;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _data:Object;
      
      private var _leftTime:int;
      
      private var _timeId:int;
      
      private var _boss:ThaneInfo;
      
      public function PrepareBattleFrame2()
      {
         super();
         initView();
      }
      
      override public function set closestyle(param1:String) : void
      {
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("map.campaign.PrepareBattleFrameBg1");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.room.PrepareBattleBossTxt1");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.room.PrepareBattleBossLevelTxt1");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.room.PrepareBattleTipTxt1");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.room.PrepareBattleAutoRejectTxt1");
         _icon = ComponentFactory.Instance.creatCustomObject("campaign.PrepareFrameItemView");
         _tipTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame2.tip");
         _hBox = new HBox();
         _hBox.x = -9;
         _hBox.y = 109;
         _hBox.spacing = 6;
         addToContent(_bg);
         addToContent(_icon);
         addToContent(_nameTxt);
         addToContent(_levelTxt);
         addToContent(_tipTxt);
         addToContent(_leftTimeTxt);
         addToContent(_hBox);
      }
      
      private function uninit() : void
      {
         clearInterval(_timeId);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         _data = param1;
         setTeam();
         leftTime = _data["time"];
         setBoss(_data["boss"] as ThaneInfo);
      }
      
      private function setBoss(param1:ThaneInfo) : void
      {
         _boss = param1;
         if(_boss)
         {
            if(_boss.templateId <= 0)
            {
               _icon.data = null;
               return;
            }
            _nameTxt.text = _boss.nickName;
            _levelTxt.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_boss.grades);
            if(StringHelper.isNullOrEmpty(_boss.templateInfo.Icon))
            {
               _icon.data = null;
            }
            else
            {
               _icon.data = _boss;
            }
         }
      }
      
      private function set leftTime(param1:int) : void
      {
         _leftTime = param1;
         _leftTimeTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame2.autoReject",_leftTime);
         if(_leftTime > 0)
         {
            if(_timeId > 0)
            {
               clearInterval(_timeId);
            }
            _timeId = 0;
            _timeId = setTimeout(refreshTime,1000);
         }
         else
         {
            dispose();
         }
      }
      
      private function refreshTime() : void
      {
         leftTime = _leftTime - 1;
      }
      
      private function setTeam() : void
      {
         var _loc1_:PlayerCell = null;
         _hBox.disposeAllChildren();
         var _loc3_:Dictionary = _data["team"] as Dictionary;
         for each(var _loc2_:ThaneInfo in _loc3_)
         {
            _loc1_ = new PlayerCell();
            _loc1_.data = _loc2_;
            _hBox.addChild(_loc1_);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         uninit();
         super.dispose();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_levelTxt)
         {
            _levelTxt.dispose();
         }
         _levelTxt = null;
         if(_tipTxt)
         {
            _tipTxt.dispose();
         }
         _tipTxt = null;
         if(_leftTimeTxt)
         {
            _leftTimeTxt.dispose();
         }
         _leftTimeTxt = null;
         if(_hBox)
         {
            _hBox.dispose();
         }
         _hBox = null;
         NotificationManager.instance.sendNotification("PREPARE_BATTLE_FRAME2_COLSE");
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

