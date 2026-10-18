package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MarryQualityData;
   
   public class MarryQualityTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function MarryQualityTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      private function initDic() : void
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[String(_loc1_.@TemplateId)])
               {
                  _dic[String(_loc1_.@TemplateId)] = createNode(_loc1_,MarryQualityData,_tempXml);
               }
            }
         }
      }
      
      public function getTemplates() : Dictionary
      {
         initDic();
         return _dic;
      }
      
      public function getTempById(param1:int) : MarryQualityData
      {
         initDic();
         for each(var _loc2_:MarryQualityData in _dic)
         {
            if(_loc2_.TemplateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

