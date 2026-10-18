package mvc.module.kingback
{
   import yishi.datas.templates.KingbackTempInfo;
   import yishi.manager.TempleteManager;
   
   public class KingbackInfo
   {
      
      private var _templateId:int;
      
      public var needCounts:int;
      
      public var rewardState:int;
      
      public var tempInfo:KingbackTempInfo;
      
      public function KingbackInfo()
      {
         super();
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         if(_templateId == param1)
         {
            return;
         }
         _templateId = param1;
         tempInfo = TempleteManager.instance.kingbackTempCate.getTempById(_templateId);
      }
   }
}

