package abysm
{
   import abysm.view.AbysmBossView;
   import abysm.view.AbysmChildView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.outyard.AbysmModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.tips.MessageTipManager;
   
   public class AbysmFrame extends Frame implements IManualSize
   {
      
      private var _layerSpr:Sprite;
      
      private var _layerBitData:BitmapData;
      
      private var _leftFilterBg:Bitmap;
      
      private var _rightFilterBg:Bitmap;
      
      private var _setBtn:IconButton;
      
      private var _changeBtn:IconButton;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _currentLayerTxt:FilterFrameText;
      
      private var _maxLayerTxt:FilterFrameText;
      
      private var _childView:AbysmChildView;
      
      private var _bossView:AbysmBossView;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      private var _rewardBg:Bitmap;
      
      private var _rewardTitle:FilterFrameText;
      
      private var _rewardHbox:HBox;
      
      public function AbysmFrame()
      {
         super();
         initView();
         addEvent();
         OutyardManager.instance.abysmModel.isHorrible = false;
         OutyardManager.instance.abysmSendInfo(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,900,613);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _layerSpr = ComponentFactory.Instance.creatCustomObject("abysm.layerSprite");
         _layerBitData = ComponentFactory.Instance.creatBitmapData("asset.abysm.layerNum").clone();
         _leftFilterBg = ComponentFactory.Instance.creatBitmap("asset.abysm.bg3");
         _rightFilterBg = ComponentFactory.Instance.creatBitmap("asset.abysm.bg4");
         _setBtn = ComponentFactory.Instance.creatComponentByStylename("abysm.childSetBtn");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("abysm.chalengeBtn");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("abysm.tipsTxt");
         _currentLayerTxt = ComponentFactory.Instance.creatComponentByStylename("abysm.layerTxt");
         _maxLayerTxt = ComponentFactory.Instance.creatComponentByStylename("abysm.maxLayerTxt");
         _childView = ComponentFactory.Instance.creatCustomObject("abysm.AbysmChildView");
         _bossView = ComponentFactory.Instance.creatCustomObject("abysm.AbysmBossView");
         _rewardBg = ComponentFactory.Instance.creatBitmap("asset.abysm.rewardBg");
         _rewardTitle = ComponentFactory.Instance.creatComponentByStylename("abysm.rewardTitle");
         _rewardHbox = ComponentFactory.Instance.creatComponentByStylename("abysm.rewardHbox");
         addToContent(_layerSpr);
         addToContent(_leftFilterBg);
         addToContent(_rightFilterBg);
         addToContent(_setBtn);
         addToContent(_changeBtn);
         addToContent(_tipsTxt);
         addToContent(_currentLayerTxt);
         addToContent(_maxLayerTxt);
         addToContent(_rewardBg);
         addToContent(_rewardTitle);
         addToContent(_rewardHbox);
         addToContent(_childView);
         addToContent(_bossView);
         _tipsTxt.htmlText = LanguageMgr.GetTranslation("abysm.abysmViewTips01");
         _maxLayerTxt.htmlText = LanguageMgr.GetTranslation("abysm.abysmViewTips02",10);
         _currentLayerTxt.text = "10";
         _rewardTitle.text = LanguageMgr.GetTranslation("HellAbysmFrame.rewardTitle.text");
         var _loc1_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(18);
         if(_loc1_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc1_);
            _bufferView.setDescText(_loc1_.tempInfo.Desc);
            _bufferView.x = 50;
            _bufferView.y = 30;
            addToContent(_bufferView);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("ABYSM_INFO_UPDATA",__updataInfo);
         _setBtn.addEventListener("click",__onChildSetClick);
         _changeBtn.addEventListener("click",__onChangeClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("ABYSM_INFO_UPDATA",__updataInfo);
         if(_setBtn)
         {
            _setBtn.removeEventListener("click",__onChildSetClick);
         }
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",__onChangeClick);
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
      
      private function __updataInfo(param1:NotificationEvent) : void
      {
         _currentLayerTxt.text = String(abysmInfo.bossNum);
         _maxLayerTxt.htmlText = LanguageMgr.GetTranslation("abysm.abysmViewTips02",abysmInfo.maxIndex - 1);
         NumberViewUtils.refreshValue(abysmInfo.currentLayer,_layerSpr,_layerBitData,25,30,19,25,"0123456789");
         if(abysmInfo.is_OverGame)
         {
            _changeBtn.enable = false;
         }
         else
         {
            _changeBtn.enable = true;
         }
         _layerSpr.x = 403 + (62 - _layerSpr.width) * 0.5;
         _childView.upData();
         _bossView.upData();
         if(abysmInfo.sealNum > 0)
         {
            _leftFilterBg.visible = false;
            _rightFilterBg.visible = true;
         }
         else
         {
            _leftFilterBg.visible = true;
            _rightFilterBg.visible = false;
         }
         refreshRewardView();
      }
      
      private function refreshRewardView() : void
      {
         var _loc4_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc2_:CommonDropTempInfo = null;
         var _loc3_:int = 0;
         _rewardHbox.removeAllChild();
         var _loc1_:Array = TempleteManager.instance.abysmDropTempCate.getTemplatesByWave(abysmInfo.index);
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_];
            _loc4_ = ComponentFactory.Instance.creatCustomObject("abysm.rewardItem");
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc2_.itemId;
            _loc5_.count = _loc2_.count;
            _loc4_.data = _loc5_;
            _rewardHbox.addChild(_loc4_);
            _loc3_++;
         }
      }
      
      private function __onChildSetClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childformation",8);
      }
      
      private function __onChangeClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(abysmInfo.is_OverGame)
         {
            _loc2_ = LanguageMgr.GetTranslation("abysm.abysmViewTips04");
            MessageTipManager.instance().show(_loc2_);
         }
         else if(abysmInfo.currentLayer == abysmInfo.maxIndex)
         {
            OutyardManager.instance.abysmSendInfo(3);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("mopup",7);
         }
      }
      
      public function show() : void
      {
         this.titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_abysm");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get abysmInfo() : AbysmModel
      {
         return OutyardManager.instance.abysmModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_layerSpr);
         _layerSpr = null;
         ObjectUtils.disposeObject(_layerBitData);
         _layerBitData = null;
         ObjectUtils.disposeObject(_setBtn);
         _setBtn = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_tipsTxt);
         _tipsTxt = null;
         ObjectUtils.disposeObject(_currentLayerTxt);
         _currentLayerTxt = null;
         ObjectUtils.disposeObject(_maxLayerTxt);
         _maxLayerTxt = null;
         ObjectUtils.disposeObject(_childView);
         _childView = null;
         ObjectUtils.disposeObject(_bossView);
         _bossView = null;
         ObjectUtils.disposeObject(_leftFilterBg);
         _leftFilterBg = null;
         ObjectUtils.disposeObject(_rightFilterBg);
         _rightFilterBg = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_rewardTitle);
         _rewardTitle = null;
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         super.dispose();
      }
   }
}

