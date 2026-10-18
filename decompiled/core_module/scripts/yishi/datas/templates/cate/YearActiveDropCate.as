package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class YearActiveDropCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function YearActiveDropCate(param1:XMLList)
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
      
      public function getDropGoods() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:CommonDropTempInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("itemId");
         return _loc1_;
      }
   }
}

