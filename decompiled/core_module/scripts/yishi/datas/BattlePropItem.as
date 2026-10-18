package yishi.datas
{
   import battle.events.BattleEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class BattlePropItem extends EventDispatcher
   {
      
      public var userId:int;
      
      public var battleId:String;
      
      public var uItemId:int;
      
      private var _useCount:int;
      
      public var tempId:int;
      
      public var bagPos:int;
      
      public var skillTempId:int;
      
      public var sonType:int;
      
      public function BattlePropItem()
      {
         super();
      }
      
      public function get useCount() : int
      {
         return _useCount;
      }
      
      public function set useCount(param1:int) : void
      {
         _useCount = param1;
         dispatchEvent(new BattleEvent("PROP_USECOUNT_CHANGE",null));
      }
      
      public function getSkillTemplate() : SkillTempInfo
      {
         return TempleteManager.instance.getSkillTemplateInfoById(skillTempId);
      }
      
      public function getGoodsTemplated() : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(tempId);
      }
      
      public function clone() : BattlePropItem
      {
         var _loc1_:BattlePropItem = new BattlePropItem();
         _loc1_.userId = userId;
         _loc1_.battleId = battleId;
         _loc1_.uItemId = uItemId;
         _loc1_.useCount = useCount;
         _loc1_.tempId = tempId;
         _loc1_.bagPos = bagPos;
         _loc1_.skillTempId = skillTempId;
         _loc1_.sonType = sonType;
         return _loc1_;
      }
   }
}

