package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.Bag360Template;
   
   public class Bag360DropTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function Bag360DropTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByIndex(param1:int) : Array
      {
         var _loc3_:* = null;
         if(_list)
         {
            _loc3_ = _list.(@Order == param1);
            for each(var _loc2_:XML in _loc3_)
            {
               if(!_dic[param1])
               {
                  _dic[param1] = [];
               }
               _dic[param1].push(createNode(_loc2_,Bag360Template,_tempXml));
            }
         }
         return _dic[param1];
      }
   }
}

