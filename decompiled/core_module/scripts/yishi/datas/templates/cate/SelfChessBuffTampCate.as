package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SelfChessBuffTempInfo;
   
   public class SelfChessBuffTampCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SelfChessBuffTampCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc4_:SelfChessBuffTempInfo = null;
         var _loc1_:Array = null;
         var _loc3_:String = null;
         if(_list)
         {
            for each(var _loc2_:XML in _list)
            {
               _loc4_ = createNode(_loc2_,SelfChessBuffTempInfo,_tempXml) as SelfChessBuffTempInfo;
               _loc3_ = _loc2_.@Job;
               _loc1_ = _dic[_loc3_];
               if(_loc1_ == null)
               {
                  _loc1_ = [];
                  _dic[_loc3_] = _loc1_;
               }
               _loc1_.push(_loc4_);
            }
         }
         _list = null;
      }
      
      public function getTempInfo(param1:String, param2:int) : SelfChessBuffTempInfo
      {
         var _loc6_:SelfChessBuffTempInfo = null;
         var _loc5_:int = 0;
         var _loc3_:Array = _dic[param1];
         if(_loc3_ == null)
         {
            return null;
         }
         _loc3_.sortOn("Amount",0x10 | 2);
         var _loc4_:int = int(_loc3_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            if(_loc6_ != null && _loc6_.Amount <= param2)
            {
               return _loc6_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getTempJobList(param1:int) : Array
      {
         return _dic[param1];
      }
   }
}

