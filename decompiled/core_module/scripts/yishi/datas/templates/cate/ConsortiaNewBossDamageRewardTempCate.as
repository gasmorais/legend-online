package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ConsortiaNewBossDamageRewardTemplateInfo;
   
   public class ConsortiaNewBossDamageRewardTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ConsortiaNewBossDamageRewardTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByTypeAndRank(param1:int, param2:int) : Array
      {
         var _loc4_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:Array = [];
         for each(var _loc5_:ConsortiaNewBossDamageRewardTemplateInfo in getTemplates())
         {
            _loc4_ = _loc5_.para2.split(",");
            if(_loc4_ && _loc4_.length == 2)
            {
               _loc6_ = int(_loc4_[0]);
               _loc3_ = int(_loc4_[1]);
            }
            if(_loc5_.site == param1 && param2 >= _loc6_ && param2 <= _loc3_)
            {
               _loc7_.push(_loc5_);
            }
         }
         _loc7_.sortOn("id",16);
         return _loc7_;
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,ConsortiaNewBossDamageRewardTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

