package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.DistrictRewardTemplate;
   
   public class DistrictTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function DistrictTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByID(param1:int) : Array
      {
         var _loc3_:* = null;
         if(!_dic[param1] && _list)
         {
            _dic[param1] = [];
            _loc3_ = _list.(@District == param1);
            for each(var _loc2_:XML in _loc3_)
            {
               _dic[param1].push(createNode(_loc2_,DistrictRewardTemplate,_tempXml));
            }
            _loc3_ = null;
         }
         return _dic[param1];
      }
   }
}

