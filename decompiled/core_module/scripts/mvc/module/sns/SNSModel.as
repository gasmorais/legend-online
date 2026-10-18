package mvc.module.sns
{
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   
   public class SNSModel
   {
      
      public var hasSnsTemp:Boolean = false;
      
      public var countryList:Vector.<Object>;
      
      public var provinceList:Dictionary;
      
      public var cityList:Dictionary;
      
      public var horoscopeList:Vector.<Object>;
      
      public var sexList:Dictionary;
      
      public var bloodTypeList:Dictionary;
      
      public function SNSModel()
      {
         super();
         countryList = new Vector.<Object>();
         provinceList = new Dictionary();
         cityList = new Dictionary();
         horoscopeList = new Vector.<Object>();
         sexList = new Dictionary();
         var _loc1_:String = LanguageMgr.GetTranslation("sns.SNSModel.sex01");
         sexList[1] = {
            "id":"1",
            "name":_loc1_
         };
         _loc1_ = LanguageMgr.GetTranslation("sns.SNSModel.sex02");
         sexList[2] = {
            "id":"2",
            "name":_loc1_
         };
         bloodTypeList = new Dictionary();
         _loc1_ = LanguageMgr.GetTranslation("sns.SNSModel.blood01");
         bloodTypeList[1] = {
            "id":"1",
            "name":_loc1_
         };
         _loc1_ = LanguageMgr.GetTranslation("sns.SNSModel.blood02");
         bloodTypeList[2] = {
            "id":"2",
            "name":_loc1_
         };
         _loc1_ = LanguageMgr.GetTranslation("sns.SNSModel.blood03");
         bloodTypeList[3] = {
            "id":"3",
            "name":_loc1_
         };
         _loc1_ = LanguageMgr.GetTranslation("sns.SNSModel.blood04");
         bloodTypeList[4] = {
            "id":"4",
            "name":_loc1_
         };
         _loc1_ = LanguageMgr.GetTranslation("sns.SNSModel.blood05");
         bloodTypeList[5] = {
            "id":"5",
            "name":_loc1_
         };
      }
      
      public function getHoroscopeObj(param1:int) : Object
      {
         for each(var _loc2_:Object in horoscopeList)
         {
            if(_loc2_["id"] == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getCountryObj(param1:int) : Object
      {
         for each(var _loc2_:Object in countryList)
         {
            if(_loc2_["id"] == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getProvinceObj(param1:int) : Object
      {
         loop0:
         for each(var _loc3_:Vector.<Object> in provinceList)
         {
            var _loc5_:int = 0;
            var _loc4_:Vector.<Object> = _loc3_;
            do
            {
               for each(var _loc2_:Object in _loc4_)
               {
               }
               continue loop0;
            }
            while(_loc2_["id"] != param1);
            return _loc2_;
         }
         return null;
      }
      
      public function getCityObj(param1:int) : Object
      {
         loop0:
         for each(var _loc3_:Vector.<Object> in cityList)
         {
            var _loc5_:int = 0;
            var _loc4_:Vector.<Object> = _loc3_;
            do
            {
               for each(var _loc2_:Object in _loc4_)
               {
               }
               continue loop0;
            }
            while(_loc2_["id"] != param1);
            return _loc2_;
         }
         return null;
      }
   }
}

