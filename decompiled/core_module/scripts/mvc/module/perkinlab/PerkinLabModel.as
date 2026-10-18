package mvc.module.perkinlab
{
   import flash.utils.Dictionary;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.TempleteManager;
   
   public class PerkinLabModel
   {
      
      public static const EVENT_PAGE_NUM:int = 11;
      
      private var _robCount:int;
      
      public var refreshCost:int;
      
      public var isLoadedData:Boolean;
      
      public var nextRefreshTime:Number;
      
      public var robCdTime:Number;
      
      public var curExp:int;
      
      public var selfKengList:Array;
      
      public var robKengList:Array;
      
      public var logList:Array;
      
      public var currentOpIndex:int = -1;
      
      private var _taskValue:int = 0;
      
      public var victoryCount:int;
      
      public var kengPosArr:Array = [[495,280],[400,28],[115,132]];
      
      public var upgradeArr:Array;
      
      public function PerkinLabModel()
      {
         super();
         selfKengList = [];
         robKengList = [];
         logList = [];
      }
      
      public function getKengInfoByIndexFromList(param1:int, param2:Array) : PerkinLabKengInfo
      {
         for each(var _loc3_:PerkinLabKengInfo in param2)
         {
            if(_loc3_.index == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getRewardStrByMissing(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc13_:Array = null;
         var _loc9_:int = 0;
         var _loc15_:Array = null;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            param1 = "";
         }
         var _loc7_:String = "";
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(curGrade,134);
         var _loc16_:String = _loc3_.TemplateName;
         var _loc11_:Array = _loc16_.split(";")[0].split("|");
         var _loc10_:Array = ConfigInfoManager.instance.getPerkinRipTime();
         var _loc8_:int = int(_loc10_[0]);
         var _loc12_:Dictionary = new Dictionary();
         var _loc18_:Dictionary = new Dictionary();
         var _loc5_:Dictionary = new Dictionary();
         var _loc14_:Array = param1.split("|");
         _loc6_ = 0;
         while(_loc6_ < _loc11_.length)
         {
            _loc13_ = _loc11_[_loc6_].split(",");
            if(_loc13_.length >= 2)
            {
               if(_loc12_[_loc13_[0]])
               {
                  var _loc19_:* = _loc13_[0];
                  var _loc20_:* = _loc12_[_loc19_] + int(_loc13_[1]) * _loc8_;
                  _loc12_[_loc19_] = _loc20_;
               }
               else
               {
                  _loc12_[_loc13_[0]] = int(_loc13_[1]) * _loc8_;
               }
            }
            _loc6_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc14_.length)
         {
            _loc15_ = _loc14_[_loc9_].split(",");
            if(_loc18_[_loc15_[0]])
            {
               _loc20_ = _loc15_[0];
               _loc19_ = _loc18_[_loc20_] + int(_loc15_[1]);
               _loc18_[_loc20_] = _loc19_;
            }
            else
            {
               _loc18_[_loc15_[0]] = int(_loc15_[1]);
            }
            _loc9_++;
         }
         for(var _loc17_:String in _loc12_)
         {
            _loc4_ = 0;
            if(_loc18_[_loc17_])
            {
               _loc4_ = int(_loc18_[_loc17_]);
            }
            _loc5_[_loc17_] = int(_loc12_[_loc17_]) - _loc4_;
         }
         for(var _loc2_:String in _loc5_)
         {
            _loc7_ += _loc2_ + "," + _loc5_[_loc2_] + "|";
         }
         return _loc7_.substring(0,_loc7_.lastIndexOf("|"));
      }
      
      public function get robCount() : int
      {
         return _robCount;
      }
      
      public function set robCount(param1:int) : void
      {
         if(_robCount == param1)
         {
            return;
         }
         _robCount = param1;
         var _loc2_:int = ConfigInfoManager.instance.getPerkibnRobMaxCount() - param1;
         InfoTipsManager.instance.updateValue(29,_loc2_);
      }
      
      public function get curGrade() : int
      {
         return TempleteManager.instance.getGradeByAdd(134,curExp)[1];
      }
      
      public function get taskValue() : int
      {
         return _taskValue;
      }
      
      public function set taskValue(param1:int) : void
      {
         _taskValue = param1;
      }
   }
}

