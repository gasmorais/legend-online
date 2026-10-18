package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.OldPlayerReturnPrivilegeTempInfo;
   import yishi.utils.SimpleDictionary;
   
   public class OldPlayerReturnPrivilegeTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function OldPlayerReturnPrivilegeTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
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
                  _dic[_loc2_] = createNode(_loc1_,OldPlayerReturnPrivilegeTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getArrByTypeLevel(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc5_:Dictionary = getTemplates();
         for each(var _loc4_:OldPlayerReturnPrivilegeTempInfo in _loc5_)
         {
            if(_loc4_.PlayerType == param1 && _loc4_.ContractLevel == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         _loc3_.sortOn("Id",16);
         return _loc3_;
      }
      
      public function getDicByTypePrivilege(param1:int, param2:int) : SimpleDictionary
      {
         var _loc4_:SimpleDictionary = new SimpleDictionary();
         var _loc5_:Dictionary = getTemplates();
         for each(var _loc3_:OldPlayerReturnPrivilegeTempInfo in _loc5_)
         {
            if(_loc3_.PlayerType == param1 && _loc3_.PrivilegeType == param2)
            {
               _loc4_.add(_loc3_.ContractLevel,_loc3_);
            }
         }
         return _loc4_;
      }
   }
}

