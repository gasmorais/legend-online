package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.VipDropTemplate;
   
   public class VipDropTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function VipDropTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByGrade(param1:int) : Array
      {
         var _loc4_:* = null;
         var _loc3_:VipDropTemplate = null;
         if(!_dic[param1] && _list)
         {
            _dic[param1] = [];
            _loc4_ = _list.(@site == param1);
            for each(var _loc2_:XML in _loc4_)
            {
               if(_loc2_)
               {
                  _loc3_ = createNode(_loc2_,VipDropTemplate,_tempXml) as VipDropTemplate;
                  _dic[param1].push(_loc3_);
               }
            }
         }
         return _dic[param1] as Array;
      }
   }
}

