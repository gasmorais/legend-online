package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ChildNswarTempInfo;
   
   public class ChildNswarTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ChildNswarTempCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,ChildNswarTempInfo,_tempXml) as ChildNswarTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTempById(param1:int) : ChildNswarTempInfo
      {
         return _dic[param1];
      }
      
      public function getTempByType(param1:int, param2:int) : ChildNswarTempInfo
      {
         var _loc3_:ChildNswarTempInfo = null;
         for each(var _loc4_:ChildNswarTempInfo in _dic)
         {
            if(_loc4_.MainType == param1 && _loc4_.SonType == param2)
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getAlltemps() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ChildNswarTempInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("Id",16);
         return _loc1_;
      }
   }
}

