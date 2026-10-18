package mvc.module.mounts
{
   import events.MountsEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class PropertyInfo extends EventDispatcher
   {
      
      public static const STRENGTH:String = "Strength";
      
      public static const INTELLECT:String = "Intellect";
      
      public static const STAMINA:String = "Stamina";
      
      public static const ARMOR:String = "Armor";
      
      public static const PROP_NAME_ARR:Array = ["Strength","Intellect","Armor","Stamina"];
      
      private var _name:String;
      
      private var _addition:int;
      
      private var _propGp:int = -1;
      
      private var _currentPropGp:int;
      
      private var _currentPropMaxGp:int;
      
      private var _gradeMax:int;
      
      private var _upgradeTemplate:UpgradeTemplateInfo;
      
      public var mountInfo:MountInfo;
      
      public function PropertyInfo()
      {
         super();
      }
      
      public static function getPropertyValue(param1:String) : int
      {
         switch(param1)
         {
            case "Strength":
               return 0;
            case "Armor":
               return 1;
            case "Intellect":
               return 2;
            case "Stamina":
               return 5;
            default:
               return -1;
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get addition() : int
      {
         return _addition;
      }
      
      public function set addition(param1:int) : void
      {
         _addition = param1;
      }
      
      public function get propGp() : int
      {
         return _propGp;
      }
      
      public function set propGp(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(_propGp > 0 && _propGp < param1)
         {
            mountInfo.dispatchEvent(new MountsEvent("propLevelup",this));
         }
         _propGp = param1;
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(18);
         _loc2_.sortOn("Data",16);
         _loc4_ = 0;
         _loc3_ = int(_loc2_.length);
         while(_loc4_ < _loc3_)
         {
            if(_propGp >= _loc2_[_loc4_].Data && (_loc4_ + 1 == _loc3_ || _propGp < _loc2_[_loc4_ + 1].Data))
            {
               _upgradeTemplate = _loc2_[_loc4_];
               _currentPropGp = _propGp - _upgradeTemplate.Data;
               if(_loc3_ == 1)
               {
                  _currentPropMaxGp = _loc2_[0].Data;
               }
               else if(_loc4_ + 1 == _loc3_)
               {
                  _currentPropMaxGp = _loc2_[_loc4_].Data - _loc2_[_loc4_ - 1].Data;
                  _currentPropGp = _currentPropMaxGp;
               }
               else
               {
                  _currentPropMaxGp = _loc2_[_loc4_ + 1].Data - _loc2_[_loc4_].Data;
                  _currentPropGp = Math.min(_currentPropGp,_currentPropMaxGp);
               }
               break;
            }
            _loc4_++;
         }
      }
      
      public function get currentPropMaxGp() : int
      {
         return _currentPropMaxGp;
      }
      
      public function get currentPropGp() : int
      {
         return _currentPropGp;
      }
      
      public function get grade() : int
      {
         var _loc1_:int = int(_upgradeTemplate == null ? 1 : _upgradeTemplate.Grades);
         return Math.min(_loc1_,this.gradeMax);
      }
      
      public function get upgradeTemplate() : UpgradeTemplateInfo
      {
         return _upgradeTemplate;
      }
      
      public function get gradeMax() : int
      {
         return mountInfo.propertyGradeMax;
      }
      
      public function get isLimit() : Boolean
      {
         return grade == gradeMax;
      }
   }
}

