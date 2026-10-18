package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.StelaTemplateInfo;
   
   public class StelaTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function StelaTemplateCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,StelaTemplateInfo,_tempXml) as StelaTemplateInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplateById(param1:int) : StelaTemplateInfo
      {
         return _dic[param1 + ""];
      }
      
      public function getMetrailTemps() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:StelaTemplateInfo in _dic)
         {
            if(_loc2_.MasterType == 2)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("TemplateId",16);
         return _loc1_;
      }
   }
}

