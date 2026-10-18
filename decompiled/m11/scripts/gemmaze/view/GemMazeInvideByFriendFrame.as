package gemmaze.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.gemmaze.GemMazeModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FriendManager;
   import yishi.manager.GemMazeManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   
   public class GemMazeInvideByFriendFrame extends Frame implements IManualSize
   {
      
      private static var CD_TIME_DEL:uint = 1;
      
      private var _bg:Bitmap;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _dlgBitmap:Bitmap;
      
      private var _closeTipsImg:Bitmap;
      
      private var _cdTimeTxt:FilterFrameText;
      
      private var _helpTimesTxt:FilterFrameText;
      
      private var _sortMc0:MovieClip;
      
      private var _sortMc1:MovieClip;
      
      private var _pullBtn:MovieClip;
      
      private var _mode:GemMazeModel;
      
      private var _timer:Timer;
      
      private var cD_Timr:uint = 10;
      
      private var _hasPlay:Boolean = false;
      
      private var _numBmpData:BitmapData;
      
      private var _timeid:int;
      
      private var _timeid2:int;
      
      private var _isOutTime:Boolean = false;
      
      public function GemMazeInvideByFriendFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("gemMaze.GemMazeInvideByFriendFrame.Title");
         _bg = ComponentFactory.Instance.creatBitmap("asset.GemMaze.InvideByBg");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.InvideByTipsTxt");
         _dlgBitmap = ComponentFactory.Instance.creatBitmap("asset.GemMaze.InvideByDlg");
         _closeTipsImg = ComponentFactory.Instance.creatBitmap("asset.GemMaze.InvideByCloseTipsImg");
         _cdTimeTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.InvideByCdTimeTxt");
         _helpTimesTxt = ComponentFactory.Instance.creatComponentByStylename("gemMaze.InvideTimesTxt");
         _numBmpData = ComponentFactory.Instance.creatBitmapData("asset.GemMaze.numberpng").clone();
         _sortMc0 = ComponentFactory.Instance.creatCustomObject("GemMaze.slotResult_0");
         _sortMc0.gotoAndStop("pointStart");
         _sortMc1 = ComponentFactory.Instance.creatCustomObject("GemMaze.slotResult_1");
         _sortMc1.gotoAndStop("pointStart");
         _pullBtn = ComponentFactory.Instance.creatCustomObject("GemMaze.PullBtn");
         _pullBtn.stop();
         addToContent(_bg);
         addToContent(_tipsTxt);
         addToContent(_dlgBitmap);
         addToContent(_closeTipsImg);
         addToContent(_cdTimeTxt);
         addToContent(_helpTimesTxt);
         addToContent(_sortMc0);
         addToContent(_sortMc1);
         addToContent(_pullBtn);
         _mode = GemMazeManager.Instance.model;
         _timer = new Timer(CD_TIME_DEL * 1000);
         _timer.start();
         updateView();
         GemMazeManager.Instance.model.invideByFriendIsOpen = true;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _pullBtn.addEventListener("click",onPullBtnClick);
         _sortMc1.addEventListener("complete",__completeHandler);
         _timer.addEventListener("timer",onTimer);
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         cD_Timr -= CD_TIME_DEL;
         if(cD_Timr <= 0)
         {
            _isOutTime = true;
            _timer.stop();
            dispose();
         }
         updateView();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _sortMc1.removeEventListener("complete",__completeHandler);
         _pullBtn.removeEventListener("click",onPullBtnClick);
      }
      
      public function updateView() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = int(_mode.invideByPlayerId);
         try
         {
            _loc1_ = FriendManager.getInstance().getFriendById(_loc2_).nickName;
         }
         catch(e:Error)
         {
         }
         _tipsTxt.text = LanguageMgr.GetTranslation("gemMaze.GemMazeInvideByFriendFrame.titleTxt",_loc1_);
         _cdTimeTxt.text = DateFormatter.getCountDate(cD_Timr,2,2);
         _helpTimesTxt.text = LanguageMgr.GetTranslation("gemMaze.GemMazeInvideByFriendFrame.helpTimesLeft",_mode.invideLeftTimes);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      private function onPullBtnClick(param1:MouseEvent) : void
      {
         _pullBtn.removeEventListener("click",onPullBtnClick);
         _timer.stop();
         _pullBtn.play();
         var _loc3_:String = getResultStr(int(_mode.invideRemoveGemCount / 10));
         var _loc2_:String = getResultStr(int(_mode.invideRemoveGemCount % 10));
         _sortMc0.gotoAndPlay("roll");
         _sortMc1.gotoAndPlay("roll");
         _closeButton.enable = false;
         _timeid = setTimeout(playStopEffect,2000,_loc3_,_loc2_);
         _hasPlay = true;
         GemMazeManager.Instance.helpFriend(1);
      }
      
      private function playStopEffect(param1:String, param2:String) : void
      {
         clearTimeout(_timeid);
         _sortMc0.gotoAndPlay("pointStart");
         NumberViewUtils.refreshValueY(param1,_sortMc0["n1"],_numBmpData,29,53,53,53,"1234567890");
         NumberViewUtils.refreshValueY(param1,_sortMc0["n2"],_numBmpData,29,53,53,53,"1234567890");
         _sortMc0.play();
         _timeid2 = setTimeout(playStopEffect2,2000,param2);
      }
      
      private function playStopEffect2(param1:String) : void
      {
         clearTimeout(_timeid2);
         _sortMc1.gotoAndPlay("pointStart");
         NumberViewUtils.refreshValueY(param1,_sortMc1["n1"],_numBmpData,29,53,53,53,"1234567890");
         NumberViewUtils.refreshValueY(param1,_sortMc1["n2"],_numBmpData,29,53,53,53,"1234567890");
         _sortMc1.play();
      }
      
      private function getResultStr(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = "";
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc3_ += ((param1 + _loc2_ + 9) % 10).toString();
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function __completeHandler(param1:Event) : void
      {
         if(_closeButton)
         {
            _closeButton.enable = true;
         }
         if(_mode)
         {
            _mode.invideLeftTimes--;
         }
         try
         {
            updateView();
            setTimeout(dispose,3000);
         }
         catch(e:Error)
         {
         }
      }
      
      override public function get groups() : Array
      {
         return ["POPUP"];
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,270,302);
      }
      
      override public function dispose() : void
      {
         GemMazeManager.Instance.model.invideByFriendIsOpen = false;
         if(!_hasPlay && !_isOutTime)
         {
            GemMazeManager.Instance.helpFriend(2);
         }
         if(_isOutTime)
         {
            GemMazeManager.Instance.helpFriend(3);
         }
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

