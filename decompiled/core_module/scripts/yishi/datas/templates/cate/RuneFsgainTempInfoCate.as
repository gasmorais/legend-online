package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RuneFsgainTempInfo;
   
   public class RuneFsgainTempInfoCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RuneFsgainTempInfoCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,RuneFsgainTempInfo,_tempXml) as RuneFsgainTempInfo;
            }
         }
         _list = null;
      }
      
      public function getInfoById(param1:int) : RuneFsgainTempInfo
      {
         var _loc2_:String = "" + param1;
         return _dic[_loc2_];
      }
   }
}

