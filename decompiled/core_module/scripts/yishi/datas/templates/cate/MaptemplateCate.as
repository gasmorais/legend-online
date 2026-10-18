package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import map.internals.data.template.MapTemplate;
   
   public class MaptemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function MaptemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : MapTemplate
      {
         var _loc2_:XML = null;
         if(param1 > 100000)
         {
            param1 = 100;
         }
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Id == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,MapTemplate,_tempXml);
               }
            }
         }
         return _dic[param1] as MapTemplate;
      }
      
      public function checkEnterCampaign(param1:int) : void
      {
         var _loc3_:MapTemplate = null;
         var _loc2_:XML = null;
         checkFirst();
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Id == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,MapTemplate,_tempXml);
               }
            }
            _loc3_ = _dic[param1] as MapTemplate;
            if(_loc3_.state == 3)
            {
               _loc3_.state = 2;
            }
         }
         else
         {
            for each(_loc3_ in _dic)
            {
               if(_loc3_.Id == param1)
               {
                  if(_loc3_.state == 3)
                  {
                     _loc3_.state = 2;
                  }
                  break;
               }
            }
         }
      }
   }
}

