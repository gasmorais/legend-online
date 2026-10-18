package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ChildCampTempTempInfo;
   
   public class ChildCampTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ChildCampTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         intTemplates();
      }
      
      private function intTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Grade;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,ChildCampTempTempInfo,_tempXml);
               }
            }
         }
         _list = null;
         return _dic;
      }
      
      public function getTempByGrade(param1:int) : ChildCampTempTempInfo
      {
         return _dic[param1];
      }
   }
}

