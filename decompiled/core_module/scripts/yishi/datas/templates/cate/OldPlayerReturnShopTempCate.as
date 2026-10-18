package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.OldPlayerReturnShopTempInfo;
   
   public class OldPlayerReturnShopTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function OldPlayerReturnShopTempCate(param1:XMLList)
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
                  _dic[_loc2_] = createNode(_loc1_,OldPlayerReturnShopTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTempInfoArrByType(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc5_:Dictionary = getTemplates();
         for each(var _loc4_:OldPlayerReturnShopTempInfo in _loc5_)
         {
            if(_loc4_.PlayerType == param1 && _loc4_.JobType == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
   }
}

