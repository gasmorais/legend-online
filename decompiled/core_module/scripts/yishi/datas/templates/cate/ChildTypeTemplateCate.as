package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ChildTypeTempInfo;
   
   public class ChildTypeTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ChildTypeTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByJobAndSoulWakeGrades(param1:int, param2:int) : ChildTypeTempInfo
      {
         var _loc4_:* = null;
         var _loc3_:XML = null;
         if(param1 == 0)
         {
            return null;
         }
         var _loc5_:String = param1 + "_" + param2;
         if(_list)
         {
            if(!_dic[_loc5_])
            {
               _loc3_ = _list.(@ChildType == param1 && @SoulWakeGrade == param2)[0];
               if(_loc3_)
               {
                  _dic[_loc5_] = createNode(_loc3_,ChildTypeTempInfo,_tempXml);
               }
            }
         }
         return _dic[_loc5_];
      }
   }
}

