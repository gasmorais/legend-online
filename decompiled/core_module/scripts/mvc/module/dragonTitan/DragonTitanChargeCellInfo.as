package mvc.module.dragonTitan
{
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.UpgradeTemplateInfo;
   
   public class DragonTitanChargeCellInfo
   {
      
      public static const TITAN_REDUCE_TIP_TYPE:String = "titan_reduce_tip_type";
      
      public var index:int;
      
      public var attName:String;
      
      public var attId:int;
      
      private var _expValue:int;
      
      public var attValue:int;
      
      public var nowGradeExp:int;
      
      public var nextGradeExp:int;
      
      public var grade:int;
      
      public var type:int;
      
      public var isRedTxt:Boolean = false;
      
      public function DragonTitanChargeCellInfo(param1:int)
      {
         super();
         this.type = param1;
      }
      
      public function setExpValue(param1:int, param2:Array) : void
      {
         var _loc9_:UpgradeTemplateInfo = null;
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         _expValue = param1;
         var _loc4_:int = -1;
         _loc7_ = 0;
         _loc6_ = int(param2.length);
         while(_loc7_ < _loc6_)
         {
            _loc9_ = param2[_loc7_];
            if(_loc9_.Data > param1)
            {
               _loc3_ = _loc9_;
               _loc4_ = int(_loc7_ > 0 ? _loc7_ - 1 : _loc7_);
               break;
            }
            _loc7_++;
         }
         if(_loc3_)
         {
            _loc8_ = ConfigInfoManager.instance.getKeyToInt("titan_charge_grade_base_property");
            _loc5_ = param2[_loc4_];
            if(_loc4_ > 0)
            {
               grade = _loc5_.Grades;
               this.attValue = _loc8_ * grade;
            }
            else
            {
               grade = 0;
               this.attValue = 0;
            }
            this.nextGradeExp = _loc3_.Data - _loc5_.Data;
            this.nowGradeExp = param1 - _loc5_.Data;
         }
      }
      
      public function get progressTxt() : String
      {
         return nowGradeExp + "/" + nextGradeExp;
      }
      
      public function get progressValue() : Number
      {
         return nowGradeExp / nextGradeExp;
      }
   }
}

