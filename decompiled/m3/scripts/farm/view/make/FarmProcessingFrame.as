package farm.view.make
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   
   public class FarmProcessingFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg2:Bitmap;
      
      private var _hBox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _feedBtn:SelectedButton;
      
      private var _otherBtn:SelectedButton;
      
      private var _processBtn:IconButton;
      
      private var _plusImg0:CustomBitmap;
      
      private var _plusImg1:CustomBitmap;
      
      private var _itemBg0:CustomBitmap;
      
      private var _itemBg1:CustomBitmap;
      
      private var _itemBg2:CustomBitmap;
      
      private var _itemBg3:CustomBitmap;
      
      private var _lockImg:CustomBitmap;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _numBgImg:Image;
      
      private var _inputTxt:FilterFrameText;
      
      private var _needGoldImg:CustomBitmap;
      
      private var _needGoldTxt:FilterFrameText;
      
      private var _processTipsImg:Bitmap;
      
      public function FarmProcessingFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("farm.FarmProcessingFrame.title");
         _btnGroup = new SelectedButtonGroup();
         _bg = ComponentFactory.Instance.creatComponentByStylename("farm.FarmProcessingFrame.BG");
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.farm.make.processingFrameBg");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("farm.makeFrame.btnHbox");
         _feedBtn = ComponentFactory.Instance.creatComponentByStylename("farm.processingFrame.FeedBtn");
         _otherBtn = ComponentFactory.Instance.creatComponentByStylename("farm.processingFrame.OtherBtn");
         _processBtn = ComponentFactory.Instance.creatComponentByStylename("FarmProcessingFrame.processBtn");
         _plusImg0 = ComponentFactory.Instance.creatCustomObject("farm.process.plusImg0");
         _plusImg1 = ComponentFactory.Instance.creatCustomObject("farm.process.plusImg1");
         _itemBg0 = ComponentFactory.Instance.creatCustomObject("farm.process.ItemBg0");
         _itemBg1 = ComponentFactory.Instance.creatCustomObject("farm.process.ItemBg1");
         _itemBg2 = ComponentFactory.Instance.creatCustomObject("farm.process.ItemBg2");
         _itemBg3 = ComponentFactory.Instance.creatCustomObject("farm.process.ItemBg3");
         _lockImg = ComponentFactory.Instance.creatCustomObject("farm.process.LockImg");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("farm.process.ComposePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("farm.process.ComposeNextPageBtn");
         _numBgImg = ComponentFactory.Instance.creatComponentByStylename("farm.process.ComposeMatetialView.NumBg");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("farm.process.ComposeGoodsNumTxt");
         _needGoldImg = ComponentFactory.Instance.creatCustomObject("farm.process.NeedGoldImg");
         _needGoldTxt = ComponentFactory.Instance.creatComponentByStylename("farm.process.NeedGoldNumTxt");
         _needGoldTxt.text = "10000";
         _processTipsImg = ComponentFactory.Instance.creatBitmap("asset.farm.make.processTipsImg");
         _hBox.addChild(_feedBtn);
         _hBox.addChild(_otherBtn);
         _btnGroup.addSelectItem(_feedBtn);
         _btnGroup.addSelectItem(_otherBtn);
         addToContent(_bg);
         addToContent(_bg2);
         addToContent(_hBox);
         addToContent(_processBtn);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_numBgImg);
         addToContent(_inputTxt);
         addToContent(_needGoldImg);
         addToContent(_needGoldTxt);
         addToContent(_plusImg0);
         addToContent(_plusImg1);
         addToContent(_itemBg0);
         addToContent(_itemBg1);
         addToContent(_itemBg2);
         addToContent(_itemBg3);
         addToContent(_lockImg);
         addToContent(_processTipsImg);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_frameResponse);
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         _btnGroup.selectIndex = 0;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_processBtn);
         _processBtn = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_numBgImg);
         _numBgImg = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_needGoldImg);
         _needGoldImg = null;
         ObjectUtils.disposeObject(_needGoldTxt);
         _needGoldTxt = null;
         ObjectUtils.disposeObject(_plusImg0);
         _plusImg0 = null;
         ObjectUtils.disposeObject(_plusImg1);
         _plusImg1 = null;
         ObjectUtils.disposeObject(_itemBg0);
         _itemBg0 = null;
         ObjectUtils.disposeObject(_itemBg1);
         _itemBg1 = null;
         ObjectUtils.disposeObject(_itemBg2);
         _itemBg2 = null;
         ObjectUtils.disposeObject(_itemBg3);
         _itemBg3 = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         ObjectUtils.disposeObject(_processTipsImg);
         _processTipsImg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

