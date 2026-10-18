package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ProficiencyTempInfo;
   
   public class ProficiencyTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ProficiencyTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Grade;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,ProficiencyTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateByGrade(param1:int) : ProficiencyTempInfo
      {
         var _loc2_:XML = null;
         checkFirst();
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Grade == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,ProficiencyTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

