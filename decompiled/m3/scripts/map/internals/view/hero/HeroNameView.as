package map.internals.view.hero
{
   import avatar.view.AppellView;
   import avatar.view.SimpleAvatarView;
   import chat.datas.ChatFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ArmyEvent;
   import events.PetEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import map.internals.constant.ArmyState;
   import map.internals.data.PhysicsEvent;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   import yishi.view.tools.SimpleMovie;
   
   public class HeroNameView extends BaseNameView
   {
      
      private var _data:SpaceArmy;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _honerTxt:GradientText;
      
      private var _honerView:AppellView;
      
      private var _vipIcon:Bitmap;
      
      private var _vipText:GradientText;
      
      private var _showNamePosY:Number = -125;
      
      private var _chatPopView:Component;
      
      private var _attackView:SimpleAvatarView;
      
      private var _isMounting:Boolean = false;
      
      private var _isFlying:Boolean = false;
      
      private var _appellId:int = 0;
      
      private var simpleMovie:SimpleMovie;
      
      public function HeroNameView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _npcName = ComponentFactory.Instance.creatComponentByStylename("core.NpcNameText");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("map.campaign.ConsortiaText");
         _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
         _vipText = ComponentFactory.Instance.creatComponentByStylename("core.NpcName_VipText");
         _consortiaTxt.cacheAsBitmap = true;
         _vipText.cacheAsBitmap = true;
         addChild(_npcName);
      }
      
      private function get isSelf() : Boolean
      {
         if(_data)
         {
            return _data.userId == playerInfo.userId;
         }
         return false;
      }
      
      private function get isSelfConsortia() : Boolean
      {
         if(_data && _data.baseHero)
         {
            if(StringHelper.isNullOrEmpty(_data.baseHero.consortiaName))
            {
               return false;
            }
            if(StringHelper.isNullOrEmpty(playerInfo.consortiaName))
            {
               return false;
            }
            return _data.baseHero.consortiaName == playerInfo.consortiaName;
         }
         return false;
      }
      
      public function set data(param1:SpaceArmy) : void
      {
         if(_data == param1)
         {
            return;
         }
         removeEvent();
         _data = param1;
         addEvent();
         showAvatar(param1);
         __updateInfoHandler(null);
         __updateSpaceArmyStateHandler(null);
      }
      
      protected function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("CHAT_DATA",__chatHandler);
            _data.addEventListener("UPDATE_STATE",__updateSpaceArmyStateHandler);
            if(isSelf)
            {
               PlayerManager.instance.addEventListener("PET_LEVEL_UP",__petLevelUpHandler);
               thane.addEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
               thane.addEventListener("THANE_INFO_UPDATE",__updateSpaceArmyPetHandler);
            }
            else
            {
               _data.baseHero.addEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
               _data.baseHero.addEventListener("THANE_INFO_UPDATE",__updateSpaceArmyPetHandler);
            }
            _data.baseHero.addEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
            _data.baseHero.addEventListener("APPELL_CHANGE",__updateInfoHandler);
         }
      }
      
      protected function removeEvent() : void
      {
         PlayerManager.instance.removeEventListener("PET_LEVEL_UP",__petLevelUpHandler);
         if(_data)
         {
            _data.removeEventListener("CHAT_DATA",__chatHandler);
            _data.removeEventListener("UPDATE_STATE",__updateSpaceArmyStateHandler);
            if(isSelf)
            {
               thane.removeEventListener("PLAYER_AVATA_CHANGE",__heroPropertyHandler);
               thane.removeEventListener("THANE_INFO_UPDATE",__updateSpaceArmyPetHandler);
            }
            else
            {
               _data.baseHero.removeEventListener("PLAYER_AVATA_CHANGE",__avatarChangeHandler);
               _data.baseHero.removeEventListener("THANE_INFO_UPDATE",__updateSpaceArmyPetHandler);
            }
            _data.baseHero.removeEventListener("PLAYER_INFO_UPDATE",__updateInfoHandler);
            _data.baseHero.removeEventListener("APPELL_CHANGE",__updateInfoHandler);
         }
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         super.showName(param1,param2,param3,param4,param5);
         setHonerName();
         setConsortiaName(consortiaName,param5);
         setNpcName(param1,param5);
         isVip ? setVipIcon() : clearVipIcon();
         layout();
      }
      
      private function setNpcName(param1:String, param2:int) : void
      {
         if(isSelf || isSelfConsortia)
         {
            _npcName.visible = true;
            _vipText.visible = false;
         }
         else if(isVip)
         {
            _npcName.visible = false;
            _vipText.visible = true;
         }
         else
         {
            _npcName.visible = true;
            _vipText.visible = false;
         }
         _vipText.text = _data.baseHero.nickName;
         _npcName.text = _data.baseHero.nickName;
         _npcName.setFrame(param2);
         addChild(_npcName);
         addChild(_vipText);
      }
      
      public function setConsortiaName(param1:String, param2:int, param3:Boolean = false) : void
      {
         if(StringHelper.isNullOrEmpty(param1))
         {
            _consortiaTxt.text = "";
            return;
         }
         _consortiaTxt.text = param3 ? param1 : LanguageMgr.GetTranslation("map.avatar.view.consortiaName",param1);
         _consortiaTxt.setFrame(param2);
         if(_isPlaying)
         {
            addChild(_consortiaTxt);
         }
      }
      
      private function get appellId() : int
      {
         if(!isSelf && _data)
         {
            return _data.baseHero.appellId;
         }
         return thane.appellId;
      }
      
      private function setHonerName() : void
      {
         if(_appellId == appellId && (_honerView && _honerView.parent || _honerTxt && _honerTxt.parent))
         {
            return;
         }
         _appellId = appellId;
         if(_honerTxt && _honerTxt.parent)
         {
            _honerTxt.parent.removeChild(_honerTxt);
         }
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         if(_honerView && _honerView.parent)
         {
            _honerView.parent.removeChild(_honerView);
         }
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         if(isHoner && _isPlaying)
         {
            _honerTxt = ComponentFactory.Instance.creatComponentByStylename(honerStyle);
            _honerTxt.cacheAsBitmap = true;
            _honerTxt.text = honerName;
            _honerView = new AppellView(_data.baseHero.appellInfo);
            showHoner();
         }
      }
      
      private function showHoner() : void
      {
         if(VersionSwitch.APPELL)
         {
            if(_honerTxt && _honerTxt.parent)
            {
               _honerTxt.parent.removeChild(_honerTxt);
            }
            if(_honerView)
            {
               addChild(_honerView);
            }
         }
         else
         {
            if(_honerTxt)
            {
               addChild(_honerTxt);
            }
            if(_honerView && _honerView.parent)
            {
               _honerView.parent.removeChild(_honerView);
            }
         }
      }
      
      private function hideHoner() : void
      {
         if(_honerTxt && _honerTxt.parent)
         {
            _honerTxt.parent.removeChild(_honerTxt);
         }
         if(_honerView && _honerView.parent)
         {
            _honerView.parent.removeChild(_honerView);
         }
      }
      
      private function get honerStyle() : String
      {
         if(VersionSwitch.APPELL && _data.baseHero.appellInfo)
         {
            return "map.campaign.HonerText" + _data.baseHero.appellInfo.Quality;
         }
         return "map.campaign.HonerText";
      }
      
      private function get honerName() : String
      {
         if(VersionSwitch.APPELL)
         {
            return _data.baseHero.appellInfo.Title;
         }
         return _data.baseHero.honerTemp.TemplateName;
      }
      
      private function get isHoner() : Boolean
      {
         if(VersionSwitch.APPELL)
         {
            return _data.baseHero.appellId != 0;
         }
         return _data.baseHero.honer >= _data.baseHero.firstHonerTemp.Data;
      }
      
      private function setVipIcon() : void
      {
         if(!_vipIcon.parent)
         {
            addChild(_vipIcon);
         }
         _vipIcon.visible = true;
      }
      
      private function clearVipIcon() : void
      {
         _vipIcon.visible = false;
      }
      
      private function get isVip() : Boolean
      {
         return _data.baseHero.IsVipAndNoExpirt;
      }
      
      private function get consortiaName() : String
      {
         if(isSelf)
         {
            return thane.consortiaName;
         }
         return _data.baseHero.consortiaName;
      }
      
      override public function layout() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(!_data)
         {
            return;
         }
         _showNamePosY = -125;
         if(heroView)
         {
            _showNamePosY = getPosYBySizeType(heroView.sizeType,heroView.flight);
         }
         if(_npcName)
         {
            _npcName.x = -_npcName.width / 2;
            _npcName.y = int(_showNamePosY);
         }
         if(_consortiaTxt)
         {
            _consortiaTxt.x = -_consortiaTxt.width / 2;
            _consortiaTxt.y = _showNamePosY - 20;
         }
         if(consortiaName && isPlaying)
         {
            if(_consortiaTxt && !_consortiaTxt.parent)
            {
               addChild(_consortiaTxt);
            }
         }
         else if(_consortiaTxt && _consortiaTxt.parent)
         {
            _consortiaTxt.parent.removeChild(_consortiaTxt);
         }
         if(_vipIcon != null && _npcName != null)
         {
            _loc2_ = _vipIcon.width + _npcName.textWidth + 10;
            _loc1_ = _npcName.width - _npcName.textWidth >> 1;
            _vipIcon.y = _npcName.y;
            _vipIcon.x = -_loc2_ >> 1;
            if(isVip)
            {
               _npcName.x = _vipIcon.x + _vipIcon.width - _loc1_ + 1;
            }
            if(_vipText)
            {
               _vipText.x = _npcName.x;
               _vipText.y = _npcName.y;
            }
         }
         if(_honerView)
         {
            _honerView.x = -_data.baseHero.appellInfo.ImgWidth / 2;
            if(_data.baseHero.consortiaName)
            {
               _honerView.y = _showNamePosY - _data.baseHero.appellInfo.ImgHeight - 20;
            }
            else
            {
               _honerView.y = _showNamePosY - _data.baseHero.appellInfo.ImgHeight;
            }
         }
         if(_honerTxt)
         {
            _honerTxt.x = -_honerTxt.width / 2;
            if(_data.baseHero.consortiaName)
            {
               _honerTxt.y = _showNamePosY - 40;
            }
            else
            {
               _honerTxt.y = _showNamePosY - 20;
            }
         }
         if(_attackView)
         {
            _attackView.y = _showNamePosY - 90;
         }
      }
      
      override public function execute() : void
      {
         if(!_data)
         {
            return;
         }
         if(isPlaying)
         {
            if(_attackView)
            {
               _attackView.draw();
            }
            if(_honerView)
            {
               _honerView.draw();
            }
         }
      }
      
      private function __updateInfoHandler(param1:PlayerEvent) : void
      {
         var _loc2_:ThaneInfo = null;
         if(param1)
         {
            _loc2_ = param1.currentTarget as ThaneInfo;
            data.petInfo.petTemplateId = _loc2_.petTemplateId;
            data.petInfo.petName = _loc2_.petName;
            data.petInfo.petQuaity = _loc2_.petQuaity;
            data.petInfo.commit();
         }
         var _loc3_:int = 2;
         if(isSelf)
         {
            _loc3_ = 1;
         }
         else if(isSelfConsortia)
         {
            _loc3_ = 3;
         }
         showName(_data.nickName,_data.baseHero.grades,_data.baseHero.state,0,_loc3_);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function showAvatar(param1:SpaceArmy) : void
      {
         var _loc2_:ThaneInfo = param1.baseHero as ThaneInfo;
         layout();
      }
      
      protected function __heroPropertyHandler(param1:PlayerEvent) : void
      {
         if(!_data || !_data.baseHero || !SpaceManager.instance.model)
         {
            return;
         }
         var _loc2_:SpaceArmy = SpaceManager.instance.model.getUserArmyByUserId(_data.baseHero.userId);
         if(!_loc2_)
         {
            return;
         }
         _loc2_.baseHero.hideFashion = thane.hideFashion;
         _loc2_.baseHero.changeShapeId = thane.changeShapeId;
         _loc2_.baseHero.bodyEquipAvata = thane.bodyEquipAvata;
         _loc2_.baseHero.armsEquipAvata = thane.armsEquipAvata;
         _loc2_.baseHero.wingAvata = thane.wingAvata;
         _loc2_.baseHero.bodyFashionAvata = thane.bodyFashionAvata;
         _loc2_.baseHero.armsFashionAvata = thane.armsFashionAvata;
         _loc2_.baseHero.hairFashionAvata = thane.hairFashionAvata;
         _loc2_.baseHero.wingAvata = thane.wingAvata;
         _loc2_.mountTemplateId = ArmyManager.instance.army.mountTemplateId;
         showAvatar(_data);
      }
      
      private function __avatarChangeHandler(param1:PlayerEvent) : void
      {
         showAvatar(_data);
      }
      
      public function __updateSpaceArmyPetHandler(param1:PlayerEvent) : void
      {
      }
      
      private function get state() : int
      {
         if(isSelf)
         {
            return ArmyManager.instance.army.state;
         }
         return _data.state;
      }
      
      public function __updateSpaceArmyStateHandler(param1:ArmyEvent) : void
      {
         if(!ArmyState.checkCampaignAttack(state))
         {
            setFireView();
            return;
         }
         clearFireView();
      }
      
      protected function setFireView() : void
      {
         if(!FreedomTeamManager.instance.inMyTeam(_data.userId))
         {
            return;
         }
         if(!_attackView)
         {
            _attackView = new SimpleAvatarView(110,110,PathManager.fightStatePath,10);
         }
         _attackView.drawFrame = 2;
         addChild(_attackView);
         _attackView.x = -55;
         _attackView.y = _showNamePosY - 90;
         _npcName && addChild(_npcName);
         _consortiaTxt && addChild(_consortiaTxt);
         showHoner();
         _vipIcon && addChild(_vipIcon);
         _vipText && addChild(_vipText);
         _chatPopView && addChild(_chatPopView);
      }
      
      protected function clearFireView() : void
      {
         ObjectUtils.disposeObject(_attackView);
         _attackView = null;
      }
      
      private function get selfUserId() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.userId;
      }
      
      private function __chatHandler(param1:PhysicsEvent) : void
      {
         if(_data.chatData == null)
         {
            if(_chatPopView)
            {
               _chatPopView.dispose();
            }
            _chatPopView = null;
         }
         if(_chatPopView)
         {
            _chatPopView.dispose();
            _chatPopView = null;
         }
         if(!_chatPopView)
         {
            _chatPopView = ChatFactory.createChatPopByType(_data.chatData,chatBack);
            _chatPopView.x = -90;
            if(_npcName)
            {
               _chatPopView.y = _npcName.y + 20 - _chatPopView.displayHeight;
            }
            else
            {
               _chatPopView.y = -100 - _chatPopView.displayHeight;
            }
            if(_isPlaying)
            {
               addChild(_chatPopView);
               if(_npcName)
               {
                  addChild(_npcName);
               }
               if(_vipIcon)
               {
                  addChild(_vipIcon);
               }
               if(_vipText)
               {
                  addChild(_vipText);
               }
            }
         }
      }
      
      private function chatBack() : void
      {
         _chatPopView = null;
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         if(_isPlaying == param1)
         {
            return;
         }
         _isPlaying = param1;
         if(param1)
         {
            if(_consortiaTxt)
            {
               addChild(_consortiaTxt);
            }
            showHoner();
            if(_chatPopView)
            {
               addChild(_chatPopView);
            }
            __updateSpaceArmyStateHandler(null);
         }
         else
         {
            if(_consortiaTxt && _consortiaTxt.parent)
            {
               _consortiaTxt.parent.removeChild(_consortiaTxt);
            }
            hideHoner();
            if(_chatPopView && _chatPopView.parent)
            {
               _chatPopView.parent.removeChild(_chatPopView);
            }
            clearFireView();
         }
      }
      
      public function get data() : SpaceArmy
      {
         return _data;
      }
      
      public function __petLevelUpHandler(param1:PetEvent) : void
      {
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.map.PetLevelUpMc");
         simpleMovie = new SimpleMovie(_loc2_,null,1,1,frameFun);
         simpleMovie.x = -12;
         simpleMovie.y = -45;
         frameFun();
         addChild(simpleMovie);
      }
      
      private function frameFun() : void
      {
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         simpleMovie = null;
         if(isSelf)
         {
            _data.curPosX = int(this.x / 20);
            _data.curPosY = int(this.y / 20);
         }
         _data = null;
         _honerView = null;
         clearFireView();
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         ObjectUtils.disposeObject(_chatPopView);
         _chatPopView = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_attackView);
         _attackView = null;
         super.dispose();
      }
   }
}

