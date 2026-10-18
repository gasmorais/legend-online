package mvc.module.sns
{
   import manager.LanguageMgr;
   import managers.SNSManager;
   
   public class BaseSnsInfo
   {
      
      public var userId:int;
      
      public var nickName:String;
      
      public var sign:String;
      
      public var sex:int;
      
      public var birthdayType:int;
      
      public var birthYear:int;
      
      public var birthMonth:int;
      
      public var birthDay:int;
      
      public var horoscope:int;
      
      public var bloodType:int;
      
      public var country:int;
      
      public var province:int;
      
      public var city:int;
      
      private var _headId:int;
      
      public function BaseSnsInfo()
      {
         super();
      }
      
      public function get headId() : int
      {
         return _headId;
      }
      
      public function set headId(param1:int) : void
      {
         if(param1 > 0)
         {
            _headId = param1;
         }
      }
      
      private function get snsModel() : SNSModel
      {
         return SNSManager.instance.model;
      }
      
      public function get sexName() : String
      {
         return snsModel.sexList[sex] ? snsModel.sexList[sex]["name"] : LanguageMgr.GetTranslation("friends.findfriend.FindResultItem.unknown");
      }
      
      public function get horoscopeName() : String
      {
         return snsModel.getHoroscopeObj(horoscope) ? snsModel.getHoroscopeObj(horoscope)["name"] : LanguageMgr.GetTranslation("friends.findfriend.FindResultItem.unknown");
      }
      
      public function get bloodName() : String
      {
         return snsModel.bloodTypeList[bloodType] ? snsModel.bloodTypeList[bloodType]["name"] : LanguageMgr.GetTranslation("friends.findfriend.FindResultItem.unknown");
      }
      
      public function get countryName() : String
      {
         return snsModel.getCountryObj(country) ? snsModel.getCountryObj(country)["name"] : LanguageMgr.GetTranslation("friends.findfriend.FindResultItem.unknown");
      }
      
      public function get provinceName() : String
      {
         return snsModel.getProvinceObj(province) ? snsModel.getProvinceObj(province)["name"] : "";
      }
      
      public function get cityName() : String
      {
         return snsModel.getCityObj(city) ? snsModel.getCityObj(city)["name"] : "";
      }
      
      public function get isFillOut() : Boolean
      {
         if(sex > 0 && bloodType > 0 && birthYear > 0 && birthMonth > 0 && birthDay > 0 && horoscope > 0 && country > 0 && province > 0 && city > 0)
         {
            return true;
         }
         return false;
      }
      
      public function reset() : void
      {
         sex = 0;
         birthdayType = 0;
         birthYear = 0;
         birthMonth = 0;
         birthDay = 0;
         horoscope = 0;
         bloodType = 0;
         country = 0;
         province = 0;
         city = 0;
      }
   }
}

