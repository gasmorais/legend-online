package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusRageTempInfo;
   
   public class TheseusRageTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusRageTempCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,TheseusRageTempInfo,_tempXml) as TheseusRageTempInfo;
            }
         }
         _list = null;
      }
      
      public function getOneTempInfo(param1:int, param2:int, param3:int = 1) : TheseusRageTempInfo
      {
         for each(var _loc4_:TheseusRageTempInfo in _dic)
         {
            if(_loc4_.Type == param1 && _loc4_.Level == param2 && _loc4_.MasterType == param3)
            {
               return _loc4_;
            }
         }
         return null;
      }
   }
}

