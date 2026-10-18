package mvc.module.dragonTitan
{
   import managers.DragonTitanManager;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class DragonTitanInjectInfo
   {
      
      public static const MAX_LEVEL:int = 10;
      
      public var titianId:int;
      
      public var attStr:String;
      
      private var _modelReinjectGrade:int;
      
      public var thisTitanInjectGrade:int;
      
      public var injectCount:int;
      
      public var chargeGrade:int;
      
      public var injectCircleCount:int;
      
      private var _tipObj:Object;
      
      private var _addAttValues:Array;
      
      private var _upgradeInfo:UpgradeTemplateInfo;
      
      private var _nextUpgradeInfo:UpgradeTemplateInfo;
      
      public var isActive:Boolean = false;
      
      public function DragonTitanInjectInfo()
      {
         super();
      }
      
      public function get nextUpgradeInfo() : UpgradeTemplateInfo
      {
         if(!_nextUpgradeInfo)
         {
            setUpdateInfo();
         }
         return _nextUpgradeInfo;
      }
      
      public function get upgradeInfo() : UpgradeTemplateInfo
      {
         if(!_upgradeInfo)
         {
            setUpdateInfo();
         }
         return _upgradeInfo;
      }
      
      public function get injectGrade() : int
      {
         if(this.isActive)
         {
            return _modelReinjectGrade;
         }
         return thisTitanInjectGrade;
      }
      
      public function update(param1:DragonTitanModel, param2:int) : void
      {
         this.titianId = param2;
         this._modelReinjectGrade = param1.injectGrade;
         this.injectCount = param1.injectCount;
         this.chargeGrade = param1.chargeGrade;
         this.injectCircleCount = param1.devourTitan.length * ConfigInfoManager.instance.getKeyToInt("titan_reinject_base_count");
         _upgradeInfo = null;
         _nextUpgradeInfo = null;
         _addAttValues = null;
         _tipObj = null;
      }
      
      private function setUpdateInfo() : void
      {
         var _loc2_:* = 0;
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = TempleteManager.instance.getTemplatesByType(isActive ? 123 : 122);
         _loc1_.sortOn("Grades",16);
         _loc4_ = 0;
         _loc3_ = int(_loc1_.length);
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc1_[_loc4_];
            if(_loc5_.Grades == this.injectGrade)
            {
               _upgradeInfo = _loc5_;
               _loc2_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         if(_upgradeInfo)
         {
            if(_loc2_ + 1 < _loc1_.length)
            {
               _nextUpgradeInfo = _loc1_[_loc2_ + 1];
            }
         }
         else if(this.injectGrade == 0)
         {
            _upgradeInfo = _nextUpgradeInfo = _loc1_[0];
         }
      }
      
      public function getAttValue() : Array
      {
         var _loc5_:DragonTitanTempInfo = null;
         var _loc2_:Array = null;
         var _loc1_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:Number = NaN;
         if(!_addAttValues)
         {
            if(this.upgradeInfo)
            {
               _loc5_ = titanTempInfo;
               if(this.injectGrade == 0)
               {
                  _addAttValues = [0,0,0,0,0];
               }
               else
               {
                  _addAttValues = [];
                  _loc2_ = this.upgradeInfo.TemplateName.split(",");
                  _loc1_ = ["Attack","MagicAttack","Defence","MagicDefence","Live"];
                  _loc4_ = 0;
                  while(_loc4_ < _loc1_.length)
                  {
                     _loc3_ = int(_loc2_[_loc4_]) / 100;
                     _addAttValues.push(int(_loc5_[_loc1_[_loc4_]]) * _loc3_);
                     _loc4_++;
                  }
               }
            }
         }
         return _addAttValues;
      }
      
      public function getTipObj() : Object
      {
         var _loc4_:DragonTitanTempInfo = null;
         var _loc2_:int = 0;
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         if(!_tipObj)
         {
            _loc4_ = titanTempInfo;
            _loc2_ = injectGrade;
            _loc2_ %= 5;
            _loc1_ = ["Attack","MagicAttack","Defence","MagicDefence","Live"];
            _loc3_ = int(_loc4_[_loc1_[_loc2_]]) * 0.5;
            _tipObj = {
               "grade":_loc2_,
               "value":_loc3_
            };
         }
         return _tipObj;
      }
      
      public function get isUpTop() : Boolean
      {
         return injectCount > injectCircleCount;
      }
      
      public function get titanTempInfo() : DragonTitanTempInfo
      {
         return TempleteManager.instance.titanTemplateCate.getTemplateById(titianId);
      }
      
      public function get skillTempInfo() : SkillTempInfo
      {
         return DragonTitanManager.instance.model.getSkillTempInfoByTitanId(titianId);
      }
   }
}

