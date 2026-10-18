package exchargerank
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import exchargerank.view.ExchargeCrossSerRankView;
   import exchargerank.view.ExchargeRankBagView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.FunnyEvent;
   import manager.LanguageMgr;
   import managers.ExchargeRankManager;
   import mvc.controler.ExchargeRankController;
   import mvc.module.exchargerank.ExchargeData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class ExchargeRankingFrame extends Frame implements IManualSize
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _leftVBox:VBox;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _helpBtn:BaseButton;
      
      private var _index:int = -1;
      
      private var _showData:Vector.<ExchargeData>;
      
      private var _controller:ExchargeRankController;
      
      private var _exchargeRankBtn:SelectedIconButton;
      
      private var _exchargeRewardBtn:SelectedIconButton;
      
      private var _exchargeSingleRewardBtn:SelectedIconButton;
      
      private var _count:Number = 0;
      
      private var _exchargeRankCrossView:ExchargeCrossSerRankView;
      
      private var _exchargeRankRewardView:ExchargeRankBagView;
      
      private var _todayBg:Bitmap;
      
      private var _todayCostBmp:Bitmap;
      
      private var _totalCountBmp:Bitmap;
      
      private var _todayTxtBg:Bitmap;
      
      private var _todayTxtBg1:Bitmap;
      
      private var _myTodayCostText:FilterFrameText;
      
      private var _myTotalCount:FilterFrameText;
      
      private var _tipText:FilterFrameText;
      
      public function ExchargeRankingFrame()
      {
         super();
         FrameControllerManager.instance.exchargeAllControler.model.addEventListener("EXCHARGE_RANK",initFrame);
         ExchargeRankManager.instance.sendInitBagData(1);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         KeyBoardRegister.instance.keyEnable = false;
         _controller = FrameControllerManager.instance.exchargeAllControler;
         _controller.model.canShine = false;
         _controller.isOpenCrossPayFrame = true;
         _controller.loadXML();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,765,515);
      }
      
      private function initFrame(param1:Event) : void
      {
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("exchargeRankFrame.back");
         titleText = LanguageMgr.GetTranslation("mainBar.TopToolsBar.exchargerank.title1");
         _leftVBox = ComponentFactory.Instance.creatComponentByStylename("exchargeRankFrame.leftVBox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("exchargeRankFrame.helpbtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("exchargerankFrame.helpBtn.tipText");
         _exchargeRankBtn = ComponentFactory.Instance.creatComponentByStylename("exchargeRankFrame.exchargeRankBtn");
         _exchargeRewardBtn = ComponentFactory.Instance.creatComponentByStylename("exchargeRankFrame.exchargeRewardBtn");
         _exchargeSingleRewardBtn = ComponentFactory.Instance.creatComponentByStylename("exchargeRankFrame.exchargeSingleRewardBtn");
         _todayBg = ComponentFactory.Instance.creatBitmap("asset.exchargerank.todayBg");
         _todayCostBmp = ComponentFactory.Instance.creatBitmap("asset.exchargerank.todayExchargeBmp");
         _totalCountBmp = ComponentFactory.Instance.creatBitmap("asset.exchargerank.exchargeCountBmp");
         _todayTxtBg = ComponentFactory.Instance.creatBitmap("asset.exchargerank.todayTxtBg");
         _todayTxtBg1 = ComponentFactory.Instance.creatBitmap("asset.exchargerank.todayTxtBg1");
         _myTodayCostText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.MyTodayCostText");
         _myTotalCount = ComponentFactory.Instance.creatComponentByStylename("exchargerank.MyTotalCount");
         _tipText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.MainFrameTipText");
         _selectedBtnGroup = new SelectedButtonGroup();
         _exchargeRankCrossView = new ExchargeCrossSerRankView();
         _exchargeRankRewardView = new ExchargeRankBagView();
         addToContent(_bg);
         addToContent(_helpBtn);
         addToContent(_exchargeRankCrossView);
         _leftVBox.addChild(_exchargeRankBtn);
         addToContent(_leftVBox);
         addToContent(_todayBg);
         addToContent(_todayCostBmp);
         addToContent(_totalCountBmp);
         addToContent(_todayTxtBg);
         addToContent(_todayTxtBg1);
         addToContent(_myTodayCostText);
         addToContent(_myTotalCount);
         addToContent(_tipText);
         _selectedBtnGroup.addSelectItem(_exchargeRankBtn);
         _selectedBtnGroup.addSelectItem(_exchargeRewardBtn);
         _selectedBtnGroup.addSelectItem(_exchargeSingleRewardBtn);
         _selectedBtnGroup.selectIndex = 0;
         __selectedHandler(null);
         _tipText.text = LanguageMgr.GetTranslation("exchargerank.ExchargeRankingFrame.Tip01");
         _myTodayCostText.text = ExchargeRankManager.instance._dayTotalCount + "";
         _myTotalCount.text = ExchargeRankManager.instance._myTotalCount + "";
      }
      
      private function get exchargeData() : Vector.<ExchargeData>
      {
         return FrameControllerManager.instance.exchargeAllControler.model.data;
      }
      
      private function get exchargeRankData() : Array
      {
         return FrameControllerManager.instance.exchargeAllControler.model.exchargeRankList;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selectedBtnGroup.addEventListener("change",__selectedHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         ExchargeRankManager.instance.addEventListener("REFRESH_ITEM",__updateHandler);
      }
      
      private function __updateHandler(param1:FunnyEvent) : void
      {
         __selectedHandler(null);
      }
      
      private function __exchargeRankBtnHandler(param1:MouseEvent) : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.TopToolsBar.exchargerank.title1");
         if(_exchargeRankRewardView && _exchargeRankRewardView.parent)
         {
            _exchargeRankRewardView.parent.removeChild(_exchargeRankRewardView);
         }
         addToContent(_exchargeRankCrossView);
      }
      
      private function __exchargeRewardBtnHandler(param1:MouseEvent) : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.TopToolsBar.exchargerank.title2");
         if(_exchargeRankCrossView && _exchargeRankCrossView.parent)
         {
            _exchargeRankCrossView.parent.removeChild(_exchargeRankCrossView);
         }
         if(_exchargeRankRewardView)
         {
            _exchargeRankRewardView.cleanView();
            addToContent(_exchargeRankRewardView);
            _exchargeRankRewardView.data = _showData[0];
         }
      }
      
      private function __exchargeSingleRewardBtnHandler(param1:MouseEvent) : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.TopToolsBar.exchargerank.title3");
         if(_exchargeRankCrossView && _exchargeRankCrossView.parent)
         {
            _exchargeRankCrossView.parent.removeChild(_exchargeRankCrossView);
         }
         if(_exchargeRankRewardView)
         {
            _exchargeRankRewardView.cleanView();
            addToContent(_exchargeRankRewardView);
            _exchargeRankRewardView.data = _showData[1];
         }
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("exchargerank.help");
         _loc2_["show"]();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _selectedBtnGroup.removeEventListener("change",__selectedHandler);
         FrameControllerManager.instance.exchargeAllControler.model.removeEventListener("EXCHARGE_RANK",initFrame);
         ExchargeRankManager.instance.removeEventListener("REFRESH_ITEM",__updateHandler);
      }
      
      private function initData() : void
      {
         var _loc1_:int = 0;
         _showData = new Vector.<ExchargeData>(2);
         _loc1_ = 0;
         while(_loc1_ < exchargeData.length)
         {
            if(exchargeData[_loc1_])
            {
               if(!(exchargeData[_loc1_].showEnd < playerModel.nowDate || exchargeData[_loc1_].showStart > playerModel.nowDate))
               {
                  if(exchargeData[_loc1_].type == 196)
                  {
                     _leftVBox.addChild(_exchargeRewardBtn);
                     _showData[0] = exchargeData[_loc1_];
                  }
                  else if(exchargeData[_loc1_].type == 67)
                  {
                     _leftVBox.addChild(_exchargeSingleRewardBtn);
                     _showData[1] = exchargeData[_loc1_];
                  }
               }
            }
            _loc1_++;
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
      
      private function __selectedHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_selectedBtnGroup.getSelectedItem())
         {
            case _exchargeRankBtn:
               __exchargeRankBtnHandler(null);
               break;
            case _exchargeRewardBtn:
               __exchargeRewardBtnHandler(null);
               break;
            case _exchargeSingleRewardBtn:
               __exchargeSingleRewardBtnHandler(null);
               ExchargeRankManager.sendPointMsg();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftVBox);
         _leftVBox = null;
         ObjectUtils.disposeObject(_selectedBtnGroup);
         _selectedBtnGroup = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_exchargeRankBtn);
         _exchargeRankBtn = null;
         ObjectUtils.disposeObject(_exchargeRewardBtn);
         _exchargeRewardBtn = null;
         ObjectUtils.disposeObject(_exchargeSingleRewardBtn);
         _exchargeSingleRewardBtn = null;
         ObjectUtils.disposeObject(_exchargeRankCrossView);
         _exchargeRankCrossView = null;
         ObjectUtils.disposeObject(_exchargeRankRewardView);
         _exchargeRankRewardView = null;
         ObjectUtils.disposeObject(_todayBg);
         _todayBg = null;
         ObjectUtils.disposeObject(_todayCostBmp);
         _todayCostBmp = null;
         ObjectUtils.disposeObject(_totalCountBmp);
         _totalCountBmp = null;
         ObjectUtils.disposeObject(_todayTxtBg);
         _todayTxtBg = null;
         ObjectUtils.disposeObject(_todayTxtBg1);
         _todayTxtBg1 = null;
         ObjectUtils.disposeObject(_myTodayCostText);
         _myTodayCostText = null;
         ObjectUtils.disposeObject(_myTotalCount);
         _myTotalCount = null;
         ObjectUtils.disposeObject(_tipText);
         _tipText = null;
         KeyBoardRegister.instance.keyEnable = true;
         _showData = null;
         _controller.isOpenCrossPayFrame = false;
         _controller = null;
         super.dispose();
      }
   }
}

