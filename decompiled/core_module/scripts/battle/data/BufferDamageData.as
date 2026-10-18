package battle.data
{
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class BufferDamageData
   {
      
      public static const GODDESS_ATTACK_TYPE:int = 310;
      
      public var id:int;
      
      private var _templateId:int;
      
      private var _attackWay:int;
      
      public var bufferUser:int;
      
      public var currentTurn:int;
      
      public var curMaxTurn:int;
      
      public var target:int;
      
      public var isIcon:Boolean;
      
      public var damageCount:int;
      
      public var AttackType:int;
      
      public var Icon:String;
      
      public var processType:int;
      
      public var effectiveType:int;
      
      public var layerCount:int;
      
      public var damages:Vector.<DamageData>;
      
      public var execFrameTime:int;
      
      public var unAblesSillIds:Array;
      
      private var _countWay:int;
      
      public var isPermanent:Boolean;
      
      public var targetSkillId:int;
      
      public function BufferDamageData()
      {
         super();
      }
      
      public function get countWay() : int
      {
         return _countWay;
      }
      
      public function set countWay(param1:int) : void
      {
         _countWay = param1;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function get attackWay() : int
      {
         return _attackWay;
      }
      
      public function getDamageByDannyCount(param1:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_:DamageData in damages)
         {
            if(_loc2_.damageCount == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function set templateId(param1:int) : void
      {
         _templateId = param1;
         var _loc2_:BufferTemplateInfo = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_templateId);
         if(_loc2_)
         {
            AttackType = _loc2_.AttackType;
            Icon = _loc2_.Icon;
            _countWay = _loc2_.CountWay;
            _attackWay = _loc2_.AttackWay;
         }
      }
   }
}

