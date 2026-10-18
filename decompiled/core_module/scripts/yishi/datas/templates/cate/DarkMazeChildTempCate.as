package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.DarkMazeChildTemplateInfo;
   
   public class DarkMazeChildTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function DarkMazeChildTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : DarkMazeChildTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Id == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,DarkMazeChildTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,DarkMazeChildTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

