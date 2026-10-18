package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.OldPlayerReturnTaskTempInfo;
   
   public class OldPlayerReturnTaskTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function OldPlayerReturnTaskTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@TaskId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,OldPlayerReturnTaskTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTempInfoById(param1:int) : OldPlayerReturnTaskTempInfo
      {
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:OldPlayerReturnTaskTempInfo in _loc3_)
         {
            if(_loc2_.TaskId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

