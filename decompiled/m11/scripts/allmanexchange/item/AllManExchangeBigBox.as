package allmanexchange.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.allmanexchange.AllManExchangeModel;
   import yishi.manager.AllManExchangeManager;
   import yishi.view.tips.MessageTipManager;
   
   public class AllManExchangeBigBox extends Component
   {
      
      private var _imgBigBox:ScaleFrameImage;
      
      private var _bit0:Bitmap;
      
      private var _txtSingleProgress:FilterFrameText;
      
      private var _txtExchangeCountStr:FilterFrameText;
      
      private var _txtExchangeRemain:FilterFrameText;
      
      private var _bit1:Bitmap;
      
      private var _txtExchangeCount:FilterFrameText;
      
      private var _btnExchange:IconButton;
      
      private var _btnGetAward:IconButton;
      
      private var _progressMc:MovieImage;
      
      private var index:int;
      
      public function AllManExchangeBigBox(param1:int)
      {
         super();
         this.index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _imgBigBox = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.imgBigBox");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.allmanexchange.img1");
         _txtSingleProgress = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.txtSingleProgress");
         _txtExchangeCountStr = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.txtExchangeCountStr");
         _txtExchangeRemain = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.txtExchangeRemain");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.allmanexchange.img7");
         _txtExchangeCount = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.txtExchangeCount");
         _btnExchange = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.btnExchange");
         _btnGetAward = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.btnGetAward");
         _progressMc = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.mcProgress");
         addChild(_progressMc);
         addChild(_imgBigBox);
         addChild(_bit0);
         addChild(_txtSingleProgress);
         addChild(_txtExchangeCountStr);
         addChild(_txtExchangeRemain);
         addChild(_bit1);
         addChild(_txtExchangeCount);
         addChild(_btnExchange);
         addChild(_btnGetAward);
         _imgBigBox.setFrame(1);
         _progressMc.movie.gotoAndStop(1);
         _txtExchangeRemain.text = LanguageMgr.GetTranslation("allmainexchange.str4",1,10);
         _txtExchangeCountStr.text = LanguageMgr.GetTranslation("allmainexchange.str3");
         _txtSingleProgress.text = "12/20";
         _txtExchangeCount.text = "1";
         _btnGetAward.visible = false;
         _imgBigBox.setFrame(index + 1);
      }
      
      public function setProgress(param1:int, param2:int) : void
      {
         var _loc3_:Number = param1 / param2;
         _progressMc.movie.gotoAndStop(int(_loc3_ * 100));
         _txtSingleProgress.text = param1 + "/" + param2;
         if(param1 >= param2)
         {
            _btnExchange.visible = false;
            _btnGetAward.visible = true;
         }
         else
         {
            _btnExchange.visible = true;
            _btnGetAward.visible = false;
         }
      }
      
      public function update() : void
      {
         _txtSingleProgress.text = model.point[index] + "/" + model.changeNeedPoint[index];
         _txtExchangeRemain.text = LanguageMgr.GetTranslation("allmainexchange.str4",model.boxChangeCount[index] - model.exchangeCount[index],model.boxChangeCount[index]);
         if(model.boxChangeCount[index] - model.exchangeCount[index] <= 0)
         {
            _txtExchangeRemain.setFrame(2);
         }
         setProgress(model.point[index],model.changeNeedPoint[index]);
         _imgBigBox.tipData = model.getBigBoxTip(index + 1);
      }
      
      private function addEvent() : void
      {
         _btnGetAward.addEventListener("click",onClickGetAward);
         _btnExchange.addEventListener("click",onClickExchange);
         _txtExchangeCount.addEventListener("change",onTextChange);
      }
      
      private function removeEvent() : void
      {
         _btnGetAward.removeEventListener("click",onClickGetAward);
         _btnExchange.removeEventListener("click",onClickExchange);
         _txtExchangeCount.removeEventListener("change",onTextChange);
      }
      
      private function onTextChange(param1:Event) : void
      {
         var _loc3_:int = Math.max(model.changeNeedPoint[index] - model.point[index],1);
         var _loc2_:int = int(_txtExchangeCount.text);
         if(_loc2_ > _loc3_)
         {
            _txtExchangeCount.text = _loc3_ + "";
         }
      }
      
      protected function onClickExchange(param1:MouseEvent) : void
      {
         var _loc2_:int = model.allChangeCount - model.changeItemCount;
         if(int(_txtExchangeCount.text) > _loc2_ && model.allChangeCount != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("allmainexchange.str7"));
            return;
         }
         if(model.boxChangeCount[index] - model.exchangeCount[index] <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("allmainexchange.str9"));
            return;
         }
         AllManExchangeManager.instance.sendExchangePoint(index,int(_txtExchangeCount.text));
         _txtExchangeCount.text = "1";
      }
      
      protected function onClickGetAward(param1:MouseEvent) : void
      {
         if(model.boxChangeCount[index] - model.exchangeCount[index] <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("allmainexchange.str6"));
            return;
         }
         AllManExchangeManager.instance.sendGetAward(1,index);
      }
      
      private function get model() : AllManExchangeModel
      {
         return AllManExchangeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_imgBigBox);
         _imgBigBox = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_txtSingleProgress);
         _txtSingleProgress = null;
         ObjectUtils.disposeObject(_txtExchangeCountStr);
         _txtExchangeCountStr = null;
         ObjectUtils.disposeObject(_txtExchangeRemain);
         _txtExchangeRemain = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_txtExchangeCount);
         _txtExchangeCount = null;
         ObjectUtils.disposeObject(_btnExchange);
         _btnExchange = null;
         ObjectUtils.disposeObject(_btnGetAward);
         _btnGetAward = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

