package mvc.module.mounts
{
   import events.MountsEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class MountInfo extends EventDispatcher
   {
      
      private var _properties:Dictionary = new Dictionary();
      
      public var soulScore:int;
      
      public var discount:int;
      
      public var addPointCount:int;
      
      public var propertyGradeMax:int;
      
      private var _templateId:int;
      
      private var _upgradeTemplate:UpgradeTemplateInfo;
      
      private var _growExp:int;
      
      private var _isMaxGrade:Boolean = false;
      
      private var _growExpMax:int;
      
      private var _currentGrowExp:int;
      
      public function MountInfo()
      {
         super();
         addProperty("Strength");
         addProperty("Intellect");
         addProperty("Stamina");
         addProperty("Armor");
      }
      
      public function get speedAdd() : int
      {
         var _loc1_:int = 20 + Math.ceil(this.grade / 2) * 10;
         if(this.template && this.template.MountType == 1)
         {
            _loc1_ += this.template.Speed;
         }
         return _loc1_;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         _templateId = param1;
      }
      
      public function get upgradeTemplate() : UpgradeTemplateInfo
      {
         return _upgradeTemplate;
      }
      
      public function get growExp() : int
      {
         return _growExp;
      }
      
      public function set growExp(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _growExp = param1;
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(19);
         _loc2_.sortOn("Data",16);
         _loc4_ = 0;
         _loc3_ = int(_loc2_.length);
         while(_loc4_ < _loc3_)
         {
            if(growExp >= _loc2_[_loc4_].Data && (_loc4_ + 1 == _loc3_ || growExp < _loc2_[_loc4_ + 1].Data))
            {
               if(_upgradeTemplate && _upgradeTemplate.Grades < _loc2_[_loc4_].Grades)
               {
                  dispatchEvent(new MountsEvent("mountLevelup",_upgradeTemplate.Grades));
               }
               _upgradeTemplate = _loc2_[_loc4_];
               _currentGrowExp = growExp - _upgradeTemplate.Data;
               if(_loc3_ == 1)
               {
                  _growExpMax = _loc2_[0].Data;
               }
               else if(_loc4_ + 1 == _loc3_)
               {
                  _isMaxGrade = true;
                  _growExpMax = _loc2_[_loc4_].Data - _loc2_[_loc4_ - 1].Data;
                  _currentGrowExp = _growExpMax;
               }
               else
               {
                  _growExpMax = _loc2_[_loc4_ + 1].Data - _loc2_[_loc4_].Data;
               }
               _currentGrowExp = Math.min(_currentGrowExp,_growExpMax);
               break;
            }
            _loc4_++;
         }
      }
      
      public function get isMaxGrade() : Boolean
      {
         return _isMaxGrade;
      }
      
      public function get growExpMax() : int
      {
         return _growExpMax;
      }
      
      public function get currentGrowExp() : int
      {
         return _currentGrowExp;
      }
      
      public function get grade() : int
      {
         return upgradeTemplate != null ? upgradeTemplate.Grades : 1;
      }
      
      public function getProperty(param1:String) : PropertyInfo
      {
         return _properties[param1];
      }
      
      private function addProperty(param1:String) : void
      {
         var _loc2_:PropertyInfo = new PropertyInfo();
         _loc2_.name = param1;
         _loc2_.mountInfo = this;
         _properties[param1] = _loc2_;
      }
      
      public function get template() : MountTemplate
      {
         return TempleteManager.instance.mountTemplateDic[templateId];
      }
      
      public function dispatchChangeEvent() : void
      {
         this.dispatchEvent(new MountsEvent("mountInfoChange",this));
      }
      
      public function dispatchPropLevelupEvent(param1:* = null) : void
      {
         this.dispatchEvent(new MountsEvent("propLevelup",param1));
      }
   }
}

