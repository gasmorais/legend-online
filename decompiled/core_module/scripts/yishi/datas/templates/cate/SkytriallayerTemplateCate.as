package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SkytriallayerTemplateInfo;
   
   public class SkytriallayerTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SkytriallayerTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByLayerNum(param1:int) : SkytriallayerTemplateInfo
      {
         var _loc2_:XML = null;
         checkFirst();
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@LayerNum == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,SkytriallayerTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

