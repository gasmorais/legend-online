package map.campaign.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import map.net.MapSocketOuterManager;
   import mvc.module.armyII.BaseArmy;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.IconFactory;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class PrepareBattleFrame1 extends Frame
   {
      
      private var _acceptBtn:TextButton;
      
      private var _rejectBtn:TextButton;
      
      private var _bg:ScaleBitmapImage;
      
      private var _autoRejectTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _tipTxt:FilterFrameText;
      
      private var _icon:BaseIconView;
      
      private var _iconBg:Bitmap;
      
      private var _data:Object;
      
      private var _leftTime:int;
      
      private var _timeId:int;
      
      private var _boss:ThaneInfo;
      
      public function PrepareBattleFrame1()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("map.campaign.PrepareBattleFrameBg");
         _iconBg = ComponentFactory.Instance.creatBitmap("asset.core.army.SubHeroBack");
         _acceptBtn = ComponentFactory.Instance.creatComponentByStylename("map.campaign.PrepareBattleAcceptBtn");
         _rejectBtn = ComponentFactory.Instance.creatComponentByStylename("map.campaign.PrepareBattleRejectBtn");
         _autoRejectTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.room.PrepareBattleAutoRejectTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.room.PrepareBattleBossTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.room.PrepareBattleBossLevelTxt");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.room.PrepareBattleTipTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("campaign.PrepareFrameItemView");
         _acceptBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.accept");
         _rejectBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.reject");
         _tipTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.tip");
         addToContent(_bg);
         addToContent(_icon);
         addToContent(_nameTxt);
         addToContent(_levelTxt);
         addToContent(_tipTxt);
         addToContent(_autoRejectTxt);
         addToContent(_acceptBtn);
         addToContent(_rejectBtn);
      }
      
      private function uninit() : void
      {
         clearInterval(_timeId);
         _acceptBtn = null;
         _rejectBtn = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _rejectBtn.addEventListener("click",__onRejectHandler);
         _acceptBtn.addEventListener("click",__onAcceptHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_rejectBtn)
         {
            _rejectBtn.removeEventListener("click",__onRejectHandler);
         }
         if(_acceptBtn)
         {
            _acceptBtn.removeEventListener("click",__onAcceptHandler);
         }
      }
      
      private function __onRejectHandler(param1:Event) : void
      {
         var _loc2_:BaseArmy = ArmyManager.instance.army;
         MapSocketOuterManager.sendCampaignArrive(_loc2_.id,int(_data.boss.templateId),false);
         dispose();
      }
      
      private function __onAcceptHandler(param1:Event) : void
      {
         var _loc2_:BaseArmy = ArmyManager.instance.army;
         MapSocketOuterManager.sendCampaignArrive(_loc2_.id,int(_data.boss.templateId));
         dispose();
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
      
      private function __onCloseHandler(param1:Event) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         leftTime = int(_data["time"]);
         _boss = ThaneInfo(_data["boss"]);
         if(_boss.templateId <= 0)
         {
            _icon.icon = null;
            return;
         }
         _nameTxt.text = _boss.nickName;
         _levelTxt.text = _boss.grades.toString();
         if(!_boss.templateInfo || Boolean(StringHelper.isNullOrEmpty(_boss.templateInfo.Icon)))
         {
            _icon.icon = null;
         }
         else
         {
            _icon.icon = IconFactory.getHeroIconByPics(_boss.templateInfo.Icon);
         }
      }
      
      private function set leftTime(param1:int) : void
      {
         _leftTime = param1;
         _autoRejectTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.autoReject",_leftTime);
         if(_leftTime > 0)
         {
            if(_timeId > 0)
            {
               clearInterval(_timeId);
            }
            _timeId = 0;
            _timeId = setTimeout(refreshLeftTime,1000);
         }
         else
         {
            dispose();
         }
      }
      
      private function refreshLeftTime() : void
      {
         leftTime = _leftTime - 1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         if(_acceptBtn)
         {
            _acceptBtn.dispose();
         }
         _acceptBtn = null;
         if(_rejectBtn)
         {
            _rejectBtn.dispose();
         }
         _rejectBtn = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_autoRejectTxt)
         {
            _autoRejectTxt.dispose();
         }
         _autoRejectTxt = null;
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
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_iconBg)
         {
            _iconBg.bitmapData.dispose();
         }
         _iconBg = null;
         _data = null;
         _boss = null;
         super.dispose();
      }
   }
}

