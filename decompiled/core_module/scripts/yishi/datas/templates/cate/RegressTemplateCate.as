package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RegressTemplateInfo;
   
   public class RegressTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RegressTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : RegressTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list && !_dic[param1])
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,RegressTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplates() : Array
      {
         var _loc3_:Object = null;
         var _loc1_:Array = [];
         if(_list)
         {
            for each(var _loc2_:XML in _list)
            {
               if(!_dic[int(_loc2_.@TemplateId)])
               {
                  _loc3_ = createNode(_loc2_,RegressTemplateInfo,_tempXml);
                  _dic[int(_loc2_.@TemplateId)] = _loc3_;
               }
            }
         }
         for each(var _loc4_:RegressTemplateInfo in _dic)
         {
            _loc1_.push(_loc4_);
         }
         _loc1_.sortOn("TemplateId",16);
         return _loc1_;
      }
   }
}

