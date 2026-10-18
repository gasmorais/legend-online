package childpatrol
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildPatrolHallTowerView extends Component
   {
      
      private var hitContiner:Component;
      
      private var mcContiner:Component;
      
      private var towerMc:MovieClip;
      
      private var nameBack:ScaleFrameImage;
      
      private var numberText:FilterFrameText;
      
      private var levelText:FilterFrameText;
      
      private var rewardBtn:BaseButton;
      
      private var riotBtn:BaseButton;
      
      private var timeText:FilterFrameText;
      
      private var _time:TimeDownView;
      
      private var _stateMc:MovieClip;
      
      private var towerInfo:ChildPatrolTowerInfo;
      
      private var nextUpgradeTemp:UpgradeTemplateInfo;
      
      private var _buildingFilter:SimpleBuildingFilter;
      
      private var _entranceSp:Sprite;
      
      private var _entranceBtn:BaseButton;
      
      private var _entranceIdx:MovieClip;
      
      private var _exporeTimeText:FilterFrameText;
      
      private var _exporeTime:TimeDownView;
      
      public function ChildPatrolHallTowerView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         hitContiner = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.hitContiner");
         mcContiner = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.mcContiner");
         nameBack = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.nameBack");
         numberText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.numberText");
         levelText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.levelText");
         rewardBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.rewardBtn");
         riotBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.riotBtn");
         timeText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.timeText");
         _time = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.UpdateTime");
         _exporeTimeText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.exporeTimeTxt");
         _exporeTime = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallTowerView.exporeTime.UpdateTime");
         _entranceSp = ComponentFactory.Instance.creatCustomObject("ChildPatrolHallTowerView.entranceSp");
         _entranceBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolLeftListView.entraceBtn");
         _entranceIdx = ComponentFactory.Instance.creatCustomObject("asset.ChildPatrol.entranceIdx");
         addChild(hitContiner);
         addChild(nameBack);
         addChild(numberText);
         addChild(levelText);
         addChild(rewardBtn);
         addChild(riotBtn);
         addChild(timeText);
         addChild(_time);
         addChild(_exporeTimeText);
         addChild(_exporeTime);
         addChild(_entranceSp);
         _entranceSp.addChild(_entranceBtn);
         _entranceSp.addChild(_entranceIdx);
         hitContiner.addChild(mcContiner);
         mcContiner.mouseChildren = mcContiner.mouseEnabled = false;
         _buildingFilter = new SimpleBuildingFilter();
         timeText.text = LanguageMgr.GetTranslation("ChildPatrolHallTowerView.timeText.text");
         cleanView();
      }
      
      private function addEvent() : void
      {
         rewardBtn.addEventListener("click",__getRewardHandler);
         riotBtn.addEventListener("click",__riotClickHandler);
         hitContiner.addEventListener("mouseOver",__mouseOverHandler);
         hitContiner.addEventListener("mouseOut",__mouseOutHandler);
         hitContiner.addEventListener("click",__towerClickHandler);
         _entranceBtn.addEventListener("click",entranceClickHandler);
      }
      
      private function removeEvent() : void
      {
         rewardBtn.removeEventListener("click",__getRewardHandler);
         riotBtn.removeEventListener("click",__riotClickHandler);
         hitContiner.removeEventListener("mouseOver",__mouseOverHandler);
         hitContiner.removeEventListener("mouseOut",__mouseOutHandler);
         hitContiner.removeEventListener("click",__towerClickHandler);
         _entranceBtn.removeEventListener("click",entranceClickHandler);
      }
      
      private function entranceClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childpve",null,towerInfo);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(towerMc && towerMc["effect_area"])
         {
            _buildingFilter.setBuildingOverFilter(towerMc["effect_area"]);
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(towerMc && towerMc["effect_area"])
         {
            _buildingFilter.setBuildingOutFilter(towerMc["effect_area"]);
         }
      }
      
      private function __getRewardHandler(param1:MouseEvent) : void
      {
         if(playerModel.playerInfo.userId != model.curUserId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrol.ChildPatrolHallTowerView.getReward.alert"));
            return;
         }
         ChildPatrolManager.instance.sendChildPatrolOperate(7,0,0,towerInfo.towerId);
      }
      
      private function __riotClickHandler(param1:MouseEvent) : void
      {
         if(playerModel.playerInfo.userId == model.curUserId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrol.ChildPatrolHallTowerView.friendHelp.alert"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("childpatrol",4,towerInfo);
      }
      
      private function __towerClickHandler(param1:MouseEvent) : void
      {
         if(!towerInfo)
         {
            return;
         }
         if(model.curUserId != playerModel.playerInfo.userId)
         {
            return;
         }
         if(towerInfo.towerId == 100)
         {
            FrameControllerManager.instance.openControllerByInfo("childpatrol",2,towerInfo);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("childpatrol",3,towerInfo);
         }
      }
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
         var _loc2_:int = 0;
         towerInfo = param1;
         cleanView();
         setTowerAndStateMc(towerInfo);
         if(!towerInfo)
         {
            return;
         }
         nameBack.visible = true;
         levelText.text = "(" + LanguageMgr.GetTranslation("public.level2",towerInfo.level) + ")";
         if(towerInfo.patrolLeftTime > 0)
         {
            timeText.visible = true;
            _time.timeCount = towerInfo.patrolLeftTime;
            _time.visible = true;
         }
         if(towerInfo.towerId == 100)
         {
            nextUpgradeTemp = model.findUpgradeTempInfoByTypeAndGrade(114,towerInfo.level + 1);
            nameBack.setFrame(1);
            nameBack.x = 60;
            nameBack.y = 100;
            levelText.x = 165;
            levelText.y = 108;
            _stateMc.x = towerInfo.garrisonLeftTime > 0 ? 130 : 115;
         }
         else
         {
            nextUpgradeTemp = model.findUpgradeTempInfoByTypeAndGrade(114,towerInfo.level + 1);
            numberText.text = towerInfo.towerId.toString();
            nameBack.setFrame(2);
            nameBack.x = 25;
            nameBack.y = 75;
            levelText.x = 140;
            levelText.y = 83;
            _stateMc.x = towerInfo.garrisonLeftTime > 0 ? 60 : 45;
            if(model.curUserId == playerModel.playerInfo.userId)
            {
               if(towerInfo.exploreLeftTime > 0)
               {
                  _exporeTimeText.text = LanguageMgr.GetTranslation("ChildPatrolHallTowerView.exporeTimeTxt");
                  _exporeTimeText.visible = true;
                  _exporeTime.timeCount = towerInfo.exploreLeftTime;
                  _exporeTime.visible = true;
               }
               else
               {
                  _exporeTimeText.visible = true;
                  if(towerInfo.exploreChildId > 0)
                  {
                     _exporeTimeText.text = LanguageMgr.GetTranslation("ChildPatrolHallTowerView.canOverExporeTip");
                  }
                  else
                  {
                     _exporeTimeText.text = LanguageMgr.GetTranslation("ChildPatrolHallTowerView.canExporeTip");
                  }
               }
               _loc2_ = timeText.visible ? 130 : 115;
               _exporeTimeText.y = _exporeTime.y = _loc2_;
               if(_loc2_ == 130)
               {
                  _exporeTime.y = 145;
                  _exporeTime.x = 110;
               }
            }
         }
         if(model.curUserId == playerModel.playerInfo.userId)
         {
            if(nextUpgradeTemp)
            {
               addChild(_stateMc);
            }
            hitContiner.buttonMode = true;
            if(towerInfo.towerId != 100)
            {
               if(towerInfo.bossState != 1)
               {
                  _entranceSp.visible = true;
                  _entranceIdx.gotoAndStop(towerInfo.towerId);
               }
            }
         }
         if(towerInfo.state == 2)
         {
            riotBtn.visible = true;
         }
         else if(towerInfo.state == 3)
         {
            rewardBtn.visible = true;
         }
      }
      
      private function setTowerAndStateMc(param1:ChildPatrolTowerInfo) : void
      {
         var _loc3_:Sprite = null;
         var _loc2_:BitmapData = null;
         if(!_stateMc && param1)
         {
            if(param1.garrisonLeftTime > 0)
            {
               _stateMc = ComponentFactory.Instance.creatCustomObject("ChildPatrolHallTowerView.stateMc.onWork");
            }
            else
            {
               _stateMc = ComponentFactory.Instance.creatCustomObject("ChildPatrolHallTowerView.stateMc.offWork");
            }
         }
         if(!towerMc)
         {
            if(param1 && param1.towerId == 100)
            {
               towerMc = ComponentFactory.Instance.creatCustomObject("ChildPatrolHallTowerView.tower100Mc");
               hitContiner.x = 60;
            }
            else
            {
               towerMc = ComponentFactory.Instance.creatCustomObject("ChildPatrolHallTowerView.towerMc");
               hitContiner.x = 40;
            }
         }
         mcContiner.addChild(towerMc);
         if(towerMc && towerMc["effect_area"])
         {
            _loc2_ = new BitmapData(towerMc["effect_area"].width,towerMc["effect_area"].height,true,0);
            _loc2_.draw(towerMc["effect_area"]);
            _loc3_ = DisplayUtils.getHitArea(_loc2_,5);
            hitContiner.hitArea = _loc3_;
            mcContiner.addChild(_loc3_);
         }
      }
      
      private function cleanView() : void
      {
         nameBack.visible = false;
         levelText.text = "";
         numberText.text = "";
         rewardBtn.visible = false;
         riotBtn.visible = false;
         _time.timeCount = 0;
         _time.visible = false;
         timeText.visible = false;
         _exporeTime.timeCount = 0;
         _exporeTime.visible = false;
         _exporeTimeText.visible = false;
         hitContiner.buttonMode = false;
         _entranceSp.visible = false;
         ObjectUtils.disposeViolentMc(_stateMc);
         _stateMc = null;
         if(towerMc && towerMc.parent)
         {
            towerMc.parent.removeChild(towerMc);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(nameBack)
         {
            ObjectUtils.disposeObject(nameBack);
         }
         nameBack = null;
         if(levelText)
         {
            ObjectUtils.disposeObject(levelText);
         }
         levelText = null;
         if(rewardBtn)
         {
            ObjectUtils.disposeObject(rewardBtn);
         }
         rewardBtn = null;
         if(riotBtn)
         {
            ObjectUtils.disposeObject(riotBtn);
         }
         riotBtn = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(numberText)
         {
            ObjectUtils.disposeObject(numberText);
         }
         numberText = null;
         if(_stateMc)
         {
            ObjectUtils.disposeViolentMc(_stateMc);
         }
         _stateMc = null;
         if(timeText)
         {
            ObjectUtils.disposeObject(timeText);
         }
         timeText = null;
         if(towerMc)
         {
            ObjectUtils.disposeViolentMc(towerMc);
         }
         towerMc = null;
         if(mcContiner)
         {
            ObjectUtils.disposeObject(mcContiner);
         }
         mcContiner = null;
         if(hitContiner)
         {
            ObjectUtils.disposeObject(hitContiner);
         }
         hitContiner = null;
         ObjectUtils.disposeObject(_entranceBtn);
         _entranceBtn = null;
         ObjectUtils.disposeViolentMc(_entranceIdx);
         _entranceIdx = null;
         ObjectUtils.disposeObject(_entranceSp);
         _entranceSp = null;
         ObjectUtils.disposeObject(_exporeTimeText);
         _exporeTimeText = null;
         ObjectUtils.disposeObject(_exporeTime);
         _exporeTime = null;
         towerInfo = null;
         nextUpgradeTemp = null;
         _buildingFilter = null;
         super.dispose();
      }
   }
}

