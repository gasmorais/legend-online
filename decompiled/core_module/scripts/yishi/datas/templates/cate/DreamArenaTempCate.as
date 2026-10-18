package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.DreamArenaTempInfo;
   
   public class DreamArenaTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function DreamArenaTempCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,DreamArenaTempInfo,_tempXml) as DreamArenaTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplates() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:DreamArenaTempInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getTemplateById(param1:int) : DreamArenaTempInfo
      {
         return _dic[param1 + ""];
      }
      
      public function getTemplateByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:DreamArenaTempInfo in _dic)
         {
            if(_loc3_.Type == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getTempInfoByTypeAndId(param1:int, param2:int) : DreamArenaTempInfo
      {
         for each(var _loc3_:DreamArenaTempInfo in _dic)
         {
            if(_loc3_.Type == param1 && _loc3_.TypeTemplateId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

