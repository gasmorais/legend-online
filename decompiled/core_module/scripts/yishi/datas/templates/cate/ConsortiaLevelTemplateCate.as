package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import mvc.module.consortia.ConsortiaTemplete;
   
   public class ConsortiaLevelTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ConsortiaLevelTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _tempXml = describeType(ConsortiaTemplete);
      }
      
      public function getTemplateByID(param1:int) : ConsortiaTemplete
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         checkFirst();
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _loc3_ = _loc2_.@Types + "_" + _loc2_.@Levels;
                  _dic[param1] = createNode(_loc2_,ConsortiaTemplete,_tempXml);
                  _dic[_loc3_] = _dic[param1];
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplateByTypeAndLevel(param1:int, param2:int) : ConsortiaTemplete
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         checkFirst();
         if(_list)
         {
            _loc3_ = _list.(@Types == param1 && @Levels == param2)[0];
            if(_loc3_)
            {
               _loc4_ = _loc3_.@TemplateId;
               if(!_dic[param1 + "_" + param2])
               {
                  _dic[param1 + "_" + param2] = createNode(_loc3_,ConsortiaTemplete,_tempXml);
                  _dic[_loc4_] = _dic[param1 + "_" + param2];
               }
            }
         }
         return _dic[param1 + "_" + param2];
      }
   }
}

