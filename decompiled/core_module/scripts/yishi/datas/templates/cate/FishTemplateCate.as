package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import yishi.datas.templates.FishTemplateInfo;
   
   public class FishTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXML:XML;
      
      public function FishTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _tempXML = describeType(FishTemplateInfo);
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TemplateId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,FishTemplateInfo,_tempXML);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateById(param1:int) : FishTemplateInfo
      {
         var _loc2_:XML = null;
         if(!_dic[param1] && _list)
         {
            _loc2_ = _list.(@TemplateId == param1)[0];
            if(_loc2_)
            {
               _dic[param1] = createNode(_loc2_,FishTemplateInfo,_tempXML);
            }
         }
         return _dic[param1] as FishTemplateInfo;
      }
   }
}

