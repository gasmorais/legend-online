package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.yishi.proto.leed.LeadRewardMsg;
   import flash.net.URLVariables;
   import mvc.FrameController;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PathManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.StringHelper;
   
   public class FunnyControler extends FrameController
   {
      
      public static var TIROFUNNY:int = 2;
      
      public static var LUCKVIEW:int = 3;
      
      private var _needUpdate:Boolean = true;
      
      private var _funnyName:String;
      
      public var luckDrawCount:int;
      
      public function FunnyControler()
      {
         super();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4492,__updateHandler);
      }
      
      private function __updateHandler(param1:SLGSocketEvent) : void
      {
         _needUpdate = true;
      }
      
      public function get funnyName() : String
      {
         if(StringHelper.isNullOrEmpty(_funnyName))
         {
            return "";
         }
         return _funnyName;
      }
      
      override protected function get preLoad() : Boolean
      {
         return _needUpdate;
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == TIROFUNNY)
         {
            return "funny.view.TiroFunnyFrame";
         }
         if(_data.openType == LUCKVIEW)
         {
            return "dayguide.GroupLuckFrame";
         }
         return "funny.view.FunnyFrame";
      }
      
      override protected function startPreLoad() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["rnd"] = String(Math.random());
         var _loc2_:String = PathManager.timeStoryPath;
         LoaderManagerII.instance.load(_loc2_,7,8,__completeHandler,null,__errorHandler,null,_loc1_);
      }
      
      private function __errorHandler(param1:LoaderInfo, param2:Object) : void
      {
         _needUpdate = false;
      }
      
      private function __completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:XML = null;
         if(_needUpdate)
         {
            _loc3_ = XML(param2);
            _funnyName = _loc3_.funny.@res ? _loc3_.funny.@res : "";
         }
         _needUpdate = false;
         super.start(_data);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == LUCKVIEW)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      public function sendLuckDraw(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9523);
         var _loc2_:LeadRewardMsg = new LeadRewardMsg();
         _loc2_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

