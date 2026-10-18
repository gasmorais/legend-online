package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class ChessPvpRankDropCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ChessPvpRankDropCate(param1:XMLList)
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
               _loc2_ = _loc1_.@id + "";
               _dic[_loc2_] = createNode(_loc1_,CommonDropTempInfo,_tempXml) as CommonDropTempInfo;
            }
         }
         _list = null;
      }
      
      public function getDropGoods(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:CommonDropTempInfo in _dic)
         {
            if(_loc3_.site == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("dropId");
         return _loc2_;
      }
   }
}

