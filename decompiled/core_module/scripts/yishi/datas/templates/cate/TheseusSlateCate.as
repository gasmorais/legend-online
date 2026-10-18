package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusSlateInfo;
   
   public class TheseusSlateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusSlateCate(param1:XMLList)
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
               _loc2_ = _loc1_.@TemplateId + "";
               _dic[_loc2_] = createNode(_loc1_,TheseusSlateInfo,_tempXml) as TheseusSlateInfo;
            }
         }
         _list = null;
      }
      
      public function getSlateTemplate(param1:int) : TheseusSlateInfo
      {
         return _dic[param1 + ""] as TheseusSlateInfo;
      }
      
      public function getAllSlateTemplates() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:TheseusSlateInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getSlateTemplatesByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:TheseusSlateInfo in _dic)
         {
            if(_loc3_.SlateType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

