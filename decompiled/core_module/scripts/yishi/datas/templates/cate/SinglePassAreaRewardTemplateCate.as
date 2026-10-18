package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SinglePassAreaRewardData;
   
   public class SinglePassAreaRewardTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SinglePassAreaRewardTemplateCate(param1:XMLList)
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
                  _dic[_currentCount] = createNode(_loc1_,SinglePassAreaRewardData,_tempXml) as SinglePassAreaRewardData;
               }
            }
         }
      }
      
      public function getTemplates() : Dictionary
      {
         initDic();
         return _dic;
      }
      
      public function getAreaRewardByAreaId(param1:int) : Array
      {
         var _loc2_:* = null;
         initDic();
         var _loc3_:Array = [];
         for each(_loc2_ in _dic)
         {
            if(_loc2_.Area == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
   }
}

