package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusMultiPvpTaskTempInfo;
   
   public class TheseusMultiPvpTaskTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusMultiPvpTaskTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Id + "";
               _dic[_loc2_] = createNode(_loc1_,TheseusMultiPvpTaskTempInfo,_tempXml) as TheseusMultiPvpTaskTempInfo;
            }
         }
         _list = null;
      }
      
      public function getListByArea(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:TheseusMultiPvpTaskTempInfo in _dic)
         {
            if(_loc3_.Area == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("Sort",16);
         return _loc2_;
      }
   }
}

