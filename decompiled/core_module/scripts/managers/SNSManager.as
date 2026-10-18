package managers
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.yishi.proto.simple.SNSInfoMsg;
   import com.road.yishi.proto.simple.SNSUpdatedMsg;
   import events.SNSEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import mvc.module.sns.BaseSnsInfo;
   import mvc.module.sns.SNSModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class SNSManager extends EventDispatcher
   {
      
      private static var _instance:SNSManager;
      
      private var _model:SNSModel;
      
      public function SNSManager(param1:IEventDispatcher = null)
      {
         super(param1);
         if(!_model)
         {
            _model = new SNSModel();
         }
         addEvent();
      }
      
      public static function get instance() : SNSManager
      {
         if(!_instance)
         {
            _instance = new SNSManager();
         }
         return _instance;
      }
      
      public function get model() : SNSModel
      {
         return _model;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4239,__updateSnsInfoHandler);
      }
      
      private function __updateSnsInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SNSUpdatedMsg = new SNSUpdatedMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SNSUpdatedMsg;
         if(_loc2_.result == 1)
         {
            if(_loc2_.snsInfo.hasUserId)
            {
               thane.snsInfo.userId = _loc2_.snsInfo.userId;
            }
            if(_loc2_.snsInfo.hasNickname)
            {
               thane.snsInfo.nickName = _loc2_.snsInfo.nickname;
            }
            if(_loc2_.snsInfo.hasHeadId)
            {
               thane.snsInfo.headId = _loc2_.snsInfo.headId;
            }
            if(_loc2_.snsInfo.hasSignDesc)
            {
               thane.snsInfo.sign = _loc2_.snsInfo.signDesc;
            }
            if(_loc2_.snsInfo.hasSex)
            {
               thane.snsInfo.sex = _loc2_.snsInfo.sex;
            }
            if(_loc2_.snsInfo.hasBirthdayType)
            {
               thane.snsInfo.birthdayType = _loc2_.snsInfo.birthdayType;
            }
            if(_loc2_.snsInfo.hasBirthYear)
            {
               thane.snsInfo.birthYear = _loc2_.snsInfo.birthYear;
            }
            if(_loc2_.snsInfo.hasBirthMonth)
            {
               thane.snsInfo.birthMonth = _loc2_.snsInfo.birthMonth;
            }
            if(_loc2_.snsInfo.hasBirthDay)
            {
               thane.snsInfo.birthDay = _loc2_.snsInfo.birthDay;
            }
            if(_loc2_.snsInfo.hasStarId)
            {
               thane.snsInfo.horoscope = _loc2_.snsInfo.starId;
            }
            if(_loc2_.snsInfo.hasBloodType)
            {
               thane.snsInfo.bloodType = _loc2_.snsInfo.bloodType;
            }
            if(_loc2_.snsInfo.hasCountry)
            {
               thane.snsInfo.country = _loc2_.snsInfo.country;
            }
            if(_loc2_.snsInfo.hasProvince)
            {
               thane.snsInfo.province = _loc2_.snsInfo.province;
            }
            if(_loc2_.snsInfo.hasCity)
            {
               thane.snsInfo.city = _loc2_.snsInfo.city;
            }
            dispatchEvent(new SNSEvent("SNSINFO_UPDATE"));
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("sns.SNSManager.command01");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function loadSnsTemplate() : void
      {
         if(model.hasSnsTemp)
         {
            return;
         }
         LoaderManagerII.instance.load(PathManager.snsTempPath,5,8,__loadSnsTempCompleteHandler);
      }
      
      private function __loadSnsTempCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc15_:Object = null;
         var _loc14_:Object = null;
         var _loc8_:* = undefined;
         var _loc16_:Object = null;
         var _loc17_:* = undefined;
         var _loc10_:Object = null;
         var _loc4_:XML = XML(param2);
         var _loc9_:XMLList = _loc4_.CountryXml.Country;
         var _loc11_:XMLList = _loc4_.ProvinceXml.Province;
         var _loc7_:XMLList = _loc4_.CityXml.City;
         var _loc6_:XMLList = _loc4_.StarXml.Star;
         for each(var _loc3_:XML in _loc9_)
         {
            _loc15_ = {};
            _loc15_["id"] = int(_loc3_.@Id);
            _loc15_["name"] = String(_loc3_.@CountryName);
            model.countryList.push(_loc15_);
         }
         for each(var _loc13_:XML in _loc11_)
         {
            _loc14_ = {};
            _loc14_["id"] = int(_loc13_.@Id);
            _loc14_["name"] = String(_loc13_.@ProvinceName);
            if(model.provinceList[int(_loc13_.@CountryId)])
            {
               model.provinceList[int(_loc13_.@CountryId)].push(_loc14_);
            }
            else
            {
               _loc8_ = new Vector.<Object>();
               _loc8_.push(_loc14_);
               model.provinceList[int(_loc13_.@CountryId)] = _loc8_;
            }
         }
         for each(var _loc5_:XML in _loc7_)
         {
            _loc16_ = {};
            _loc16_["id"] = int(_loc5_.@Id);
            _loc16_["name"] = String(_loc5_.@CityName);
            if(model.cityList[int(_loc5_.@ProvinceId)])
            {
               model.cityList[int(_loc5_.@ProvinceId)].push(_loc16_);
            }
            else
            {
               _loc17_ = new Vector.<Object>();
               _loc17_.push(_loc16_);
               model.cityList[int(_loc5_.@ProvinceId)] = _loc17_;
            }
         }
         for each(var _loc12_:XML in _loc6_)
         {
            _loc10_ = {};
            _loc10_["id"] = int(_loc12_.@Id);
            _loc10_["name"] = String(_loc12_.@StarName);
            model.horoscopeList.push(_loc10_);
         }
         model.hasSnsTemp = true;
         dispatchEvent(new SNSEvent("SNSTEMP_LOAD_COMPLETE"));
      }
      
      public function sendUpdateSnsInfo(param1:BaseSnsInfo) : void
      {
         var _loc3_:PackageOut = new PackageOut(15033);
         var _loc2_:SNSInfoMsg = new SNSInfoMsg();
         _loc2_.userId = param1.userId;
         _loc2_.nickname = param1.nickName;
         _loc2_.signDesc = FilterWordManager.filterWrod(param1.sign);
         _loc2_.sex = param1.sex;
         _loc2_.birthdayType = param1.birthdayType;
         _loc2_.birthYear = param1.birthYear;
         _loc2_.birthMonth = param1.birthMonth;
         _loc2_.birthDay = param1.birthDay;
         _loc2_.starId = param1.horoscope;
         _loc2_.bloodType = param1.bloodType;
         _loc2_.country = param1.country;
         _loc2_.province = param1.province;
         _loc2_.city = param1.city;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendResetSnsInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(15036);
         SocketSendManager.instance.send(_loc1_);
      }
      
      public function sendAutoSaveInfo(param1:BaseSnsInfo) : void
      {
         var _loc3_:PackageOut = new PackageOut(15033);
         var _loc2_:SNSInfoMsg = new SNSInfoMsg();
         _loc2_.signDesc = FilterWordManager.filterWrod(param1.sign);
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

