package ui.toptoolbar.view
{
   import chat.view.ChatItemMenu;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import managers.FreedomTeamManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignMapEvent;
   import map.space.data.SpaceArmy;
   import mvc.module.armyII.BaseArmy;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.IconFactory;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseIconView;
   
   public class TargetSelectView extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _iconMask:Sprite;
      
      private var _iconMaskAsset:Bitmap;
      
      private var _level:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      private var _operateBtn:IconButton;
      
      private var _maskBtn:BaseButton;
      
      private var _data:BaseArmy;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _menu:ChatItemMenu;
      
      public function TargetSelectView()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.toptoolbar.TargetSelectBack");
         _icon = ComponentFactory.Instance.creatCustomObject("toptoolbar.TargetIcon");
         _iconMaskAsset = ComponentFactory.Instance.creatBitmap("asset.toptoolbar.TargetSelectMask");
         _level = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.LevelText");
         _name = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.NickNameText");
         _operateBtn = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.OperateBtn");
         _maskBtn = ComponentFactory.Instance.creatComponentByStylename("core.ChestOKBtn");
         _iconMask = new Sprite();
         _iconMaskAsset.blendMode = "alpha";
         _iconMask.blendMode = "layer";
         _iconMask.addChild(_icon);
         _iconMask.addChild(_iconMaskAsset);
         addChild(_back);
         addChild(_iconMask);
         addChild(_level);
         addChild(_name);
         addChild(_operateBtn);
         addChild(_maskBtn);
         _maskBtn.x = 84;
         _maskBtn.y = 51;
         _maskBtn.width = 60;
         _maskBtn.height = 23;
         _maskBtn.alpha = 0;
      }
      
      private function setVocation() : void
      {
         if(_data.baseHero.vocationGrades > 0)
         {
            if(_vocationIcon == null)
            {
               _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.targetSelectBar.VocationIconBtn");
               addChild(_vocationIcon);
            }
            _vocationIcon.visible = true;
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_data.baseHero.templateInfo.Job,_data.baseHero.vocationStep,_data.baseHero.vocationLevel);
            _vocationIcon.setFrame(_data.baseHero.vocationLevel);
         }
         else if(_vocationIcon)
         {
            _vocationIcon.visible = false;
         }
      }
      
      public function set data(param1:BaseArmy) : void
      {
         _data = param1;
         if(_data)
         {
            _icon.icon = IconFactory.getPlayerIcon(_data.baseHero.headId,"head");
            _level.text = _data.baseHero.grades.toString();
            _name.text = _data.baseHero.nickName;
            if(_data)
            {
               _data.addEventListener("ONLINE_STATE",__onlineStateHandler);
            }
            setVocation();
         }
      }
      
      private function addEvent() : void
      {
         _operateBtn.addEventListener("click",__operateClickHandler);
         _maskBtn.addEventListener("click",__maskClickHandler);
         _maskBtn.addEventListener("rollOver",__maskRollOverHandler);
         _maskBtn.addEventListener("rollOut",__maskRollOutHandler);
      }
      
      private function removeEvent() : void
      {
         _operateBtn.removeEventListener("click",__operateClickHandler);
         _maskBtn.removeEventListener("click",__maskClickHandler);
         _maskBtn.removeEventListener("rollOver",__maskRollOverHandler);
         _maskBtn.removeEventListener("rollOut",__maskRollOutHandler);
         if(_data)
         {
            _data.removeEventListener("ONLINE_STATE",__onlineStateHandler);
         }
      }
      
      private function __onlineStateHandler(param1:CampaignMapEvent) : void
      {
         if(!_data || !(_data is CampaignArmy))
         {
            PlayerManager.instance.currentPlayerModel.selectTarget = null;
         }
         else if(!(_data as CampaignArmy).online)
         {
            PlayerManager.instance.currentPlayerModel.selectTarget = null;
         }
      }
      
      private function __maskClickHandler(param1:MouseEvent) : void
      {
         _operateBtn.dispatchEvent(new MouseEvent("click"));
      }
      
      private function __maskRollOverHandler(param1:MouseEvent) : void
      {
         _operateBtn.dispatchEvent(new MouseEvent("rollOver"));
      }
      
      private function __maskRollOutHandler(param1:MouseEvent) : void
      {
         _operateBtn.dispatchEvent(new MouseEvent("rollOut"));
      }
      
      private function __operateClickHandler(param1:MouseEvent) : void
      {
         var _loc8_:Boolean = false;
         if(playerInfo.consortiaID > 0)
         {
            _loc8_ = FrameControllerManager.instance.consortiaController.getRightsByIndex(9);
            _loc8_ = _loc8_ && _data.baseHero.consortiaID <= 0;
         }
         var _loc3_:Boolean = canShowAttackBtn();
         var _loc4_:Boolean = canShowPkBtn();
         var _loc5_:Boolean = false;
         if(_data is SpaceArmy)
         {
            _loc5_ = (_data as SpaceArmy).isRobot;
         }
         var _loc7_:int = _level.x + _level.width;
         var _loc6_:int = _level.y + _level.height;
         var _loc2_:Point = localToGlobal(new Point(_loc7_,_loc6_));
         showUseMenu(_loc2_.x,_loc2_.y,_data.baseHero.nickName,_data.baseHero.userId,_data.baseHero.grades,_loc8_,null,_loc3_,_loc4_,_loc5_);
      }
      
      private function canShowAttackBtn() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = CampaignManager.instance.mapId;
            if(!isSelf() && (WorldBossHelper.checkPetLand(_loc2_) || WorldBossHelper.checkMineralPVP(_loc2_)))
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      private function canShowPkBtn() : Boolean
      {
         if(SceneManager.instance.currentType == "SPACE_SCENE" && !isSelf())
         {
            return true;
         }
         return false;
      }
      
      private function isSelf() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         return playerInfo.userId == _data.userId && playerInfo.serviceName == _data.baseHero.serviceName;
      }
      
      private function showUseMenu(param1:int, param2:int, param3:String, param4:int, param5:int, param6:Boolean, param7:String = null, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false) : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         var _loc11_:Boolean = FreedomTeamManager.instance.canInviteMember(param4,param5);
         _menu = new ChatItemMenu(param3,param4,param6,param7,param8,param9,param10,_loc11_);
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = param1;
         _menu.y = param2;
         if(_menu.y < 0)
         {
            _menu.y = 0;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_iconMask);
         ObjectUtils.disposeObject(_icon);
         ObjectUtils.disposeObject(_iconMaskAsset);
         ObjectUtils.disposeObject(_back);
         ObjectUtils.disposeObject(_level);
         ObjectUtils.disposeObject(_name);
         ObjectUtils.disposeObject(_operateBtn);
         ObjectUtils.disposeObject(_iconMask);
         ObjectUtils.disposeObject(_maskBtn);
         if(_vocationIcon)
         {
            ObjectUtils.disposeObject(_vocationIcon);
            _vocationIcon = null;
         }
         _iconMask = null;
         _icon = null;
         _iconMaskAsset = null;
         _back = null;
         _level = null;
         _name = null;
         _operateBtn = null;
         _maskBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

