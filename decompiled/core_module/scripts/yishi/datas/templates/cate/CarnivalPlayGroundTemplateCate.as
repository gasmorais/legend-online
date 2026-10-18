package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CarnivalPlayGroundTemplateInfo;
   
   public class CarnivalPlayGroundTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _isInit:Boolean;
      
      public function CarnivalPlayGroundTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         _isInit = true;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = "" + _loc1_.@Id;
               _dic[_loc2_] = createNode(_loc1_,CarnivalPlayGroundTemplateInfo,_tempXml) as CarnivalPlayGroundTemplateInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfo(param1:int) : CarnivalPlayGroundTemplateInfo
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc2_:String = "" + param1;
         return _dic[_loc2_];
      }
      
      public function getTempByType(param1:int) : CarnivalPlayGroundTemplateInfo
      {
         if(!_isInit)
         {
            initTemplates();
         }
         for each(var _loc2_:CarnivalPlayGroundTemplateInfo in _dic)
         {
            if(_loc2_.Type == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

