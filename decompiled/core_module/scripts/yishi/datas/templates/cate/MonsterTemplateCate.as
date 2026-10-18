package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MonsterTempInfo;
   
   public class MonsterTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function MonsterTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByTypeAndStar(param1:int, param2:int) : MonsterTempInfo
      {
         var _loc4_:* = null;
         var _loc3_:XML = null;
         if(param1 == 0 || param2 == 0)
         {
            return null;
         }
         var _loc5_:String = param1 + "_" + param2;
         if(_list)
         {
            if(!_dic[_loc5_])
            {
               _loc3_ = _list.(@Type == param1 && @Star == param2)[0];
               if(_loc3_)
               {
                  _dic[_loc5_] = createNode(_loc3_,MonsterTempInfo,_tempXml);
               }
            }
         }
         return _dic[_loc5_];
      }
      
      public function getTemplateByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:MonsterTempInfo in getTemplates())
         {
            if(_loc3_.Type == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("Star",16);
         return _loc2_;
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[_loc1_.@Type + "_" + _loc1_.@Star])
               {
                  _dic[_loc1_.@Type + "_" + _loc1_.@Star] = createNode(_loc1_,MonsterTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateById(param1:int) : MonsterTempInfo
      {
         for each(var _loc2_:MonsterTempInfo in getTemplates())
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

