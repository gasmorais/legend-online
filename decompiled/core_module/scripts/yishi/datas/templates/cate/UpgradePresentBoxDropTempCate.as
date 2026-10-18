package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonBoxDropTempInfo;
   
   public class UpgradePresentBoxDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function UpgradePresentBoxDropTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateListByBoxId(param1:int) : Array
      {
         var _loc4_:Array = [];
         var _loc2_:Dictionary = getTemplates();
         for each(var _loc3_:CommonBoxDropTempInfo in _loc2_)
         {
            if(_loc3_.BoxTempId == param1)
            {
               _loc4_.push(_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,CommonBoxDropTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

