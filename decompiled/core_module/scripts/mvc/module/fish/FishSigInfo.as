package mvc.module.fish
{
   import yishi.datas.templates.FishTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class FishSigInfo
   {
      
      public var fishId:int;
      
      public var fishState:int = -1;
      
      public var catchState:int = 0;
      
      public var channelId:int;
      
      public var point:Boolean;
      
      private var _beginTime:Number;
      
      private var _nowSysTime:Number;
      
      private var _templateId:int;
      
      public var fish:*;
      
      public var x:int;
      
      private var _y:int = -1;
      
      private var _fishTempInfo:FishTemplateInfo;
      
      public function FishSigInfo()
      {
         super();
      }
      
      public function get beginTime() : Number
      {
         return _beginTime;
      }
      
      public function set beginTime(param1:Number) : void
      {
         _beginTime = param1;
      }
      
      public function get nowSysTime() : Number
      {
         return _nowSysTime;
      }
      
      public function set nowSysTime(param1:Number) : void
      {
         _nowSysTime = param1;
      }
      
      public function get y() : int
      {
         if(_y == -1)
         {
            return FishModel.FISHCHANNEL[channelId - 1];
         }
         return _y;
      }
      
      public function set y(param1:int) : void
      {
         _y = param1;
      }
      
      public function get fishTempInfo() : FishTemplateInfo
      {
         return _fishTempInfo;
      }
      
      public function get isMove() : Boolean
      {
         return catchState == 0 || fishState == 4 || fishState == 5;
      }
      
      public function get isCatch() : Boolean
      {
         return catchState == 0 && fishState != 4 && fishState != 5;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         _templateId = param1;
         _fishTempInfo = TempleteManager.instance.fishTemplateCate.getTemplateById(param1);
      }
   }
}

