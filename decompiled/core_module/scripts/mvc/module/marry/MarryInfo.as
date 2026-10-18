package mvc.module.marry
{
   import mvc.module.marry.feels.MarryHeartInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.DateFormatter;
   
   public class MarryInfo
   {
      
      public var userId:int = 0;
      
      public var nickName:String;
      
      public var state:int;
      
      public var templateId:int;
      
      private var _marriageTime:Number;
      
      public var speTemplateId:int;
      
      public var questCount:int;
      
      public var overTime:int;
      
      public var answerNum:int;
      
      private var _heartInfo:MarryHeartInfo;
      
      public var ringGrade1:int;
      
      public var logoutDays:int;
      
      public var isBackPlayerFirstMarried:Boolean;
      
      public function MarryInfo()
      {
         super();
      }
      
      public function get heartInfo() : MarryHeartInfo
      {
         if(_heartInfo == null)
         {
            _heartInfo = new MarryHeartInfo();
         }
         return _heartInfo;
      }
      
      public function set heartInfo(param1:MarryHeartInfo) : void
      {
         if(_heartInfo)
         {
            _heartInfo.dispose();
         }
         _heartInfo = param1;
      }
      
      public function get marriageTime() : String
      {
         return String(_marriageTime);
      }
      
      public function set marriageTime(param1:String) : void
      {
         var _loc2_:Date = DateFormatter.parse(param1,"YYYY-MM-DD hh:mm:ss");
         _marriageTime = Math.floor(_loc2_.getTime() / 1000);
      }
      
      public function getMarrSkillList() : Array
      {
         return null;
      }
      
      public function getActiveMarrSkill() : SkillTempInfo
      {
         var _loc1_:Array = getMarrSkillList();
         for each(var _loc2_:SkillTempInfo in _loc1_)
         {
            if(_loc2_.UseWay == 1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

