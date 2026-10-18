package yishi.datas.templates.cate
{
   import yishi.datas.templates.TheseusRageSuiteTempInfo;
   
   public class TheseusRageSuiteTempCate extends TemplateCate
   {
      
      private var _dic:Array;
      
      private var _tempXml:XML;
      
      public function TheseusRageSuiteTempCate(param1:XMLList)
      {
         super(param1);
         _dic = [];
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:TheseusRageSuiteTempInfo = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = createNode(_loc1_,TheseusRageSuiteTempInfo,_tempXml) as TheseusRageSuiteTempInfo;
               _dic.push(_loc2_);
            }
            _dic.sortOn("MinLevel",16);
         }
         _list = null;
      }
      
      public function getTempInfo(param1:int) : Array
      {
         var _loc2_:TheseusRageSuiteTempInfo = null;
         var _loc4_:TheseusRageSuiteTempInfo = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _dic.length)
         {
            _loc2_ = _dic[_loc3_];
            if(_loc2_.MinLevel > param1)
            {
               break;
            }
            _loc4_ = _loc2_;
            _loc3_++;
         }
         return [_loc4_,_loc2_];
      }
   }
}

