package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.EclipticPalaceTempInfo;
   
   public class EclipticPalaceTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function EclipticPalaceTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByLayer(param1:int) : EclipticPalaceTempInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Layer == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,EclipticPalaceTempInfo,_tempXml);
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
               _loc2_ = _loc1_.@Layer;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,EclipticPalaceTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

