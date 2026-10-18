package mvc.controler
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import events.TimeVortexEvent;
   import managers.TimeVortexManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.timevortex.TimeVortexModel;
   import yishi.manager.CampaignRankManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   
   public class TimeVortexController extends FrameController
   {
      
      private var _model:TimeVortexModel = TimeVortexManager.instance.model;
      
      private var _isPreLoadOver:Boolean = false;
      
      private var _isOpenMainFrame:Boolean = false;
      
      private var _isOpenCrackFrame:Boolean = false;
      
      private var _iconList:Array;
      
      private var _preChapterId:int;
      
      private var _challengeFrame:Frame;
      
      private var _crackFrame:Frame;
      
      public function TimeVortexController()
      {
         super();
      }
      
      public function get isOpenMainFrame() : Boolean
      {
         return _isOpenMainFrame;
      }
      
      public function set isOpenMainFrame(param1:Boolean) : void
      {
         _isOpenMainFrame = param1;
         NotificationManager.instance.dispatchEvent(new TimeVortexEvent("UPDATE_MAIN_FRAME_STATE",null));
      }
      
      public function get isOpenCrackFrame() : Boolean
      {
         return _isOpenCrackFrame;
      }
      
      public function set isOpenCrackFrame(param1:Boolean) : void
      {
         _isOpenCrackFrame = param1;
         NotificationManager.instance.dispatchEvent(new TimeVortexEvent("UPDATE_CRACK_FRAME_STATE",null));
      }
      
      override public function get frameClassName() : String
      {
         return "timevortex.TimeVortexFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
      }
      
      public function get iconList() : Array
      {
         var _loc1_:String = null;
         if(_model.recentChapter == null)
         {
            _model.getRecentCanSelectChapter();
         }
         if(_preChapterId != _model.recentChapter.chapterId)
         {
            _preChapterId = _model.recentChapter.chapterId;
            _iconList = [];
            _loc1_ = PathManager.resourcePath + "swf/singlecampaign1/" + _model.recentChapter.chapterId + "/map/" + _model.recentChapter.chapterId + ".swf";
            _iconList.push(_loc1_);
         }
         return _iconList;
      }
      
      public function openChallengeFrame() : void
      {
         _challengeFrame = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexChallengeFrame");
         _challengeFrame.addEventListener("response",__challengeFrameResponse);
         _challengeFrame["show"]();
      }
      
      private function __challengeFrameResponse(param1:FrameEvent) : void
      {
         if(_challengeFrame)
         {
            _challengeFrame.removeEventListener("response",__challengeFrameResponse);
            _challengeFrame = null;
         }
      }
      
      public function openCrackFrame() : void
      {
         _crackFrame = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackFrame");
         _crackFrame.addEventListener("response",__crackFrameResponse);
         _crackFrame["show"]();
      }
      
      private function __crackFrameResponse(param1:FrameEvent) : void
      {
         if(_crackFrame)
         {
            _crackFrame.removeEventListener("response",__crackFrameResponse);
            _crackFrame = null;
         }
      }
      
      public function closeSecondaryFrame() : void
      {
         if(_challengeFrame)
         {
            _challengeFrame.dispose();
            _challengeFrame = null;
         }
         if(_crackFrame)
         {
            _crackFrame.dispose();
            _crackFrame = null;
         }
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(!CampaignRankManager.instance.timeVortexInited)
         {
            CampaignRankManager.instance.initTimeVortexRankDic();
         }
         _model.getRecentCanSelectChapter();
         super.start(param1);
      }
      
      override protected function exitFrame() : void
      {
         _model.selectedChapter = null;
         _model.selectedLand = null;
         _model.selectedArea = null;
         _model.selectedCrack = null;
         super.exitFrame();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

