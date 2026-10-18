package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RevengeRoadTempInfo;
   
   public class RevengeRoadTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RevengeRoadTemplateCate(param1:XMLList)
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
               _loc2_ = " " + _loc1_.@NodeId;
               _dic[_loc2_] = createNode(_loc1_,RevengeRoadTempInfo,_tempXml) as RevengeRoadTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfo(param1:int) : RevengeRoadTempInfo
      {
         for each(var _loc2_:RevengeRoadTempInfo in _dic)
         {
            if(_loc2_.NodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

