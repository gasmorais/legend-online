package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.QuestionTempInfo;
   
   public class QuestionTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function QuestionTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,QuestionTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTempArr() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:QuestionTempInfo in getTemplates())
         {
            _loc2_.push(_loc1_);
         }
         _loc2_.sortOn("Id",16);
         return _loc2_;
      }
   }
}

