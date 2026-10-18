package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.utils.SimpleDictionary;
   
   public class MonsterCookDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function MonsterCookDropTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByType(param1:int) : SimpleDictionary
      {
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:CommonDropTempInfo in getTemplates())
         {
            if(_loc2_.site == param1 && !_loc3_[_loc2_.itemId])
            {
               _loc3_.add(_loc2_.itemId,_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,CommonDropTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

