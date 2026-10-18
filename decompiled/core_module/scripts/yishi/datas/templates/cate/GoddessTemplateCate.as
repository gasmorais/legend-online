package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GoddessTempInfo;
   
   public class GoddessTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GoddessTemplateCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,GoddessTempInfo,_tempXml) as GoddessTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplates() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoddessTempInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getTemplateById(param1:int) : GoddessTempInfo
      {
         return _dic[param1 + ""];
      }
   }
}

