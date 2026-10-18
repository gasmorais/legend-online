package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TopToolBtnTempInfo;
   
   public class TopToolBtnTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TopToolBtnTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByBtnKey(param1:int) : TopToolBtnTempInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@BtnKey == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,TopToolBtnTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[String(_loc1_.@BtnKey)])
               {
                  _dic[String(_loc1_.@BtnKey)] = createNode(_loc1_,TopToolBtnTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

