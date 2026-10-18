package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.PlanesLayerTemplateInfo;
   
   public class PlanesLayerTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function PlanesLayerTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : PlanesLayerTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@LayerTempId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,PlanesLayerTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

