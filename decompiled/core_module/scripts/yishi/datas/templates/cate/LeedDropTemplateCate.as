package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.LeedDropTemplate;
   
   public class LeedDropTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function LeedDropTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByIndexAndIsWeek(param1:int, param2:Boolean) : Array
      {
         var _loc4_:* = null;
         var _loc5_:int = param2 ? 1 : 0;
         if(_dic[param1 + "_" + _loc5_])
         {
            return _dic[param1 + "_" + _loc5_];
         }
         if(_list)
         {
            _loc4_ = _list.(@site == param1 && @isWeek == _loc5_);
            for each(var _loc3_:XML in _loc4_)
            {
               if(!_dic[param1 + "_" + _loc5_])
               {
                  _dic[param1 + "_" + _loc5_] = [];
               }
               _dic[param1 + "_" + _loc5_].push(createNode(_loc3_,LeedDropTemplate,_tempXml));
            }
         }
         return _dic[param1 + "_" + _loc5_];
      }
   }
}

