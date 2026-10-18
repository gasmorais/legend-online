package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.AvengerBodyTempInfo;
   
   public class AvengerBodyTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function AvengerBodyTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByGrade(param1:int) : AvengerBodyTempInfo
      {
         var _loc3_:* = null;
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@BodyGrade == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,AvengerBodyTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[_loc1_.@BodyGrade])
               {
                  _dic[_loc1_.@BodyGrade] = createNode(_loc1_,AvengerBodyTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

