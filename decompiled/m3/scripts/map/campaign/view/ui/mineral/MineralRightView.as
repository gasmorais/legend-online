package map.campaign.view.ui.mineral
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MineralCarInfo;
   import map.campaign.data.MineralModel;
   import ui.tasktracebar.view.SpaceMapButtonView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class MineralRightView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _title:FilterFrameText;
      
      private var _countText:FilterFrameText;
      
      private var _mineralText:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _mapBtn:SpaceMapButtonView;
      
      private var _lookBtn:IconButton;
      
      private var _rewardView:MineralRewardView;
      
      private var _helpBtn:BaseButton;
      
      public function MineralRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralRightView.bg");
         _title = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralRightView.title");
         _countText = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralRightView.countText");
         _mineralText = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralRightView.mineralText");
         _score = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralRightView.score");
         _mapBtn = ComponentFactory.Instance.creatCustomObject("taskTrace.SpaceMapButtonView");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("mineral.MineralRightView.lookBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.Mineral.HelpBtn");
         _mapBtn.x = 0;
         _mapBtn.y = 170;
         _rewardView = new MineralRewardView();
         addChild(_bg);
         addChild(_helpBtn);
         addChild(_title);
         addChild(_countText);
         addChild(_mineralText);
         addChild(_score);
         addChild(_lookBtn);
         addChild(_mapBtn);
         addChild(_rewardView);
         _rewardView.visible = false;
         _rewardView.x = -240;
         _rewardView.y = 65;
      }
      
      private function addEvent() : void
      {
         PlayerManager.instance.addEventListener("PLAYER_INFO_UPDATE",__updateHandler);
         mineralModel.addEventListener("UPDATE_MINERAL_INFO",__updateHandler);
         _helpBtn.addEventListener("click",__onHelpBtnHandler);
         _lookBtn.addEventListener("click",__lookRewardHandler);
      }
      
      private function __lookRewardHandler(param1:MouseEvent) : void
      {
         if(_rewardView)
         {
            _rewardView.visible = !_rewardView.visible;
         }
      }
      
      private function __updateHandler(param1:Event) : void
      {
         if(!selfCarInfo)
         {
            return;
         }
         if(selfCarInfo.is_own == 1)
         {
            _countText.text = LanguageMgr.GetTranslation("map.campaign.view.ui.mineral.countText",100 - selfCarInfo.pick_count) + " / 100";
         }
         else if(selfCarInfo.is_own == 0)
         {
            _countText.text = LanguageMgr.GetTranslation("map.campaign.view.ui.mineral.countText",0) + " / 100";
         }
         if(mineralModel.activeTime > 0)
         {
            _title.text = LanguageMgr.GetTranslation("map.campaign.view.ui.mineral.titleText2",mineralModel.multiple,Math.ceil(mineralModel.activeTime / 60));
         }
         else
         {
            _title.text = LanguageMgr.GetTranslation("map.campaign.view.ui.mineral.titleText1");
         }
         _mineralText.text = selfCarInfo.minerals + " / 200";
         _score.text = playerInfo.mineral + "";
      }
      
      private function removeEvent() : void
      {
         PlayerManager.instance.removeEventListener("PLAYER_INFO_UPDATE",__updateHandler);
         if(mineralModel)
         {
            mineralModel.removeEventListener("UPDATE_MINERAL_INFO",__updateHandler);
         }
         if(_lookBtn)
         {
            _lookBtn.removeEventListener("click",__lookRewardHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__onHelpBtnHandler);
         }
      }
      
      private function __onHelpBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         SoundManager.instance.play("022");
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.MineralHelpFrame");
         _loc2_.show();
      }
      
      private function get selfCarInfo() : MineralCarInfo
      {
         return CampaignManager.instance.mineralModel.selfCarInfo;
      }
      
      private function get mineralModel() : MineralModel
      {
         return CampaignManager.instance.mineralModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         if(_countText)
         {
            _countText.dispose();
         }
         _countText = null;
         if(_mineralText)
         {
            _mineralText.dispose();
         }
         _mineralText = null;
         if(_score)
         {
            _score.dispose();
         }
         _score = null;
         if(_mapBtn)
         {
            _mapBtn.dispose();
         }
         _mapBtn = null;
         if(_helpBtn)
         {
            _helpBtn.dispose();
         }
         _helpBtn = null;
         if(_rewardView)
         {
            _rewardView.dispose();
         }
         _rewardView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

