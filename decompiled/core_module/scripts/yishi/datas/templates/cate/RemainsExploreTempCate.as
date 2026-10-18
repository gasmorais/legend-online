package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RemainsExploreTempInfo;
   
   public class RemainsExploreTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RemainsExploreTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@CheckPointId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,RemainsExploreTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTempInfo(param1:int, param2:int) : RemainsExploreTempInfo
      {
         var _loc4_:Dictionary = getTemplates();
         for each(var _loc3_:RemainsExploreTempInfo in _loc4_)
         {
            if(_loc3_.ChapterId == param1 && _loc3_.Node == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

