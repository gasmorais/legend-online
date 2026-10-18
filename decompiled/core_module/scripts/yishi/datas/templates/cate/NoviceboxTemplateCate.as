package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.BoxTemplateInfo;
   
   public class NoviceboxTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function NoviceboxTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByGrade(param1:int) : Array
      {
         var _loc2_:XML = null;
         if(_list)
         {
            _loc2_ = _list.(@Grade == param1)[0];
            if(_loc2_)
            {
               if(!_dic[param1])
               {
                  _dic[param1] = [];
               }
               _dic[param1].push(createNode(_loc2_,BoxTemplateInfo,_tempXml));
            }
         }
         return _dic[param1] as Array;
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         checkFirst();
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Grade;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = [];
               }
               _dic[_loc2_].push(createNode(_loc1_,BoxTemplateInfo,_tempXml));
            }
         }
         return _dic;
      }
   }
}

