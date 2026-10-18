package yishi.datas.templates.cate
{
   import com.pickgliss.utils.ArrayUtils;
   import flash.utils.Dictionary;
   import yishi.datas.templates.DragonTitanTempInfo;
   
   public class DragonTitanTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var skills:Array;
      
      private var _array:Array;
      
      public function DragonTitanTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function get dic() : Dictionary
      {
         return _dic;
      }
      
      public function getTitanList() : Array
      {
         var _loc2_:int = 0;
         if(!_array)
         {
            if(_list)
            {
               _array = [];
               for each(var _loc1_:XML in _list)
               {
                  _loc2_ = int(_loc1_.@TemplateId[0]);
                  if(!_dic[_loc2_])
                  {
                     _dic[_loc2_] = createNode(_loc1_,DragonTitanTempInfo,_tempXml);
                  }
                  _array.push(_dic[_loc2_]);
               }
            }
            else
            {
               _array = ArrayUtils.dictionaryToArray(_dic);
            }
         }
         return _array;
      }
      
      public function getTemplateById(param1:int) : DragonTitanTempInfo
      {
         var _loc3_:* = null;
         var _loc2_:XML = null;
         if(param1 <= 0)
         {
            return null;
         }
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,DragonTitanTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

