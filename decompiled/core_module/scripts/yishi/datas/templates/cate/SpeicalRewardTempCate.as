package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SpeicalRewardTempInfo;
   
   public class SpeicalRewardTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SpeicalRewardTempCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,SpeicalRewardTempInfo,_tempXml) as SpeicalRewardTempInfo;
            }
         }
         _list = null;
      }
      
      public function getListByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:SpeicalRewardTempInfo in _dic)
         {
            if(_loc3_.Type == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("Gear",16);
         return _loc2_;
      }
   }
}

