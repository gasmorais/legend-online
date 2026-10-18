package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SinglePassBossRewardData;
   
   public class SinglePassBossRewardTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SinglePassBossRewardTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      private function initDic() : void
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[_currentCount])
               {
                  _dic[_currentCount] = createNode(_loc1_,SinglePassBossRewardData,_tempXml) as SinglePassBossRewardData;
               }
            }
         }
      }
      
      public function getTemplates() : Dictionary
      {
         initDic();
         return _dic;
      }
      
      public function getBossRewardByTypeAndFloor(param1:int, param2:int) : Array
      {
         var _loc3_:* = null;
         initDic();
         var _loc4_:Array = [];
         for each(_loc3_ in _dic)
         {
            if(_loc3_.Type == param1 && _loc3_.Floor == param2)
            {
               _loc4_.push(_loc3_);
            }
         }
         return _loc4_;
      }
   }
}

