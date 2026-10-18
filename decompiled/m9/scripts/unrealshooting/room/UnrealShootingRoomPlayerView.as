package unrealshooting.room
{
   import com.pickgliss.loader.ResourceDomain;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import map.campaign.data.UnrealShootingModel;
   import mvc.module.armyII.UserArmy;
   import unrealshooting.helper.VehicleResourceManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class UnrealShootingRoomPlayerView extends Sprite implements Disposeable, IEnterFrame
   {
      
      public static var STAND:String = "Stand";
      
      public static var WALK:String = "Walk";
      
      public static var ATTACK:String = "Attack";
      
      public static var JUMP:String = "Jump";
      
      private var _tank:MovieClip;
      
      private var _heroContainer:Sprite;
      
      private var _consortiaName:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _vipIcon:Bitmap;
      
      private var _vipText:GradientText;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _iconPosX:int;
      
      private var _iconPosY:int;
      
      private var _appellId:int = 0;
      
      private var _data:UserArmy;
      
      private var _templateId:int;
      
      private var _unrealShootingVehicleTempInfo:VehicleObjectTempInfo;
      
      private var _model:UnrealShootingModel = FrameControllerManager.instance.unrealShootingController.model;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _resDomain:ResourceDomain = VehicleResourceManager.instance.domain;
      
      public var isAttack:Boolean;
      
      public var isJump:Boolean;
      
      public var isStand:Boolean;
      
      private var frameY:int;
      
      private var mirror:int;
      
      private var labelType:String;
      
      private var lastLabelType:String;
      
      public function UnrealShootingRoomPlayerView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.PlayerNickNameTxt");
         _consortiaName = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.PlayerConsortiaNameTxt");
         _heroContainer = new Sprite();
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _vocationIcon.visible = false;
         _heroContainer.buttonMode = true;
         addChild(_heroContainer);
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
      }
      
      public function set data(param1:UserArmy) : void
      {
         clean();
         _data = param1;
         if(_data)
         {
            setServerName();
            setNickName();
         }
      }
      
      public function showBody() : void
      {
         var _loc1_:String = null;
         if(_templateId == _model.selectedTempalteId)
         {
            return;
         }
         _templateId = _model.selectedTempalteId;
         _unrealShootingVehicleTempInfo = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(_templateId);
         _loc1_ = PathManager.getVehicleAvatarShowPath(_unrealShootingVehicleTempInfo.Avatar);
         _resDomain.load(_loc1_,false,__onLoaded);
      }
      
      private function __onLoaded() : void
      {
         var _loc2_:String = _unrealShootingVehicleTempInfo.Avatar.substr(1);
         var _loc1_:String = "asset.avatar." + _loc2_;
         ObjectUtils.disposeViolentMc(_tank);
         _tank = null;
         _tank = _resDomain.createInstane(_loc1_) as MovieClip;
         if(_tank)
         {
            addChildAt(_tank,1);
         }
         showNameInfo();
      }
      
      private function showNameInfo() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _nickNameTxt.x = -_nickNameTxt.width / 2;
         _nickNameTxt.y = -240 - _nickNameTxt.height;
         _consortiaName.x = _nickNameTxt.x;
         _consortiaName.y = _nickNameTxt.y - _nickNameTxt.height;
         addChild(_nickNameTxt);
         addChild(_consortiaName);
         var _loc1_:Number = _nickNameTxt.width - _nickNameTxt.textWidth >> 1;
         _iconPosX = _nickNameTxt.x + _loc1_ - 5;
         _iconPosY = _nickNameTxt.y;
         refreshVocation();
         if(isVip)
         {
            setVipIcon();
            _loc2_ = _vipIcon.width + _nickNameTxt.textWidth + 10;
            _vipIcon.y = _nickNameTxt.y - (_vipIcon.height - _nickNameTxt.textHeight);
            _vipIcon.x = -_loc2_ >> 1;
            _nickNameTxt.x = _vipIcon.x + _vipIcon.width - _loc1_ - 1;
            _vipIcon.y = _nickNameTxt.y - 2;
            _vipText.x = _nickNameTxt.x;
            _vipText.y = _nickNameTxt.y;
            _vipText.text = _nickNameTxt.text;
            if(_vipIcon.visible)
            {
               _iconPosX = _vipIcon.x;
               _iconPosY = _vipIcon.y;
            }
         }
         if(_vocationIcon != null)
         {
            if(isVip)
            {
               _loc3_ = _vipIcon.x;
               _loc4_ = _vipIcon.y;
            }
            else
            {
               _loc3_ = _nickNameTxt.x + _nickNameTxt.width / 2 - _nickNameTxt.textWidth / 2;
               _loc4_ = int(_nickNameTxt.y);
            }
            if(!_vocationIcon.parent)
            {
               addChild(_vocationIcon);
            }
            _vocationIcon.x = _loc3_ - _vocationIcon.width;
            _vocationIcon.y = _loc4_ - 4;
            if(_vocationIcon.visible)
            {
               _iconPosX = _vocationIcon.x;
            }
         }
         if(_vipText)
         {
            _vipText.visible = false;
         }
         _nickNameTxt.visible = true;
      }
      
      public function playAttackAction() : void
      {
         if(!_tank)
         {
            return;
         }
         _tank.gotoAndPlay(ATTACK + (frameY + 1));
      }
      
      public function calcFrameY(param1:Number) : int
      {
         var _loc2_:int = 1;
         if(param1 >= 270 && param1 < 280)
         {
            _loc2_ = 4;
         }
         else if(param1 >= 260 && param1 < 270)
         {
            _loc2_ = 4;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            _loc2_ = 3;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            _loc2_ = 2;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            _loc2_ = 1;
         }
         else if(param1 >= 80 && param1 <= 90)
         {
            _loc2_ = 0;
         }
         else if(param1 > 90 && param1 < 100)
         {
            _loc2_ = 0;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            _loc2_ = 1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            _loc2_ = 2;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            _loc2_ = 3;
         }
         return _loc2_;
      }
      
      public function calcMirror(param1:Number) : int
      {
         var _loc2_:int = 1;
         if(param1 >= 270 && param1 < 280)
         {
            _loc2_ = 1;
         }
         else if(param1 >= 260 && param1 < 270)
         {
            _loc2_ = -1;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            _loc2_ = 1;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            _loc2_ = 1;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            _loc2_ = 1;
         }
         else if(param1 >= 80 && param1 <= 90)
         {
            _loc2_ = 1;
         }
         else if(param1 > 90 && param1 < 100)
         {
            _loc2_ = -1;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            _loc2_ = -1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            _loc2_ = -1;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            _loc2_ = -1;
         }
         return _loc2_;
      }
      
      public function updateDirection(param1:Number) : void
      {
         frameY = calcFrameY(param1);
         mirror = calcMirror(param1);
         if(_tank)
         {
            _tank.scaleX = mirror;
            playTankBody();
         }
      }
      
      private function playTankBody() : void
      {
         var _loc1_:String = null;
         if(!_tank)
         {
            return;
         }
         if(isJump)
         {
            labelType = JUMP;
            _loc1_ = JUMP + (frameY + 1);
         }
         else if(isAttack)
         {
            labelType = ATTACK;
            _loc1_ = ATTACK + (frameY + 1);
         }
         else if(isStand)
         {
            labelType = STAND;
            _loc1_ = STAND + (frameY + 1);
         }
         else
         {
            labelType = WALK;
            _loc1_ = WALK + (frameY + 1);
         }
         if(_loc1_ != _tank.currentLabel)
         {
            if(labelType == JUMP && labelType == lastLabelType)
            {
               return;
            }
            _tank.gotoAndPlay(_loc1_);
         }
         lastLabelType = labelType;
      }
      
      private function clean() : void
      {
         _nickNameTxt.text = "";
         _consortiaName.text = "";
         if(_vipIcon && _vipIcon.parent)
         {
            _vipIcon.parent.removeChild(_vipIcon);
         }
         if(_vipText && _vipText.parent)
         {
            _vipText.parent.removeChild(_vipText);
         }
         if(_vocationIcon && _vocationIcon.parent)
         {
            _vocationIcon.parent.removeChild(_vocationIcon);
         }
      }
      
      private function setNickName() : void
      {
         _nickNameTxt.setFrame(3);
         if(_vipText)
         {
            _vipText.visible = true;
         }
         _nickNameTxt.visible = false;
         _nickNameTxt.text = String(_data.baseHero.nickName);
      }
      
      private function setServerName() : void
      {
         _consortiaName.setFrame(3);
         _consortiaName.text = _playerInfo.serviceName ? "<" + _playerInfo.serviceName + ">" : "";
      }
      
      private function setVipIcon() : void
      {
         _vipIcon || (_vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon"));
         addChild(_vipIcon);
         _vipIcon.scaleX = _vipIcon.scaleY = 1.25;
         _vipText || (_vipText = ComponentFactory.Instance.creatComponentByStylename("room.anterRoom.nameGradientText"));
         addChild(_vipText);
      }
      
      private function clearVipName() : void
      {
         _vipIcon && _vipIcon.parent && _vipIcon.parent.removeChild(_vipIcon);
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         _vipText && _vipText.parent && _vipText.parent.removeChild(_vipText);
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
      }
      
      private function get isVip() : Boolean
      {
         return _data.baseHero.IsVipAndNoExpirt;
      }
      
      private function refreshVocation() : void
      {
         if(!_data || !_data.baseHero || !_vocationIcon)
         {
            return;
         }
         if(_data.baseHero.vocationGrades > 0)
         {
            _vocationIcon.setFrame(_data.baseHero.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      public function get data() : UserArmy
      {
         return _data;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_heroContainer)
         {
            _heroContainer.filters = null;
         }
         ObjectUtils.disposeAllChildren(_heroContainer);
         ObjectUtils.disposeObject(_heroContainer);
         _heroContainer = null;
         ObjectUtils.disposeObject(_consortiaName);
         _consortiaName = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipText);
         _vipText = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeViolentMc(_tank);
         _tank = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

