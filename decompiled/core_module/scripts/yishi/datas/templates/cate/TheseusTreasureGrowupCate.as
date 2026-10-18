package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusTreasureGrowupInfo;
   import yishi.utils.SimpleDictionary;
   
   public class TheseusTreasureGrowupCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusTreasureGrowupCate(param1:XMLList)
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
               _loc2_ = _loc1_.@TemplateId + "";
               _dic[_loc2_] = createNode(_loc1_,TheseusTreasureGrowupInfo,_tempXml) as TheseusTreasureGrowupInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfoByIdLevel(param1:int, param2:int) : TheseusTreasureGrowupInfo
      {
         var _loc3_:TheseusTreasureGrowupInfo = null;
         for each(var _loc4_:TheseusTreasureGrowupInfo in _dic)
         {
            if(_loc4_.TreasureId == param1 && _loc4_.TreasureLevel == param2)
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getDicByIdLevel(param1:int, param2:int) : SimpleDictionary
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:SimpleDictionary = new SimpleDictionary();
         for each(var _loc6_:TheseusTreasureGrowupInfo in _dic)
         {
            if(_loc6_.TreasureId == param1 && _loc6_.TreasureLevel < param2)
            {
               if(_loc5_[_loc6_.StrengthenItem])
               {
                  _loc3_ = int(_loc5_[_loc6_.StrengthenItem]);
                  _loc5_.add(_loc6_.StrengthenItem,_loc3_ + _loc6_.StrengthenItemNum);
               }
               else
               {
                  _loc5_.add(_loc6_.StrengthenItem,_loc6_.StrengthenItemNum);
               }
            }
         }
         return _loc5_;
      }
   }
}

