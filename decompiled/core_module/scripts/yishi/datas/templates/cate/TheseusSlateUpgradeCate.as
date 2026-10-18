package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusSlateUpgradeInfo;
   
   public class TheseusSlateUpgradeCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusSlateUpgradeCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@EquipProfile + "_" + _loc1_.@EquipLv + "_" + _loc1_.@Type;
               _dic[_loc2_] = createNode(_loc1_,TheseusSlateUpgradeInfo,_tempXml) as TheseusSlateUpgradeInfo;
            }
         }
         _list = null;
      }
      
      public function getUpgradeTemplate(param1:int, param2:int, param3:int) : TheseusSlateUpgradeInfo
      {
         var _loc4_:String = param1 + "_" + param2 + "_" + param3;
         return _dic[_loc4_] as TheseusSlateUpgradeInfo;
      }
      
      public function getUpgradeTemplatesByTemplateId(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:TheseusSlateUpgradeInfo in _dic)
         {
            if(_loc3_.TemplateId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

