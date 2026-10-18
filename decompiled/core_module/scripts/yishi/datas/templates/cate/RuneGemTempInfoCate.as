package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RuneGemTempInfo;
   
   public class RuneGemTempInfoCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RuneGemTempInfoCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Types + "_" + _loc1_.@RuneGemTypes + "_" + _loc1_.@Grades;
               _dic[_loc2_] = createNode(_loc1_,RuneGemTempInfo,_tempXml) as RuneGemTempInfo;
            }
         }
         _list = null;
      }
      
      public function getInfo(param1:int, param2:int, param3:int) : RuneGemTempInfo
      {
         var _loc4_:String = param1 + "_" + param2 + "_" + param3;
         return _dic[_loc4_];
      }
   }
}

