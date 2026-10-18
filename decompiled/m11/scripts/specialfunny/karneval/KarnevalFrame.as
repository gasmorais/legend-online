package specialfunny.karneval
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.FunnyEvent;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.ModuleFrameInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class KarnevalFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _pointImg:MutipleImage;
      
      private var _expenseTxt:FilterFrameText;
      
      private var _middleTxt:FilterFrameText;
      
      private var _middleEndTxt:FilterFrameText;
      
      private var _minuTxt:FilterFrameText;
      
      private var _totalTxt:FilterFrameText;
      
      private var _mineTxt:FilterFrameText;
      
      private var _sortTxt:FilterFrameText;
      
      private var _needTxt:FilterFrameText;
      
      private var _endImg:Bitmap;
      
      private var _playerVbox:VBox;
      
      private var _playerList:Vector.<ExpenseItem>;
      
      private var _bagList:Vector.<KarnevalBagItem>;
      
      private var _sp:Sprite;
      
      private var _data:FunnyData;
      
      private var _helpBtn:BaseButton;
      
      public function KarnevalFrame()
      {
         super();
         _data = FunnyManager.instance.model.findDataByType(51);
         initView();
         initEvent();
         if(_data)
         {
            FunnyManager.instance.selectedId = _data.id;
            FunnyManager.instance.sendGetBag(3);
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,708,600);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initData() : void
      {
         var _loc1_:ExpenseItem = null;
         var _loc2_:int = 0;
         var _loc3_:KarnevalBagItem = null;
         if(_data == null)
         {
            dispose();
            return;
         }
         _playerList = new Vector.<ExpenseItem>();
         _bagList = new Vector.<KarnevalBagItem>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new ExpenseItem();
            _loc1_.data = null;
            _playerList.push(_loc1_);
            _playerVbox.addChild(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc3_ = new KarnevalBagItem();
            _loc3_.x = _loc2_ % 2 * 332;
            _loc3_.y = int(_loc2_ / 2) * 94;
            _loc3_.data = null;
            _bagList.push(_loc3_);
            _sp.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      private function setView() : void
      {
         var _loc3_:int = 0;
         if(_data == null || _data.expenseList == null || _data.bagList == null || Boolean(isDie))
         {
            dispose();
            return;
         }
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            if(_data.expenseList.length > _loc3_)
            {
               if(_playerList.length > _loc3_)
               {
                  _playerList[_loc3_].data = _data.expenseList[_loc3_];
               }
               if(_data.expenseList[_loc3_].userId == PlayerManager.instance.currentPlayerModel.userInfo.userId)
               {
                  _loc1_ = int(_data.expenseList[_loc3_].point);
                  _loc4_ = int(_data.expenseList[_loc3_].order);
               }
               if(_data.expenseList[_loc3_].order <= 3)
               {
                  _loc2_ += _data.expenseList[_loc3_].point;
               }
            }
            _loc3_++;
         }
         _mineTxt.text = _loc1_ + "";
         _sortTxt.text = _loc4_ + "";
         _totalTxt.text = _loc2_ + "";
         if(parseInt(_data.appendParam))
         {
            _needTxt.text = _data.appendParam;
            _endImg.visible = _loc2_ >= parseInt(_data.appendParam);
         }
         _loc2_ = (_data.endTime - PlayerManager.instance.currentPlayerModel.nowDate) / 1000 / 60;
         _minuTxt.text = _loc2_ + "";
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _bagList[_loc3_].data = null;
            if(_data.bagList.length > _loc3_)
            {
               _bagList[_loc3_].data = _data.bagList[_loc3_];
            }
            _loc3_++;
         }
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.karnevalBtn.tipData");
         _bg = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.bg");
         _pointImg = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.SmallPointImg");
         _expenseTxt = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.expenseTxt");
         _middleTxt = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.middleTxt");
         _middleEndTxt = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.middleEndTxt");
         _minuTxt = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.minuTxt");
         _totalTxt = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.totalTxt");
         _mineTxt = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.mineTxt");
         _sortTxt = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.sortTxt");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.needTxt");
         _endImg = ComponentFactory.Instance.creatBitmap("asset.onlinereward.KarnevalEnd");
         _playerVbox = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.playerVbox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.BottleHelpBtn");
         _sp = new Sprite();
         _sp.x = 9;
         _sp.y = 206;
         addToContent(_bg);
         addToContent(_pointImg);
         addToContent(_expenseTxt);
         addToContent(_middleTxt);
         addToContent(_middleEndTxt);
         addToContent(_minuTxt);
         addToContent(_totalTxt);
         addToContent(_mineTxt);
         addToContent(_sortTxt);
         addToContent(_needTxt);
         addToContent(_endImg);
         _endImg.visible = false;
         addToContent(_playerVbox);
         addToContent(_sp);
         addToContent(_helpBtn);
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _expenseTxt.text = LanguageMgr.GetTranslation("specialfunny.KarnevalFrame.expenseTxt.text");
         _middleTxt.text = LanguageMgr.GetTranslation("specialfunny.KarnevalFrame.middleTxt.text");
         _middleEndTxt.text = LanguageMgr.GetTranslation("specialfunny.KarnevalFrame.middleTxt.end.text");
         initData();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_expenseTxt);
         _expenseTxt = null;
         ObjectUtils.disposeObject(_middleTxt);
         _middleTxt = null;
         ObjectUtils.disposeObject(_totalTxt);
         _totalTxt = null;
         ObjectUtils.disposeObject(_minuTxt);
         _minuTxt = null;
         ObjectUtils.disposeObject(_mineTxt);
         _mineTxt = null;
         ObjectUtils.disposeObject(_sortTxt);
         _sortTxt = null;
         ObjectUtils.disposeObject(_needTxt);
         _needTxt = null;
         ObjectUtils.disposeObject(_endImg);
         _endImg = null;
         ObjectUtils.disposeObject(_playerVbox);
         _playerVbox = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(_sp);
         _sp = null;
      }
      
      private function __updateHandler(param1:FunnyEvent) : void
      {
         setView();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__openHelpHandler);
         }
         FunnyManager.instance.addEventListener("REFRESH_KARNEVAL",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__openHelpHandler);
         }
         FunnyManager.instance.removeEventListener("REFRESH_KARNEVAL",__updateHandler);
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
      
      private function __openHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("KarnevalFrame.BottleHelpFrame");
         _loc2_.show();
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

