package goldenDionysia.prizeInfo
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.cccactive.GoldCrazyMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import goldenDionysia.middleInfo.GoldenDionysiaMiddle1;
   import goldenDionysia.middleInfo.GoldenDionysiaMiddle2;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoldenDionysiaManager;
   import yishi.manager.NotificationManager;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class GoldenDionysiaFrame extends Frame implements IManualSize
   {
      
      private var _middleInfo1:GoldenDionysiaMiddle1;
      
      private var _middleInfo2:GoldenDionysiaMiddle2;
      
      private var _item1:GoldenDionysiaItem;
      
      private var _item2:GoldenDionysiaItem;
      
      private var _item3:GoldenDionysiaItem;
      
      private var _item4:GoldenDionysiaItem;
      
      private var _item5:GoldenDionysiaItem;
      
      private var _timeView:GoldenDionysiaTimeView;
      
      private var _luckyView:GoldenDionysiaLuckyView;
      
      private var _helpBtn:BaseButton;
      
      private var _tilteBmp:MutipleImage;
      
      private var _centerBg:Bitmap;
      
      private var _goldenMsg:GoldCrazyMsg;
      
      private var _resultMsg:Array;
      
      private var _bgBorderBmp:ScaleBitmapImage;
      
      public function GoldenDionysiaFrame()
      {
         super();
         initView();
         addEvent();
         GoldenDionysiaManager.instance.OperateGoldenDionysiaReq(GoldenDionysiaManager.OPEN);
      }
      
      public static function randRange(param1:Number, param2:int) : int
      {
         var _loc3_:int = Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
         if(_loc3_ <= 0)
         {
            _loc3_ = 1;
         }
         if(_loc3_ >= 6)
         {
            _loc3_ = 6;
         }
         return _loc3_;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,810,615);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP","CASTLE_BUIDING_GROUP"];
      }
      
      private function initView() : void
      {
         _tilteBmp = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaFrame.title");
         _bgBorderBmp = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRank.border");
         _centerBg = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.centerBgBmp");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaFrame.helpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _middleInfo1 = ComponentFactory.Instance.creatCustomObject("goldenDionysia.middleInfo.GoldenDionysiaMiddle1");
         _middleInfo2 = ComponentFactory.Instance.creatCustomObject("goldenDionysia.middleInfo.GoldenDionysiaMiddle2");
         _item1 = ComponentFactory.Instance.creatCustomObject("goldenDionysia.prizeInfo.GoldenDionysiaItem",[1]);
         _item2 = ComponentFactory.Instance.creatCustomObject("goldenDionysia.prizeInfo.GoldenDionysiaItem",[2]);
         _item3 = ComponentFactory.Instance.creatCustomObject("goldenDionysia.prizeInfo.GoldenDionysiaItem",[3]);
         _item4 = ComponentFactory.Instance.creatCustomObject("goldenDionysia.prizeInfo.GoldenDionysiaItem",[4]);
         _item5 = ComponentFactory.Instance.creatCustomObject("goldenDionysia.prizeInfo.GoldenDionysiaItem",[5]);
         _timeView = ComponentFactory.Instance.creatCustomObject("goldenDionysia.prizeInfo.GoldenDionysiaTimeView");
         _luckyView = ComponentFactory.Instance.creatCustomObject("goldenDionysia.prizeInfo.GoldenDionysiaLuckyView");
         addToContent(_tilteBmp);
         addToContent(_bgBorderBmp);
         addToContent(_centerBg);
         addToContent(_helpBtn);
         addToContent(_middleInfo1);
         addToContent(_middleInfo2);
         addToContent(_item1);
         _item1.x = 0;
         _item1.y = 16;
         addToContent(_item2);
         _item2.x = 0;
         _item2.y = 176;
         addToContent(_item3);
         _item3.x = 0;
         _item3.y = 337;
         addToContent(_item4);
         _item4.x = 581;
         _item4.y = 22;
         addToContent(_item5);
         _item5.x = 581;
         _item5.y = 315;
         addToContent(_timeView);
         _timeView.x = 588;
         _timeView.y = 184;
         addToContent(_luckyView);
         _luckyView.x = 586;
         _luckyView.y = 348;
         _timeView.visible = false;
         _luckyView.visible = false;
         _middleInfo1.visible = false;
         _middleInfo2.visible = false;
      }
      
      private function addEvent() : void
      {
         _helpBtn.addEventListener("click",__helpBtnHandler);
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("GOLDEN_DIONYSIA_INFO",__updateViewHandler);
         NotificationManager.instance.addEventListener("GOLDEN_DIONYSIA_RESULT",__resultHandler);
         NotificationManager.instance.addEventListener("GOLDEN_DIONYSIA_SHINE",__shineHandler);
      }
      
      private function removeEvent() : void
      {
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("GOLDEN_DIONYSIA_INFO",__updateViewHandler);
         NotificationManager.instance.removeEventListener("GOLDEN_DIONYSIA_RESULT",__resultHandler);
         NotificationManager.instance.removeEventListener("GOLDEN_DIONYSIA_SHINE",__shineHandler);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         _goldenMsg = GoldenDionysiaManager.instance.goldenMsg;
         _item1.data = GoldenDionysiaManager.instance.getRewardArrByType(1);
         _item2.data = GoldenDionysiaManager.instance.getRewardArrByType(2);
         _item3.data = GoldenDionysiaManager.instance.getRewardArrByType(3);
         _item4.data = GoldenDionysiaManager.instance.getRewardArrByType(4);
         _item5.data = GoldenDionysiaManager.instance.getRewardArrByType(5);
         if(_goldenMsg.state == GoldenDionysiaManager.STATE1)
         {
            _timeView.visible = true;
            _timeView.update();
            _middleInfo1.visible = true;
         }
         else
         {
            _luckyView.visible = true;
            _luckyView.update();
            _middleInfo2.visible = true;
            _item5.y = 183;
         }
      }
      
      private function __shineHandler(param1:NotificationEvent) : void
      {
         showLightAnimation(true);
      }
      
      private function __resultHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         _resultMsg = _loc2_;
         if(_resultMsg[0] == 4 || _resultMsg[0] == 5)
         {
            showDiceAnimation(createDice());
         }
      }
      
      private function createDice() : Array
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         var _loc6_:int = 3;
         var _loc2_:int = int(_resultMsg[1]);
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc3_ = _loc2_ - 6 * (_loc6_ - _loc5_ - 1) <= 0 ? 1 : _loc2_ - 6 * (_loc6_ - _loc5_ - 1);
            _loc4_ = randRange(_loc3_,_loc2_ - (_loc6_ - _loc5_ - 1));
            _loc2_ -= _loc4_;
            _loc1_.push(_loc4_);
            _loc5_ += 1;
         }
         return _loc1_;
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaFrame.helpFrame");
         _loc2_.show();
      }
      
      public function showLightAnimation(param1:Boolean) : void
      {
         var mc:MovieClip;
         var toShow:Boolean = param1;
         if(toShow)
         {
            mc = ComponentFactory.Instance.creatCustomObject("goldendionysia.effectAnimation");
            mc.gotoAndStop(1);
            addToContent(mc);
            mc.addFrameScript(mc.totalFrames - 1,function():void
            {
               ObjectUtils.disposeObject(mc);
            });
            mc.play();
         }
      }
      
      public function showDiceAnimation(param1:Array) : void
      {
         var diceAnimation:DiceAnimation;
         var diceNumList:Array = param1;
         if(diceNumList != null && diceNumList.length >= 3)
         {
            diceAnimation = new DiceAnimation(diceNumList,function():void
            {
               showGetRewardAnimation(true,_resultMsg);
               ObjectUtils.disposeObject(diceAnimation);
            });
            LayerManager.Instance.addToLayer(diceAnimation,3,true,true,1,0,true);
         }
      }
      
      public function showGetRewardAnimation(param1:Boolean, param2:Array) : void
      {
         if(param1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("GoldenDionysiaFrame.winCountTxt" + param2[0]));
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_middleInfo1);
         _middleInfo1 = null;
         ObjectUtils.disposeObject(_middleInfo2);
         _middleInfo2 = null;
         ObjectUtils.disposeObject(_item1);
         _item1 = null;
         ObjectUtils.disposeObject(_item2);
         _item2 = null;
         ObjectUtils.disposeObject(_item3);
         _item3 = null;
         ObjectUtils.disposeObject(_item4);
         _item4 = null;
         ObjectUtils.disposeObject(_item5);
         _item5 = null;
         ObjectUtils.disposeObject(_timeView);
         _timeView = null;
         ObjectUtils.disposeObject(_luckyView);
         _luckyView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_tilteBmp);
         _tilteBmp = null;
         ObjectUtils.disposeObject(_centerBg);
         _centerBg = null;
         ObjectUtils.disposeObject(_bgBorderBmp);
         _bgBorderBmp = null;
         _goldenMsg = null;
         super.dispose();
      }
   }
}

