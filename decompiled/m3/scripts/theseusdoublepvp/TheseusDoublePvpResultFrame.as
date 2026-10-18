package theseusdoublepvp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpFightResultInfo;
   import theseuspvp.item.TheseusPvpDropItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.TheseusMultiPvpTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.base.ProgressPanel;
   
   public class TheseusDoublePvpResultFrame extends Frame
   {
      
      public var _resultbg:Image;
      
      public var _resultT:ScaleFrameImage;
      
      public var _resultL:ScaleFrameImage;
      
      public var _resultRowIdx:Image;
      
      public var _resultRowStep:Image;
      
      public var _resultSIdx1:FilterFrameText;
      
      public var _resultSIdx2:FilterFrameText;
      
      public var _resultProTxt:FilterFrameText;
      
      public var _resultaddTxt:FilterFrameText;
      
      public var _resultR:ScaleFrameImage;
      
      private var _progress:ProgressPanel;
      
      private var _midbg:Bitmap;
      
      private var _confirmBtn:IconButton;
      
      private var _stepTxt:GradientText;
      
      private var _nextstepTxt2:GradientText;
      
      private var _beforeIcon:ScaleFrameImage;
      
      private var _nextIcon:ScaleFrameImage;
      
      private var _rewardTxt:FilterFrameText;
      
      private var _hbox:HBox;
      
      public function TheseusDoublePvpResultFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _resultbg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultBgImg");
         _midbg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.resultitembg");
         _resultT = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultT");
         _resultL = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultL");
         _resultRowIdx = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultRowIdx");
         _resultRowStep = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultRowStep");
         _resultSIdx1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultSIdx1");
         _resultSIdx2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultSIdx2");
         _resultProTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultProTxt");
         _resultaddTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultaddTxt");
         _resultR = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultR");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultBtn");
         _stepTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultStepTxt");
         _nextstepTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.resultStepTxt2");
         _beforeIcon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.MidStepIcon");
         _nextIcon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.MidStepIcon");
         _hbox = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.droprewardHbox");
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.dropTitle");
         _rewardTxt.text = LanguageMgr.GetTranslation("theseuspvp.dropTitle");
         _progress = new ProgressPanel();
         _progress.initView("asset.theseuspvp.bottomBarBg","asset.theseuspvp.bottomBar","ui.theseuspvp.bottomProTxt");
         _progress.x = 321;
         _progress.y = 300;
         _beforeIcon.y = _nextIcon.y = 214;
         addToContent(_resultbg);
         addToContent(_midbg);
         addToContent(_resultT);
         addToContent(_resultL);
         addToContent(_resultRowIdx);
         addToContent(_resultRowStep);
         addToContent(_resultSIdx1);
         addToContent(_resultSIdx2);
         addToContent(_resultProTxt);
         addToContent(_resultaddTxt);
         addToContent(_resultR);
         addToContent(_progress);
         addToContent(_confirmBtn);
         addToContent(_stepTxt);
         addToContent(_nextstepTxt2);
         addToContent(_beforeIcon);
         addToContent(_nextIcon);
         addToContent(_rewardTxt);
         addToContent(_hbox);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",confirmHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",confirmHandler);
      }
      
      private function confirmHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function show(param1:TheseusDoublePvpFightResultInfo) : void
      {
         if(_closeButton)
         {
            _closeButton.visible = false;
         }
         refreshView(param1);
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function refreshView(param1:TheseusDoublePvpFightResultInfo) : void
      {
         var _loc3_:TheseusMultiPvpTempInfo = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:TheseusPvpDropItem = null;
         var _loc11_:GoodsInfo = null;
         var _loc10_:int = 0;
         var _loc7_:TheseusMultiPvpTempInfo = TempleteManager.instance.theseusMultiPvpTempCate.getTempById(param1.pvpId);
         var _loc9_:TheseusMultiPvpTempInfo = TempleteManager.instance.theseusMultiPvpTempCate.getTempById(param1.lastPvpId);
         if(param1.isWin)
         {
            _resultT.setFrame(1);
            _resultL.setFrame(1);
            _resultR.setFrame(1);
            _resultaddTxt.setFrame(1);
         }
         else
         {
            _resultT.setFrame(2);
            _resultL.setFrame(2);
            _resultR.setFrame(2);
            _resultaddTxt.setFrame(2);
         }
         _nextIcon.visible = false;
         _resultRowStep.visible = false;
         _nextstepTxt2.visible = false;
         _beforeIcon.x = 458;
         _resultSIdx1.text = LanguageMgr.GetTranslation("theseuspvp.result.sort",param1.lastRank);
         _resultSIdx2.text = "" + param1.rank;
         var _loc2_:int = param1.integral - param1.lastIntegral;
         var _loc8_:String = _loc2_ > 0 ? "+" + _loc2_ : "" + _loc2_;
         if(param1.keepWinIntegral > 0)
         {
            _loc8_ += LanguageMgr.GetTranslation("theseuspvp.result.add",param1.keepWin,param1.keepWinIntegral);
         }
         _resultaddTxt.htmlText = _loc8_;
         if(_loc7_)
         {
            _stepTxt.x = 358;
            _stepTxt.text = _loc7_.Name;
            _beforeIcon.setFrame(_loc7_.MainType);
            _loc3_ = TempleteManager.instance.theseusMultiPvpTempCate.getTempByType(_loc7_.MainType,_loc7_.SonType + 1);
            if(_loc3_ == null)
            {
               _loc3_ = TempleteManager.instance.theseusMultiPvpTempCate.getTempByType(_loc7_.MainType + 1,1);
            }
            if(_loc3_)
            {
               if(param1.pvpId != param1.lastPvpId)
               {
                  _nextIcon.visible = true;
                  _nextstepTxt2.visible = true;
                  _resultRowStep.visible = true;
                  _beforeIcon.x = 343;
                  _nextIcon.x = 570;
                  _stepTxt.text = _loc9_.Name;
                  _beforeIcon.setFrame(_loc9_.MainType);
                  _nextIcon.setFrame(_loc7_.MainType);
                  _nextstepTxt2.text = _loc7_.Name;
                  _stepTxt.x = 243;
               }
               _progress.progressValue(param1.integral,_loc3_.NeedIntegral);
            }
            else
            {
               _stepTxt.text = _loc7_.Name;
               _progress.showMax();
               _progress.setValueText(param1.integral + "/" + _loc7_.NeedIntegral);
            }
         }
         if(param1.rewardInfo != null && param1.rewardInfo.length > 2)
         {
            _loc4_ = param1.rewardInfo.split("|");
            _hbox.beginChanges();
            _loc10_ = 0;
            while(_loc10_ < _loc4_.length)
            {
               _loc5_ = _loc4_[_loc10_].split(",");
               if(_loc5_ && _loc5_.length == 2)
               {
                  _loc11_ = new GoodsInfo();
                  _loc11_.templateId = int(_loc5_[0]);
                  _loc11_.count = int(_loc5_[1]);
                  _loc6_ = new TheseusPvpDropItem();
                  _loc6_.data = _loc11_;
                  _hbox.addChild(_loc6_);
               }
               _loc10_++;
            }
            _hbox.commitChanges();
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
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_resultbg);
         _resultbg = null;
         ObjectUtils.disposeObject(_resultT);
         _resultT = null;
         ObjectUtils.disposeObject(_resultL);
         _resultL = null;
         ObjectUtils.disposeObject(_resultRowIdx);
         _resultRowIdx = null;
         ObjectUtils.disposeObject(_resultRowStep);
         _resultRowStep = null;
         ObjectUtils.disposeObject(_resultSIdx1);
         _resultSIdx1 = null;
         ObjectUtils.disposeObject(_resultSIdx2);
         _resultSIdx2 = null;
         ObjectUtils.disposeObject(_resultProTxt);
         _resultProTxt = null;
         ObjectUtils.disposeObject(_resultaddTxt);
         _resultaddTxt = null;
         ObjectUtils.disposeObject(_resultR);
         _resultR = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_stepTxt);
         _stepTxt = null;
         ObjectUtils.disposeObject(_nextstepTxt2);
         _nextstepTxt2 = null;
         ObjectUtils.disposeObject(_beforeIcon);
         _beforeIcon = null;
         ObjectUtils.disposeObject(_nextIcon);
         _nextIcon = null;
         super.dispose();
      }
   }
}

