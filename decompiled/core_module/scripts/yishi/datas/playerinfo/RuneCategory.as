package yishi.datas.playerinfo
{
   import mvc.module.armyII.RuneInfo;
   import mvc.module.armyII.StoneLotterInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class RuneCategory
   {
      
      private var _job:int;
      
      public var runeScript:String = "-1,-1";
      
      public var allRuneList:SimpleDictionary;
      
      public var studiedRuneList:SimpleDictionary;
      
      public var stoneLotterInfo:StoneLotterInfo;
      
      public function RuneCategory()
      {
         super();
         allRuneList = new SimpleDictionary();
         studiedRuneList = new SimpleDictionary();
         stoneLotterInfo = new StoneLotterInfo();
      }
      
      public function initAllRune(param1:int) : void
      {
         var _loc2_:RuneInfo = null;
         _job = param1;
         var _loc3_:SimpleDictionary = TempleteManager.instance.getMinRuneTemplateInfoByJob(_job);
         for each(var _loc4_:RuneTemplateInfo in _loc3_)
         {
            _loc2_ = existRune(_loc4_);
            if(!_loc2_)
            {
               _loc2_ = new RuneInfo();
               _loc2_.runeId = _loc4_.TemplateId;
               _loc2_.grade = 0;
            }
            allRuneList.add(_loc2_.templateInfo.RuneIndex,_loc2_);
         }
      }
      
      public function existRune(param1:RuneTemplateInfo) : RuneInfo
      {
         return studiedRuneList[param1.RuneType];
      }
      
      public function getInfoByIndex(param1:int) : RuneInfo
      {
         for each(var _loc2_:RuneInfo in allRuneList)
         {
            if(_loc2_.templateInfo.RuneIndex == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getRuneInfoByRuneType(param1:int) : RuneInfo
      {
         for each(var _loc2_:RuneInfo in allRuneList)
         {
            if(_loc2_.templateInfo && param1 == _loc2_.templateInfo.RuneType)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMaxGradeRuneInfo() : RuneInfo
      {
         var _loc2_:RuneInfo = null;
         var _loc1_:int = -1;
         for each(var _loc3_:RuneInfo in allRuneList)
         {
            if(_loc3_.grade > _loc1_)
            {
               _loc2_ = _loc3_;
               _loc1_ = _loc3_.grade;
            }
         }
         return _loc2_;
      }
      
      public function getCurrentStudyCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:RuneInfo in allRuneList)
         {
            if(_loc2_.grade >= 1)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function getStudiedRuneByRuneType(param1:int) : RuneInfo
      {
         return studiedRuneList[param1];
      }
      
      public function hasCarryed(param1:int) : Boolean
      {
         var _loc2_:RuneTemplateInfo = null;
         for each(var _loc3_:int in runeScript.split(","))
         {
            _loc2_ = TempleteManager.instance.getRuneTemplateByTid(_loc3_);
            if(_loc2_ && _loc2_.RuneType == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get runeScriptLength() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:int in runeScript.split(","))
         {
            if(_loc2_ > 0)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
   }
}

