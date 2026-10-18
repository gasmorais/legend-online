package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusPvpIntegralTempInfo;
   
   public class TheseusPvpIntegralTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusPvpIntegralTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Id + "";
               _dic[_loc2_] = createNode(_loc1_,TheseusPvpIntegralTempInfo,_tempXml) as TheseusPvpIntegralTempInfo;
            }
         }
         _list = null;
      }
   }
}

