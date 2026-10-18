package chess
{
   import chess.item.SelfChessHeroItem;
   import chess.item.SelfChessLockItem;
   import chess.item.SelfChessTeamItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.chess.SelfChessPlayerInfo;
   import yishi.SwitchPageHelp;
   import yishi.events.NotificationEvent;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SelfChessBottomView extends Sprite
   {
      
      public var _bottomBg:Bitmap;
      
      public var _bottomHbox2:HBox;
      
      public var _lockBtn:SelfChessLockItem;
      
      public var _btRefreshGold:Image;
      
      public var _btRefreshGoldTxt:FilterFrameText;
      
      public var _bottomUpBg:Bitmap;
      
      public var _recyle:SelfChessRecycleView;
      
      public var _bottomHbox1:HBox;
      
      private var refreshBtn:BaseButton;
      
      private var itemList:Vector.<SelfChessHeroItem>;
      
      private var teamList:Vector.<SelfChessTeamItem>;
      
      private var _refreshTxt:GradientText;
      
      public var _exitBtn:BaseButton;
      
      private var _selectContiner:Sprite;
      
      private var _selectImg:Bitmap;
      
      private var _goldMc:MovieClip;
      
      public function SelfChessBottomView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.selfchess.bottomBg");
         _bottomHbox2 = ComponentFactory.Instance.creatCustomObject("ui.selfchess.bottomHbox2");
         _lockBtn = ComponentFactory.Instance.creatCustomObject("ui.selfchess.lockBtn");
         _btRefreshGold = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.btRefreshGold");
         _btRefreshGoldTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.btRefreshGoldTxt");
         _bottomUpBg = ComponentFactory.Instance.creatBitmap("asset.selfchess.bottomUpBg");
         _recyle = ComponentFactory.Instance.creatCustomObject("ui.selfchess.recyle");
         _bottomHbox1 = ComponentFactory.Instance.creatCustomObject("ui.selfchess.bottomHbox1");
         refreshBtn = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.btRefreshBtn");
         _refreshTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.refreshTTTxt");
         _refreshTxt.text = LanguageMgr.GetTranslation("selfchess.refreshName");
         _goldMc = ComponentFactory.Instance.creatCustomObject("ui.selfchess.goldMc");
         _selectContiner = new Sprite();
         _selectImg = ComponentFactory.Instance.creatBitmap("asset.selfchess.selectedImg");
         _exitBtn = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.exitBtn");
         _btRefreshGoldTxt.text = "2";
         addChild(_bottomBg);
         addChild(_bottomHbox2);
         addChild(_lockBtn);
         addChild(_btRefreshGoldTxt);
         addChild(_bottomUpBg);
         addChild(_recyle);
         addChild(_goldMc);
         addChild(_bottomHbox1);
         addChild(refreshBtn);
         addChild(_btRefreshGold);
         addChild(_refreshTxt);
         addChild(_exitBtn);
         addChild(_selectContiner);
         refreshBtn.tipData = LanguageMgr.GetTranslation("selfchess.refreshBtn.Tip");
         _goldMc.gotoAndStop(18);
         _goldMc.mouseChildren = _goldMc.mouseEnabled = false;
         _selectContiner.addChild(_selectImg);
         _selectContiner.mouseChildren = _selectContiner.mouseEnabled = false;
         _selectImg.visible = false;
         _selectContiner.x = _bottomHbox2.x;
         _selectContiner.y = _bottomHbox2.y;
         itemList = new Vector.<SelfChessHeroItem>();
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            itemList[_loc1_] = new SelfChessHeroItem(_loc1_ + 1,_selectImg);
            _bottomHbox2.addChild(itemList[_loc1_]);
            _loc1_++;
         }
         teamList = new Vector.<SelfChessTeamItem>();
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            teamList[_loc1_] = ComponentFactory.Instance.creatCustomObject("chess.item.SelfChessTeamItem",[10 + _loc1_ + 1]);
            _bottomHbox1.addChild(teamList[_loc1_]);
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         _lockBtn.addEventListener("click",lockHandler);
         _exitBtn.addEventListener("click",exitGameHandler);
         refreshBtn.addEventListener("click",refreshHandler);
         NotificationManager.instance.addEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
         NotificationManager.instance.addEventListener("slefChessPlayGold",playGoldHandler);
      }
      
      private function removeEvent() : void
      {
         _lockBtn.removeEventListener("click",lockHandler);
         _exitBtn.removeEventListener("click",exitGameHandler);
         refreshBtn.removeEventListener("click",refreshHandler);
         NotificationManager.instance.removeEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
         NotificationManager.instance.removeEventListener("slefChessPlayGold",playGoldHandler);
      }
      
      private function playGoldHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         _goldMc.content.txt.text = LanguageMgr.GetTranslation("sevenyear.selfchess.goldMc",_loc2_);
         _goldMc.gotoAndPlay(1);
      }
      
      private function __startDragHandler(param1:NotificationEvent) : void
      {
         var _loc3_:SelfChessTeamItem = param1.data as SelfChessTeamItem;
         for each(var _loc2_:SelfChessTeamItem in teamList)
         {
            if(_loc2_.pos != _loc3_.pos)
            {
               _loc2_.setBottomVisible(true);
               _loc2_.dark();
            }
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:SelfChessTeamItem in teamList)
         {
            _loc2_.setBottomVisible(false);
            _loc2_.normal();
         }
      }
      
      private function lockHandler(param1:MouseEvent) : void
      {
         var _loc2_:SelfChessPlayerInfo = SelfChessManager.Ins.model.selfInfo;
         if(_loc2_)
         {
            if(_loc2_.lock == 0)
            {
               SelfChessManager.Ins.sendOp(10,1);
            }
            else
            {
               SelfChessManager.Ins.sendOp(10,0);
            }
         }
      }
      
      private function exitGameHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("mainBar.MainToolBar.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("selfchess.room.exit.hint");
         SimpleAlertHelper.instance.data = [exitSelfChessGame];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
      }
      
      private function exitSelfChessGame(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SelfChessManager.Ins.exitGame();
            SwitchPageHelp.returnToSpace();
         }
      }
      
      private function refreshHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SelfChessPlayerInfo = SelfChessManager.Ins.model.selfInfo;
         if(_loc3_)
         {
            _loc2_ = int(_loc3_.gold);
         }
         if(_loc2_ < 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("selfchess.buy.noGold"));
            return;
         }
         SelfChessManager.Ins.sendOp(6);
      }
      
      public function refreshView() : void
      {
         var _loc1_:SelfChessPlayerInfo = SelfChessManager.Ins.model.selfInfo;
         if(_loc1_)
         {
            refreshPool();
            refreshWait();
            refreshLock();
         }
      }
      
      public function refreshWait() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SelfChessPlayerInfo = SelfChessManager.Ins.model.selfInfo;
         if(_loc4_)
         {
            _loc1_ = _loc4_.alternateAry;
            _loc2_ = int(_loc1_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               teamList[_loc3_].dateTempId = _loc1_[_loc3_];
               _loc3_++;
            }
         }
      }
      
      public function refreshPool() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SelfChessPlayerInfo = SelfChessManager.Ins.model.selfInfo;
         if(_loc4_)
         {
            _loc1_ = _loc4_.cardPool;
            _loc2_ = int(_loc1_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               itemList[_loc3_].tempId = _loc1_[_loc3_];
               _loc3_++;
            }
         }
      }
      
      public function refreshLock() : void
      {
         var _loc1_:SelfChessPlayerInfo = SelfChessManager.Ins.model.selfInfo;
         if(_loc1_)
         {
            _lockBtn.isLock = _loc1_.lock;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_bottomHbox2);
         _bottomHbox2 = null;
         ObjectUtils.disposeObject(_lockBtn);
         _lockBtn = null;
         ObjectUtils.disposeObject(refreshBtn);
         refreshBtn = null;
         ObjectUtils.disposeObject(_btRefreshGold);
         _btRefreshGold = null;
         ObjectUtils.disposeObject(_btRefreshGoldTxt);
         _btRefreshGoldTxt = null;
         ObjectUtils.disposeObject(_bottomUpBg);
         _bottomUpBg = null;
         ObjectUtils.disposeObject(_recyle);
         _recyle = null;
         ObjectUtils.disposeObject(_bottomHbox1);
         _bottomHbox1 = null;
         ObjectUtils.disposeObject(_refreshTxt);
         _refreshTxt = null;
         ObjectUtils.disposeObject(_exitBtn);
         _exitBtn = null;
         ObjectUtils.disposeAllChildren(_selectContiner);
         ObjectUtils.disposeObject(_selectContiner);
         _selectContiner = null;
         ObjectUtils.disposeViolentMc(_goldMc);
         _goldMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         itemList = null;
         teamList = null;
         _selectImg = null;
         DragManager.getInstance().stopDrag();
      }
   }
}

