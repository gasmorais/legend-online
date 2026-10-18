package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusSlateTaskInfo;
   
   public class TheseusSlateTaskCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusSlateTaskCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,TheseusSlateTaskInfo,_tempXml) as TheseusSlateTaskInfo;
            }
         }
         _list = null;
      }
      
      public function getSlateTaskTemplate(param1:int) : TheseusSlateTaskInfo
      {
         return _dic[param1 + ""] as TheseusSlateTaskInfo;
      }
      
      public function getAllSlateTaskTemplates() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:TheseusSlateTaskInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getSlateTaskTemplatesByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:TheseusSlateTaskInfo in _dic)
         {
            if(_loc3_.TaskType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

