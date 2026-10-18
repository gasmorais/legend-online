package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.PoseidonShopTempInfo;
   
   public class PoseidonShopCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function PoseidonShopCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc4_:Dictionary = null;
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc2_:Array = null;
         if(_list)
         {
            _loc4_ = new Dictionary();
            for each(var _loc1_:XML in _list)
            {
               _loc5_ = _loc1_.@Id + "";
               _loc4_[_loc5_] = createNode(_loc1_,PoseidonShopTempInfo,_tempXml) as PoseidonShopTempInfo;
            }
            for each(var _loc6_:PoseidonShopTempInfo in _loc4_)
            {
               _loc3_ = _loc6_.ShopType + "_" + _loc6_.ShopLevel;
               _loc2_ = _dic[_loc3_];
               if(_loc2_ == null)
               {
                  _loc2_ = [];
                  _dic[_loc3_] = _loc2_;
               }
               _loc2_.push(_loc6_);
            }
         }
         _list = null;
      }
      
      public function getList(param1:int, param2:int) : Array
      {
         var _loc3_:String = param1 + "_" + param2;
         return _dic[_loc3_];
      }
   }
}

