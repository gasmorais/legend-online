package avatar.view
{
   import avatar.load.ShowAvatarLoader;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mvc.module.fashion.FashionModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.utils.StringHelper;
   
   public class ShowAvatar extends Sprite implements Disposeable
   {
      
      private var _frontHair:ShowAvatarLoader;
      
      private var _frontCloak:ShowAvatarLoader;
      
      private var _body:ShowAvatarLoader;
      
      private var _arms:ShowAvatarLoader;
      
      private var _backCloak:ShowAvatarLoader;
      
      private var _backHair:ShowAvatarLoader;
      
      private var _wing:ShowAvatarLoader;
      
      private var _pet:ShowPetAvatar;
      
      private var _defaultDic:Dictionary;
      
      private var _frontHairPath:String;
      
      private var _frontCloakPath:String;
      
      private var _bodyPath:String;
      
      private var _armysPath:String;
      
      private var _backHairPath:String;
      
      private var _backCloakPath:String;
      
      private var _wingPath:String;
      
      private var _petPath:String;
      
      private var _data:ThaneInfo;
      
      private var _bodyLoadComplete:Function;
      
      private var _showPet:Boolean;
      
      private var _isShowFashionAboutDrag:Boolean = false;
      
      private var _showDrag:Boolean;
      
      private var count:int = 0;
      
      public function ShowAvatar(param1:Boolean = false, param2:Function = null, param3:Boolean = false, param4:Boolean = false)
      {
         super();
         _bodyLoadComplete = param2;
         _showPet = param3;
         init(param1);
         this.mouseChildren = false;
         this.mouseEnabled = false;
         _showDrag = param4;
      }
      
      public function get petAvatar() : ShowPetAvatar
      {
         return _pet;
      }
      
      private function init(param1:Boolean) : void
      {
         _frontHair = new ShowAvatarLoader(loadComplete);
         _frontCloak = new ShowAvatarLoader(loadComplete);
         _body = new ShowAvatarLoader(bodyloadComplete);
         _arms = new ShowWeaponAvatar(loadComplete);
         _backCloak = new ShowAvatarLoader(loadComplete);
         _backHair = new ShowAvatarLoader(loadComplete);
         _wing = new ShowAvatarLoader(loadComplete);
         if(_showPet)
         {
            _pet = new ShowPetAvatar(_bodyLoadComplete);
            _pet.y = 50;
         }
         _defaultDic = new Dictionary();
         _defaultDic[2] = "equip_show/hunter_default";
         _defaultDic[3] = "equip_show/wizard_default";
         _defaultDic[1] = "equip_show/warrior_default";
         _defaultDic[4] = "equip_show/dragonic/dragonman_default";
      }
      
      private function get templateInfo() : GameHeroTempInfo
      {
         var _loc1_:GameHeroTempInfo = _data.templateInfo;
         if(!_loc1_)
         {
            _loc1_ = new GameHeroTempInfo();
         }
         return _loc1_;
      }
      
      private function getDefaultPathByString(param1:String) : String
      {
         if(_showDrag || _isShowFashionAboutDrag || model.lookDragonTalkerFashion)
         {
            return PathManager.resourcePath + _defaultDic[4] + param1 + templateInfo.Sexs + ".swf";
         }
         return PathManager.resourcePath + _defaultDic[templateInfo.Job] + param1 + templateInfo.Sexs + ".swf";
      }
      
      private function getPathByStr(param1:String) : String
      {
         return PathManager.resourcePath + "equip_show" + param1 + templateInfo.Sexs + ".swf";
      }
      
      private function getWingPath(param1:String) : String
      {
         if(_showDrag || _isShowFashionAboutDrag || model.lookDragonTalkerFashion)
         {
            return PathManager.resourcePath + "equip_show" + param1 + "4_" + templateInfo.Sexs + ".swf";
         }
         return PathManager.resourcePath + "equip_show" + param1 + templateInfo.Job + "_" + templateInfo.Sexs + ".swf";
      }
      
      private function initDefaultPath() : void
      {
         if(!_data)
         {
            return;
         }
         _frontCloakPath = "";
         _backCloakPath = "";
         _frontHairPath = getDefaultPathByString("_hair/front/");
         _frontCloakPath = getDefaultPathByString("_body_cloak/front/");
         _bodyPath = getDefaultPathByString("_body/");
         _armysPath = getDefaultPathByString("_arms/");
         _backHairPath = getDefaultPathByString("_hair/back/");
         _backCloakPath = getDefaultPathByString("_body_cloak/back/");
         _wingPath = "";
         _petPath = "";
         if(_showDrag || _isShowFashionAboutDrag || templateInfo.Job == 2 || model.lookDragonTalkerFashion)
         {
            addChild(_backHair);
            addChild(_wing);
            addChild(_backCloak);
            addChild(_body);
            addChild(_arms);
            addChild(_frontCloak);
            addChild(_frontHair);
            if(_showPet && _pet)
            {
               addChild(_pet);
            }
         }
         else
         {
            addChild(_backHair);
            addChild(_wing);
            addChild(_backCloak);
            addChild(_arms);
            addChild(_body);
            addChild(_frontCloak);
            addChild(_frontHair);
            if(_showPet && _pet)
            {
               addChild(_pet);
            }
         }
      }
      
      private function initPath() : void
      {
         if(!_data)
         {
            return;
         }
         _frontCloakPath = StringHelper.isNullOrEmpty(_data.bodyAvata) ? _frontCloakPath : getPathByStr(_data.bodyAvata + "_cloak/front/");
         _backCloakPath = StringHelper.isNullOrEmpty(_data.bodyAvata) ? _backCloakPath : getPathByStr(_data.bodyAvata + "_cloak/back/");
         _wingPath = StringHelper.isNullOrEmpty(_data.wingAvata) ? _wingPath : getWingPath(_data.wingAvata + "/");
         if(!_data.hideFashion && _data.hairFashionAvata != "" && _data.hairFashionAvata != null)
         {
            _frontHairPath = StringHelper.isNullOrEmpty(_data.hairAvata) ? _frontHairPath : getWingPath(_data.hairAvata + "/front/");
         }
         else
         {
            _frontHairPath = StringHelper.isNullOrEmpty(_data.hairEquipAvata) ? _frontHairPath : getPathByStr(_data.hairEquipAvata + "/front/");
         }
         if(!_data.hideFashion && _data.bodyFashionAvata != "" && _data.bodyFashionAvata != null)
         {
            _bodyPath = StringHelper.isNullOrEmpty(_data.bodyAvata) ? _bodyPath : getWingPath(_data.bodyAvata + "/");
         }
         else
         {
            _bodyPath = StringHelper.isNullOrEmpty(_data.bodyEquipAvata) ? _bodyPath : getPathByStr(_data.bodyEquipAvata + "/");
         }
         if(!_data.hideFashion && _data.armsFashionAvata != "" && _data.armsFashionAvata != null)
         {
            _armysPath = StringHelper.isNullOrEmpty(_data.armsAvata) ? _armysPath : getWingPath(_data.armsAvata + "/");
         }
         else
         {
            _armysPath = StringHelper.isNullOrEmpty(_data.armsEquipAvata) ? _armysPath : getPathByStr(_data.armsEquipAvata + "/");
         }
         if(!_data.hideFashion && _data.hairFashionAvata != "" && _data.hairFashionAvata != null)
         {
            _backHairPath = StringHelper.isNullOrEmpty(_data.hairAvata) ? _backHairPath : getWingPath(_data.hairAvata + "/back/");
         }
         else
         {
            _backHairPath = StringHelper.isNullOrEmpty(_data.hairEquipAvata) ? _backHairPath : getPathByStr(_data.hairEquipAvata + "/back/");
         }
         if(_data.petTemplate)
         {
            _petPath = PathManager.solveHeroAvatarPath(_data.petTemplate.PetAvatar + "_follow",2);
         }
         else
         {
            _petPath = "";
         }
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      private function isShowDragon() : void
      {
         _isShowFashionAboutDrag = false;
         if(!_data)
         {
            return;
         }
         if(_data.bodyEquipAvata && _data.bodyEquipAvata.indexOf(PathManager.DRAGONIC) != -1 || _data.armsEquipAvata && _data.armsEquipAvata.indexOf(PathManager.DRAGONIC) != -1 || _data.bodyFashionAvata && _data.bodyFashionAvata.indexOf(PathManager.DRAGONIC) != -1 || _data.armsFashionAvata && _data.armsFashionAvata.indexOf(PathManager.DRAGONIC) != -1 || _data.hairFashionAvata && _data.hairFashionAvata.indexOf(PathManager.DRAGONIC) != -1 || _data.wingAvata && _data.wingAvata.indexOf(PathManager.DRAGONIC) != -1)
         {
            _isShowFashionAboutDrag = true;
         }
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         if(!_data)
         {
            _arms.first = true;
         }
         else
         {
            _arms.first = false;
         }
         _data = param1;
         isShowDragon();
         initDefaultPath();
         initPath();
         if(_data)
         {
            if(_frontHair.url != _frontHairPath)
            {
               _frontHair.initPath(_frontHairPath);
            }
            if(_body.url != _bodyPath)
            {
               _body.initPath(_bodyPath);
            }
            if(_arms.url != _armysPath)
            {
               _arms.initPath(_armysPath);
            }
            if(_backHair.url != _backHairPath)
            {
               _backHair.initPath(_backHairPath);
            }
            if(_data.wingAvata)
            {
               _wing.initPath(_wingPath);
               _frontCloak.initPath("");
               _backCloak.initPath("");
            }
            else
            {
               if(_frontCloak.url != _frontCloakPath)
               {
                  _frontCloak.initPath(_frontCloakPath);
               }
               if(_backCloak.url != _backCloakPath)
               {
                  _backCloak.initPath(_backCloakPath);
               }
               _wing.initPath("");
            }
            if(_showPet && _pet)
            {
               _pet.petTemplate = param1.petTemplate;
               if(_pet.url != _petPath)
               {
                  _pet.initPath(_petPath);
               }
            }
         }
         else
         {
            if(_frontHair.url != "")
            {
               _frontHair.initPath("");
            }
            if(_frontCloak.url != "")
            {
               _frontCloak.initPath("");
            }
            if(_body.url != "")
            {
               _body.initPath("");
            }
            if(_arms.url != "")
            {
               _arms.initPath("");
            }
            if(_backCloak.url != "")
            {
               _backCloak.initPath("");
            }
            if(_backHair.url != "")
            {
               _backHair.initPath("");
            }
            if(_wing.url != "")
            {
               _wing.initPath("");
            }
            if(_showPet && _pet)
            {
               _pet.petTemplate = null;
               if(_pet.url != "")
               {
                  _pet.initPath("");
               }
            }
         }
      }
      
      private function loadComplete() : void
      {
         _backHair.gotoAndPlay(1);
         _backCloak.gotoAndPlay(1);
         _arms.gotoAndPlay(1);
         _body.gotoAndPlay(1);
         _frontCloak.gotoAndPlay(1);
         _frontHair.gotoAndPlay(1);
         _wing.gotoAndPlay(1);
         if(_showPet && _pet)
         {
            _pet.gotoAndPlay(1);
         }
      }
      
      private function bodyloadComplete() : void
      {
         if(_bodyLoadComplete != null)
         {
            _bodyLoadComplete();
         }
         loadComplete();
      }
      
      public function get body() : ShowAvatarLoader
      {
         return _body;
      }
      
      private function get model() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_frontHair);
         _frontHair = null;
         ObjectUtils.disposeObject(_frontCloak);
         _frontCloak = null;
         ObjectUtils.disposeObject(_body);
         _body = null;
         ObjectUtils.disposeObject(_arms);
         _arms = null;
         ObjectUtils.disposeObject(_backCloak);
         _backCloak = null;
         ObjectUtils.disposeObject(_backHair);
         _backHair = null;
         ObjectUtils.disposeObject(_wing);
         _wing = null;
         ObjectUtils.disposeObject(_pet);
         _pet = null;
         _bodyLoadComplete = null;
      }
   }
}

