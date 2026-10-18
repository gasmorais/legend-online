package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.HeroRoadTemplateInfo;
   
   public class HeroRoadTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function HeroRoadTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : HeroRoadTemplateInfo
      {
         var _loc2_:XML = null;
         var _loc3_:int = param1;
         if(_list)
         {
            if(!_dic[_loc3_])
            {
               _loc2_ = _list.(@TaskTempId == param1)[0];
               if(_loc2_)
               {
                  _dic[_loc3_] = createNode(_loc2_,HeroRoadTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[_loc3_];
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TaskTempId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,HeroRoadTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

